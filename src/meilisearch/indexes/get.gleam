import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import meilisearch/client.{type Credentials}
import meilisearch/index.{type Index}
import meilisearch/internal/index as internal_index
import meilisearch/internal/request as meilisearch_request
import meilisearch/internal/response.{type MeilisearchResponseError} as meilisearch_response

/// Get information about an index.
/// https://www.meilisearch.com/docs/reference/api/indexes#get-one-index
pub fn request(credentials: Credentials, uid: String) -> Request(String) {
  client.new(credentials) |> meilisearch_request.get("/indexes/" <> uid)
}

/// Decodes the response from the request.
pub fn handle_response(
  response: Response(String),
) -> Result(Index, MeilisearchResponseError) {
  meilisearch_response.handle_response(response, internal_index.index_decoder())
}
