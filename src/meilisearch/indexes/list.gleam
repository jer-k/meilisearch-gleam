import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import meilisearch/client.{type Credentials}
import meilisearch/index.{type Index}
import meilisearch/internal/index as internal_index
import meilisearch/internal/request as meilisearch_request
import meilisearch/internal/response.{
  type MeilisearchListResponse, type MeilisearchResponseError,
} as meilisearch_response

/// List all indexes. Results can be paginated by using the offset and limit query parameters.
/// https://www.meilisearch.com/docs/reference/api/indexes#list-all-indexes
pub fn request(credentials: Credentials) -> Request(String) {
  client.new(credentials) |> meilisearch_request.get("/indexes")
}

/// Decodes the response from the request.
pub fn handle_response(
  response: Response(String),
) -> Result(MeilisearchListResponse(Index), MeilisearchResponseError) {
  meilisearch_response.handle_list_response(
    response,
    internal_index.index_decoder(),
  )
}
