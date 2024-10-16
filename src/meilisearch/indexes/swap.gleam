import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/json
import gleam/list
import meilisearch/client.{type Credentials}
import meilisearch/internal/request as meilisearch_request
import meilisearch/internal/response.{type MeilisearchResponseError} as meilisearch_response
import meilisearch/internal/task as internal_task
import meilisearch/task.{type Task}

/// Pair of index UIDs to be swapped
pub type SwapIndexPair {
  SwapIndexPair(a: String, b: String)
}

/// List of SwapIndexPairs to be passed into #swap_indexes
pub type SwapIndexList {
  SwapIndexList(indexes: List(SwapIndexPair))
}

/// Helper function to create a SwapIndexList from a list of list of index UIDs
/// Can be used like #create_swap_index_list([["indexA", "indexB"], ["indexX", "indexY"]])
pub fn create_swap_index_list(
  indexes_list: List(List(String)),
) -> Result(SwapIndexList, String) {
  let index_pair_list =
    indexes_list
    |> list.try_map(fn(pair) {
      case pair {
        [a, b] -> Ok(SwapIndexPair(a, b))
        _ -> Error("Each inner list must contain exactly two strings")
      }
    })

  case index_pair_list {
    Ok(index_pair_list) -> Ok(SwapIndexList(index_pair_list))
    Error(err) -> Error(err)
  }
}

/// Swap the documents, settings, and task history of two or more indexes. You can only swap indexes in pairs.
/// However, a single request can swap as many index pairs as you wish.
/// https://www.meilisearch.com/docs/reference/api/indexes#swap-indexes
pub fn request(
  credentials: Credentials,
  swap_list: SwapIndexList,
) -> Request(String) {
  let body =
    swap_list.indexes
    |> list.map(fn(pair) {
      json.object([#("indexes", json.array([pair.a, pair.b], of: json.string))])
    })
    |> json.preprocessed_array
    |> json.to_string

  client.new(credentials)
  |> meilisearch_request.post("/swap-indexes", body)
}

/// Decodes the response from the request.
pub fn handle_response(
  response: Response(String),
) -> Result(Task, MeilisearchResponseError) {
  meilisearch_response.handle_response(response, internal_task.task_decoder())
}
