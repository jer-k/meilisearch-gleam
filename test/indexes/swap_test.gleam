import gleam/http
import gleam/http/response.{Response}
import gleam/json
import gleeunit/should
import helpers
import meilisearch/indexes/swap
import meilisearch/task.{Enqueued, IndexSwap}

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

pub fn handle_response_test() {
  let body =
    json.object([
      #("taskUid", json.int(3)),
      #("indexUid", json.null()),
      #("status", json.string("enqueued")),
      #("type", json.string("indexSwap")),
      #("enqueuedAt", json.string("2021-08-12T10:00:00.000000Z")),
    ])
    |> json.to_string

  let response = Response(status: 202, body: body, headers: [])
  let assert Ok(task) = swap.handle_response(response)

  task.status
  |> should.equal(Enqueued)
  task.task_type |> should.equal(IndexSwap)
}
