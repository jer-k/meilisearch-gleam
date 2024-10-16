import gleam/http
import gleam/option
import gleeunit/should
import helpers
import meilisearch/indexes/update

pub fn request_test() {
  let request = update.request(helpers.credentials, "movies", option.Some("id"))

  request.path |> should.equal("/indexes/movies")
  request.method |> should.equal(http.Patch)
  request.body
  |> should.equal("{\"primaryKey\":\"id\"}")
}
