import gleam/http
import gleam/http/response.{Response}
import gleam/json
import gleeunit/should
import helpers
import meilisearch/indexes/delete
import meilisearch/task.{Enqueued, IndexDeletion}

pub fn delete_index_test() {
  let request = delete.request(helpers.credentials, "movies")

  request.path |> should.equal("/indexes/movies")
  request.method |> should.equal(http.Delete)
}

pub fn handle_response_test() {
  let body =
    json.object([
      #("taskUid", json.int(1)),
      #("indexUid", json.string("movies")),
      #("status", json.string("enqueued")),
      #("type", json.string("indexDeletion")),
      #("enqueuedAt", json.string("2021-08-12T10:00:00.000000Z")),
    ])
    |> json.to_string

  let response = Response(status: 202, body: body, headers: [])
  let assert Ok(task) = delete.handle_response(response)

  task.status
  |> should.equal(Enqueued)
  task.task_type |> should.equal(IndexDeletion)
}
