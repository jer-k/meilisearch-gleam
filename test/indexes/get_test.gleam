import gleam/http/response.{Response}
import gleam/json
import gleeunit/should
import helpers
import meilisearch/indexes/get

pub fn request_test() {
  let request = get.request(helpers.credentials, "movies")

  request.path |> should.equal("/indexes/movies")
}

pub fn handle_response_test() {
  let body =
    json.object([
      #("uid", json.string("movies")),
      #("createdAt", json.string("2022-02-10T07:45:15.628261Z")),
      #("updatedAt", json.string("2022-02-21T15:28:43.496574Z")),
      #("primaryKey", json.string("id")),
    ])
    |> json.to_string

  let response = Response(status: 200, body: body, headers: [])
  let assert Ok(index) = get.handle_response(response)

  index.uid |> should.equal("movies")
}
