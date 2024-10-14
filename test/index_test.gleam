import gleam/http
import gleam/option
import gleeunit/should
import helpers
import meilisearch/index

pub fn indexes_test() {
  let request = index.indexes(helpers.credentials)

  request.path |> should.equal("/indexes")
}

pub fn fetch_info_test() {
  let request = index.fetch_info(helpers.credentials, "movies")

  request.path |> should.equal("/indexes/movies")
}

pub fn create_index_test() {
  let request =
    index.create_index(helpers.credentials, "movies", option.Some("id"))

  request.path |> should.equal("/indexes")
  request.method |> should.equal(http.Post)
  request.body
  |> should.equal("{\"uid\":\"movies\",\"primaryKey\":\"id\"}")
}

pub fn update_index_test() {
  let request =
    index.update_index(helpers.credentials, "movies", option.Some("id"))

  request.path |> should.equal("/indexes/movies")
  request.method |> should.equal(http.Patch)
  request.body
  |> should.equal("{\"primaryKey\":\"id\"}")
}

pub fn delete_index_test() {
  let request = index.delete_index(helpers.credentials, "movies")

  request.path |> should.equal("/indexes/movies")
  request.method |> should.equal(http.Delete)
}

pub fn create_swap_index_list_test() {
  let assert Ok(swap_index_list) =
    index.create_swap_index_list([["indexA", "indexB"], ["indexX", "indexY"]])

  swap_index_list.indexes
  |> should.equal([
    index.SwapIndexPair("indexA", "indexB"),
    index.SwapIndexPair("indexX", "indexY"),
  ])
}

pub fn create_swap_index_list_error_test() {
  index.create_swap_index_list([["indexA", "indexB", "indexC"]])
  |> should.be_error
}

pub fn swap_indexes_test() {
  let assert Ok(swap_index_list) =
    index.create_swap_index_list([["indexA", "indexB"], ["indexX", "indexY"]])
  let request = index.swap_indexes(helpers.credentials, swap_index_list)

  request.path |> should.equal("/swap-indexes")
  request.method |> should.equal(http.Post)
  request.body
  |> should.equal(
    "[{\"indexes\":[\"indexA\",\"indexB\"]},{\"indexes\":[\"indexX\",\"indexY\"]}]",
  )
}

pub fn response_test() {
  todo
}
