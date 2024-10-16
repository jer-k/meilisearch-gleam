import gleeunit/should
import helpers
import meilisearch/indexes/list

pub fn request_test() {
  let request = list.request(helpers.credentials)

  request.path |> should.equal("/indexes")
}
