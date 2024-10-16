import decode.{type Decoder}
import gleam/dynamic.{type Dynamic}
import gleam/http/response.{type Response}
import gleam/json
import meilisearch/error.{type Error}

pub type MeilisearchListResponse(a) {
  MeilisearchListResponse(results: List(a), offset: Int, limit: Int, total: Int)
}

pub type MeilisearchResponseError {
  MeilisearchError(Error)
  JSONDecodeError(json.DecodeError)
  DynamicDecodeError(List(dynamic.DecodeError))
  UnknownRoute
}

pub fn handle_response(
  response: Response(String),
  decoder: Decoder(a),
) -> Result(a, MeilisearchResponseError) {
  case response.status {
    status if status >= 200 && status < 300 -> {
      case decode_body(response.body) {
        Ok(decoded_body) -> {
          case object_decoder(decoded_body, decoder) {
            Ok(record) -> Ok(record)
            Error(err) -> Error(err)
          }
        }
        Error(err) -> Error(JSONDecodeError(err))
      }
    }
    _ -> {
      case decode_body(response.body) {
        Ok(decoded_body) -> {
          case object_decoder(decoded_body, error.error_decoder()) {
            Ok(decoded_error) -> Error(MeilisearchError(decoded_error))
            Error(err) -> Error(err)
          }
        }
        Error(err) -> Error(JSONDecodeError(err))
      }
    }
  }
}

pub fn handle_list_response(response: Response(String), decoder: Decoder(a)) {
  case response.status {
    200 -> {
      case decode_body(response.body) {
        Ok(decoded_body) -> {
          case list_decoder(decoded_body, decoder) {
            Ok(list) -> Ok(list)
            Error(err) -> Error(err)
          }
        }
        Error(err) -> Error(JSONDecodeError(err))
      }
    }
    _ -> {
      case decode_body(response.body) {
        Ok(decoded_body) -> {
          case object_decoder(decoded_body, error.error_decoder()) {
            Ok(decoded_error) -> Error(MeilisearchError(decoded_error))
            Error(err) -> Error(err)
          }
        }
        Error(err) -> Error(JSONDecodeError(err))
      }
    }
  }
}

fn decode_body(body: String) -> Result(Dynamic, json.DecodeError) {
  case json.decode(body, dynamic.dynamic) {
    Ok(decoded) -> Ok(decoded)
    Error(err) -> Error(err)
  }
}

fn object_decoder(
  body: Dynamic,
  decoder: Decoder(a),
) -> Result(a, MeilisearchResponseError) {
  case decode.from(decoder, body) {
    Ok(decoded) -> Ok(decoded)
    Error(errors) -> Error(DynamicDecodeError(errors))
  }
}

fn list_decoder(
  body: Dynamic,
  decoder: Decoder(a),
) -> Result(MeilisearchListResponse(a), MeilisearchResponseError) {
  let list_decoder =
    decode.into({
      use results <- decode.parameter
      use offset <- decode.parameter
      use limit <- decode.parameter
      use total <- decode.parameter
      MeilisearchListResponse(
        results: results,
        offset: offset,
        limit: limit,
        total: total,
      )
    })
    |> decode.field("results", decode.list(decoder))
    |> decode.field("offset", decode.int)
    |> decode.field("limit", decode.int)
    |> decode.field("total", decode.int)

  case decode.from(list_decoder, body) {
    Ok(decoded) -> Ok(decoded)
    Error(errors) -> Error(DynamicDecodeError(errors))
  }
}
