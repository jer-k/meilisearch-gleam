import gleam/http
import gleeunit/should
import helpers
import meilisearch/indexes/swap

pub fn create_swap_index_list_test() {
  let assert Ok(swap_index_list) =
    swap.create_swap_index_list([["indexA", "indexB"], ["indexX", "indexY"]])

  swap_index_list.indexes
  |> should.equal([
    swap.SwapIndexPair("indexA", "indexB"),
    swap.SwapIndexPair("indexX", "indexY"),
  ])
}

pub fn create_swap_index_list_error_test() {
  swap.create_swap_index_list([["indexA", "indexB", "indexC"]])
  |> should.be_error
}

pub fn swap_indexes_test() {
  let assert Ok(swap_index_list) =
    swap.create_swap_index_list([["indexA", "indexB"], ["indexX", "indexY"]])
  let request = swap.request(helpers.credentials, swap_index_list)

  request.path |> should.equal("/swap-indexes")
  request.method |> should.equal(http.Post)
  request.body
  |> should.equal(
    "[{\"indexes\":[\"indexA\",\"indexB\"]},{\"indexes\":[\"indexX\",\"indexY\"]}]",
  )
}
