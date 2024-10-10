/// Meilisearch errors can be of one of the following types:
/// See [Errors](https://www.meilisearch.com/docs/reference/errors/overview#errors) for details of each type
import decode.{type Decoder}

pub type ErrorType {
  InvalidRequest
  Internal
  Auth
  System
}

pub fn error_type_decoder() -> Decoder(ErrorType) {
  decode.string
  |> decode.then(fn(decoded_string) {
    case decoded_string {
      "invalid_request" -> decode.into(InvalidRequest)
      "internal" -> decode.into(Internal)
      "auth" -> decode.into(Auth)
      "system" -> decode.into(System)
      _ -> decode.fail("Unknown ErrorType: " <> decoded_string)
    }
  })
}
