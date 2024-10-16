import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/json
import gleam/option.{type Option}
import meilisearch/client.{type Credentials}
import meilisearch/internal/request as meilisearch_request
import meilisearch/internal/response.{type MeilisearchResponseError} as meilisearch_response
import meilisearch/internal/task as internal_task
import meilisearch/task.{type Task}

/// Create an index.
/// https://www.meilisearch.com/docs/reference/api/indexes#create-an-index
pub fn request(
  credentials: Credentials,
  uid: String,
  primary_key: Option(String),
) -> Request(String) {
  let body =
    json.object([
      #("uid", json.string(uid)),
      #("primaryKey", case primary_key {
        option.Some(key) -> json.string(key)
        option.None -> json.null()
      }),
    ])
    |> json.to_string

  client.new(credentials)
  |> meilisearch_request.post("/indexes", body)
}

/// Decodes the response from the request.
pub fn handle_response(
  response: Response(String),
) -> Result(Task, MeilisearchResponseError) {
  meilisearch_response.handle_response(response, internal_task.task_decoder())
}
