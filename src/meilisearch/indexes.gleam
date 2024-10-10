import decode
import gleam/http/request.{type Request, Request}
import gleam/http/response.{type Response}
import gleam/option.{type Option}
import meilisearch/client
import meilisearch/request as meilisearch_request
import meilisearch/response as meilisearch_response

pub opaque type Index {
  Index(
    uid: String,
    primary_key: Option(String),
    created_at: String,
    updated_at: String,
  )
}

pub fn indexes() -> Request(String) {
  client.new() |> meilisearch_request.get("/indexes")
}

pub fn fetch_info(index_uid: String) {
  client.new() |> meilisearch_request.get("/indexes/" <> index_uid)
}

pub fn fetch_primary_key(index_uid: String) {
  client.new() |> meilisearch_request.get("/indexes/" <> index_uid)
}

pub fn response(response: Response(String)) {
  meilisearch_response.handle_response(response, index_decoder())
}

fn index_decoder() {
  decode.into({
    use uid <- decode.parameter
    use primary_key <- decode.parameter
    use created_at <- decode.parameter
    use updated_at <- decode.parameter
    Index(
      uid: uid,
      primary_key: primary_key,
      created_at: created_at,
      updated_at: updated_at,
    )
  })
  |> decode.field("uid", decode.string)
  |> decode.field("primaryKey", decode.optional(decode.string))
  |> decode.field("createdAt", decode.string)
  |> decode.field("updatedAt", decode.string)
}
