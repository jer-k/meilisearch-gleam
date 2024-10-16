import gleeunit/should
import helpers
import meilisearch/indexes/get

pub fn request_test() {
  let request = get.request(helpers.credentials, "movies")

  request.path |> should.equal("/indexes/movies")
}
