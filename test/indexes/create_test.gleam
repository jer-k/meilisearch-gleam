import gleam/http
import gleam/option
import gleeunit/should
import helpers
import meilisearch/indexes/create

pub fn request_test() {
  let request = create.request(helpers.credentials, "movies", option.Some("id"))

  request.path |> should.equal("/indexes")
  request.method |> should.equal(http.Post)
  request.body
  |> should.equal("{\"uid\":\"movies\",\"primaryKey\":\"id\"}")
}
