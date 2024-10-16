import gleam/http
import gleam/http/response.{Response}
import gleam/json
import gleam/option
import gleeunit/should
import helpers
import meilisearch/indexes/create
import meilisearch/task.{Enqueued, IndexCreation}

pub fn request_test() {
  let request = create.request(helpers.credentials, "movies", option.Some("id"))

  request.path |> should.equal("/indexes")
  request.method |> should.equal(http.Post)
  request.body
  |> should.equal("{\"uid\":\"movies\",\"primaryKey\":\"id\"}")
}

pub fn handle_response_test() {
  let body =
    json.object([
      #("taskUid", json.int(0)),
      #("indexUid", json.string("movies")),
      #("status", json.string("enqueued")),
      #("type", json.string("indexCreation")),
      #("enqueuedAt", json.string("2021-08-12T10:00:00.000000Z")),
    ])
    |> json.to_string

  let response = Response(status: 202, body: body, headers: [])
  let assert Ok(task) = create.handle_response(response)

  task.status
  |> should.equal(Enqueued)
  task.task_type |> should.equal(IndexCreation)
}
