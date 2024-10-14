import decode
import gleam/http
import gleam/http/request.{type Request, Request}
import gleam/http/response.{type Response}
import gleam/json
import gleam/list
import gleam/option.{type Option}
import gleam/string
import meilisearch/client.{type Credentials}
import meilisearch/request as meilisearch_request
import meilisearch/response.{UnknownRoute} as meilisearch_response
import meilisearch/task

import gleam/io

pub type IndexResponse {
  Index(
    uid: String,
    primary_key: Option(String),
    created_at: String,
    updated_at: String,
  )
  IndexList(results: List(IndexResponse), offset: Int, limit: Int, total: Int)
  Task(x: Int)
}

/// List all indexes. Results can be paginated by using the offset and limit query parameters.
/// https://www.meilisearch.com/docs/reference/api/indexes#list-all-indexes
pub fn indexes(credentials: Credentials) -> Request(String) {
  client.new(credentials) |> meilisearch_request.get("/indexes")
}

/// Get information about an index.
/// https://www.meilisearch.com/docs/reference/api/indexes#get-one-index
pub fn fetch_info(credentials: Credentials, uid: String) {
  client.new(credentials) |> meilisearch_request.get("/indexes/" <> uid)
}

/// Create an index.
/// https://www.meilisearch.com/docs/reference/api/indexes#create-an-index
pub fn create_index(
  credentials: Credentials,
  uid: String,
  primary_key: Option(String),
) {
  let body =
    json.object([
      #("uid", json.string(uid)),
      #("primaryKey", case primary_key {
        option.Some(key) -> json.string(key)
        option.None -> json.null()
      }),
    ])
    |> json.to_string

  client.new(credentials)
  |> meilisearch_request.post("/indexes", body)
}

/// Update an index's primary key. You can freely update the primary key of an index as long as it contains no documents.
///https://www.meilisearch.com/docs/reference/api/indexes#update-an-index
pub fn update_index(
  credentials: Credentials,
  uid: String,
  primary_key: Option(String),
) {
  let body =
    json.object([
      #("primaryKey", case primary_key {
        option.Some(key) -> json.string(key)
        option.None -> json.null()
      }),
    ])
    |> json.to_string

  client.new(credentials)
  |> meilisearch_request.patch("/indexes/" <> uid, body)
}

/// Delete an index.
/// https://www.meilisearch.com/docs/reference/api/indexes#delete-an-index
pub fn delete_index(credentials: Credentials, uid: String) {
  client.new(credentials) |> meilisearch_request.delete("/indexes/" <> uid)
}

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
pub fn swap_indexes(credentials: Credentials, swap_list: SwapIndexList) {
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

pub fn response(request: Request(String), response: Response(String)) {
  case string.split(request.path, on: "/"), request.method {
    ["", "indexes"], http.Get ->
      meilisearch_response.handle_list_response(response, index_decoder())
    ["", "indexes", _], http.Get ->
      meilisearch_response.handle_response(response, index_decoder())
    // ["", "indexes"], http.Post ->
    //   meilisearch_response.handle_response(response, task.task_decoder())
    // ["", "indexes", _], http.Patch ->
    //   meilisearch_response.handle_response(response, task.task_decoder())
    // ["", "indexes", _], http.Delete ->
    //   meilisearch_response.handle_response(response, task.task_decoder())
    // ["", "swap-indexes"], http.Post ->
    //   meilisearch_response.handle_response(response, task.task_decoder())
    _, _ -> Error(UnknownRoute)
  }
}

fn index_decoder() {
  decode.into({
    use uid <- decode.parameter
    use primary_key <- decode.parameter
    use created_at <- decode.parameter
    use updated_at <- decode.parameter
    Index(
      uid: uid,
      primary_key: primary_key,
      created_at: created_at,
      updated_at: updated_at,
    )
  })
  |> decode.field("uid", decode.string)
  |> decode.field("primaryKey", decode.optional(decode.string))
  |> decode.field("createdAt", decode.string)
  |> decode.field("updatedAt", decode.string)
}
