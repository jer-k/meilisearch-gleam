import decode
import gleam/dynamic.{type Dynamic}
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/json
import gleam/list
import gleam/option.{type Option}
import meilisearch/client.{type Credentials}
import meilisearch/internal/request as meilisearch_request
import meilisearch/internal/response.{
  type MeilisearchListResponse, type MeilisearchResponseError,
} as meilisearch_response

pub type DocumentListOptions {
  DocumentListOptions(
    offset: Option(Int),
    limit: Option(Int),
    fields: Option(String),
    filter: Option(String),
    retrieve_vectors: Option(Bool),
  )
}

/// Create an index.
/// https://www.meilisearch.com/docs/reference/api/indexes#create-an-index
pub fn request(
  credentials: Credentials,
  index_uid: String,
  list_options: DocumentListOptions,
) -> Request(String) {
  client.new(credentials)
  |> meilisearch_request.post(
    "/indexes/" <> index_uid <> "/documents/fetch",
    search_options_encoder(list_options),
  )
}

/// Decodes the response from the request.
pub fn handle_response(
  response: Response(String),
) -> Result(MeilisearchListResponse(Dynamic), MeilisearchResponseError) {
  meilisearch_response.handle_list_response(response, decode.dynamic)
}

fn search_options_encoder(list_options: DocumentListOptions) -> String {
  let base_fields = [
    option.map(list_options.offset, fn(v) { #("offset", json.int(v)) }),
    option.map(list_options.limit, fn(v) { #("limit", json.int(v)) }),
    option.map(list_options.filter, fn(v) { #("fields", json.string(v)) }),
    option.map(list_options.filter, fn(v) { #("filter", json.string(v)) }),
    option.map(list_options.retrieve_vectors, fn(v) {
      #("retrieveVectors", json.bool(v))
    }),
  ]

  base_fields
  |> list.filter_map(fn(field) { option.to_result(field, "omitted") })
  |> json.object
  |> json.to_string
}
