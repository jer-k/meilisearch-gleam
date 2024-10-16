import gleam/http
import gleeunit/should
import helpers
import meilisearch/indexes/delete

pub fn delete_index_test() {
  let request = delete.request(helpers.credentials, "movies")

  request.path |> should.equal("/indexes/movies")
  request.method |> should.equal(http.Delete)
}
