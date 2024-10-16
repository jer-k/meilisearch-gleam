import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import meilisearch/client.{type Credentials}
import meilisearch/internal/request as meilisearch_request
import meilisearch/internal/response.{type MeilisearchResponseError} as meilisearch_response
import meilisearch/internal/task as internal_task
import meilisearch/task.{type Task}

/// Delete an index.
/// https://www.meilisearch.com/docs/reference/api/indexes#delete-an-index
pub fn request(credentials: Credentials, uid: String) -> Request(String) {
  client.new(credentials) |> meilisearch_request.delete("/indexes/" <> uid)
}

/// Decodes the response from the request.
pub fn handle_response(
  response: Response(String),
) -> Result(Task, MeilisearchResponseError) {
  meilisearch_response.handle_response(response, internal_task.task_decoder())
}
