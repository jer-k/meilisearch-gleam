import decode.{type Decoder}
import gleam/dynamic.{type Dynamic}
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/json
import gleam/list
import gleam/option.{type Option}
import meilisearch/client.{type Credentials}
import meilisearch/internal/request as meilisearch_request
import meilisearch/internal/response.{type MeilisearchResponseError} as meilisearch_response

pub type SearchOptions {
  SearchOptions(
    query: Option(String),
    offset: Option(Int),
    limit: Option(Int),
    hits_per_page: Option(Int),
    page: Option(Int),
    filter: Option(String),
    facets: Option(List(String)),
    attributes_to_retrieve: Option(List(String)),
    attributes_to_crop: Option(List(String)),
    crop_length: Option(Int),
    crop_marker: Option(String),
    attributes_to_highlight: Option(List(String)),
    highlight_pre_tag: Option(String),
    highlight_post_tag: Option(String),
    show_matches_position: Option(Bool),
    sort: Option(List(String)),
    matching_strategy: Option(MatchingStrategy),
    show_ranking_score: Option(Bool),
    show_ranking_score_details: Option(Bool),
    ranking_score_threshold: Option(Float),
    attributes_to_search_on: Option(List(String)),
    hybrid: Option(HybridSearchOptions),
    vector: Option(List(Float)),
    retrieve_vectors: Option(Bool),
    locales: Option(List(String)),
    distinct: Option(String),
    //federation_options: Option(SearchFederationOptions),
  )
}

pub type MatchingStrategy {
  /// Last returns documents containing all the query terms first. If there are not enough results containing all
  /// query terms to meet the requested limit, Meilisearch will remove one query term at a time,
  /// starting from the end of the query.
  Last
  /// All only returns documents that contain all query terms. Meilisearch will not match any more documents even
  /// if there aren't enough to meet the requested limit.
  All
  /// Frequency returns documents containing all the query terms first. If there are not enough results containing
  /// all query terms to meet the requested limit, Meilisearch will remove one query term at a time, starting
  /// with the word that is the most frequent in the dataset. frequency effectively gives more weight to terms
  /// that appear less frequently in a set of results.
  Frequency
}

pub type HybridSearchOptions {
  HybridSearchOptions(semantic_ratio: Option(Float), embedder: Option(String))
}

pub type SearchResponse {
  SearchResponse(
    hits: List(Dynamic),
    offset: Option(Int),
    limit: Option(Int),
    estimated_total_hits: Option(Int),
    total_hits: Option(Int),
    total_pages: Option(Int),
    hits_per_page: Option(Int),
    page: Option(Int),
    facet_distribution: Option(Dynamic),
    facet_stats: Option(Dynamic),
    processing_time_ms: Int,
    query: String,
  )
}

pub fn request(
  credentials: Credentials,
  uid: String,
  search_options: SearchOptions,
) -> Request(String) {
  client.new(credentials)
  |> meilisearch_request.post(
    "/indexes/" <> uid <> "/search",
    search_options_encoder(search_options),
  )
}

/// Decodes the response from the request.
pub fn handle_response(
  response: Response(String),
) -> Result(SearchResponse, MeilisearchResponseError) {
  meilisearch_response.handle_response(response, search_response_decoder())
}

fn search_options_encoder(search_options: SearchOptions) -> String {
  let base_fields = [
    option.map(search_options.query, fn(v) { #("q", json.string(v)) }),
    option.map(search_options.offset, fn(v) { #("offset", json.int(v)) }),
    option.map(search_options.limit, fn(v) { #("limit", json.int(v)) }),
    option.map(search_options.attributes_to_retrieve, fn(v) {
      #("attributesToRetrieve", json.array(v, json.string))
    }),
    option.map(search_options.attributes_to_search_on, fn(v) {
      #("attributesToSearchOn", json.array(v, json.string))
    }),
    option.map(search_options.attributes_to_crop, fn(v) {
      #("attributesToCrop", json.array(v, json.string))
    }),
    option.map(search_options.crop_length, fn(v) {
      #("cropLength", json.int(v))
    }),
    option.map(search_options.crop_marker, fn(v) {
      #("cropMarker", json.string(v))
    }),
    option.map(search_options.attributes_to_highlight, fn(v) {
      #("attributesToHighlight", json.array(v, json.string))
    }),
    option.map(search_options.highlight_pre_tag, fn(v) {
      #("highlightPreTag", json.string(v))
    }),
    option.map(search_options.highlight_post_tag, fn(v) {
      #("highlightPostTag", json.string(v))
    }),
    option.map(search_options.matching_strategy, fn(v) {
      #("matchingStrategy", matching_strategy_encoder(v))
    }),
    option.map(search_options.show_matches_position, fn(v) {
      #("showMatchesPosition", json.bool(v))
    }),
    option.map(search_options.show_ranking_score, fn(v) {
      #("showRankingScore", json.bool(v))
    }),
    option.map(search_options.show_ranking_score_details, fn(v) {
      #("showRankingScoreDetails", json.bool(v))
    }),
    option.map(search_options.facets, fn(v) {
      #("facets", json.array(v, json.string))
    }),
    option.map(search_options.filter, fn(v) { #("filter", json.string(v)) }),
    option.map(search_options.sort, fn(v) {
      #("sort", json.array(v, json.string))
    }),
    option.map(search_options.vector, fn(v) {
      #("vector", json.array(v, json.float))
    }),
    option.map(search_options.hits_per_page, fn(v) {
      #("hitsPerPage", json.int(v))
    }),
    option.map(search_options.page, fn(v) { #("page", json.int(v)) }),
    option.map(search_options.distinct, fn(v) { #("distinct", json.string(v)) }),
    option.map(search_options.hybrid, fn(v) { #("hybrid", hybrid_encoder(v)) }),
    option.map(search_options.retrieve_vectors, fn(v) {
      #("retrieveVectors", json.bool(v))
    }),
    option.map(search_options.ranking_score_threshold, fn(v) {
      #("rankingScoreThreshold", json.float(v))
    }),
    // option.map(search_options.federation_options, fn(v) {
    //   #("federationOptions", federation_options_encoder(v))
    // }),
    option.map(search_options.locales, fn(v) {
      #("locales", json.array(v, json.string))
    }),
  ]

  base_fields
  |> list.filter_map(fn(field) { option.to_result(field, "omitted") })
  |> json.object
  |> json.to_string
}

fn matching_strategy_encoder(strategy: MatchingStrategy) -> json.Json {
  case strategy {
    All -> json.string("all")
    Last -> json.string("last")
    Frequency -> json.string("frequency")
  }
}

fn hybrid_encoder(hybrid: HybridSearchOptions) -> json.Json {
  // TODO
  json.object([
    #("hybrid", json.float(option.unwrap(hybrid.semantic_ratio, 0.0))),
  ])
}

// fn federation_options_encoder(options: SearchFederationOptions) -> json.Json {
//   json.object([#("weight", json.float(options.weight))])
// }

fn search_response_decoder() -> Decoder(SearchResponse) {
  decode.into({
    use hits <- decode.parameter
    use offset <- decode.parameter
    use limit <- decode.parameter
    use estimated_total_hits <- decode.parameter
    use total_hits <- decode.parameter
    use total_pages <- decode.parameter
    use hits_per_page <- decode.parameter
    use page <- decode.parameter
    use facet_distribution <- decode.parameter
    use facet_stats <- decode.parameter
    use processing_time_ms <- decode.parameter
    use query <- decode.parameter
    SearchResponse(
      hits: hits,
      offset: offset,
      limit: limit,
      estimated_total_hits: estimated_total_hits,
      total_hits: total_hits,
      total_pages: total_pages,
      hits_per_page: hits_per_page,
      page: page,
      facet_distribution: facet_distribution,
      facet_stats: facet_stats,
      processing_time_ms: processing_time_ms,
      query: query,
    )
  })
  |> decode.field("hits", decode.list(decode.dynamic))
  |> decode.field("offset", decode.optional(decode.int))
  |> decode.field("limit", decode.optional(decode.int))
  |> decode.field("estimatedTotalHits", decode.optional(decode.int))
  |> decode.field("totalHits", decode.optional(decode.int))
  |> decode.field("totalPages", decode.optional(decode.int))
  |> decode.field("hitsPerPage", decode.optional(decode.int))
  |> decode.field("page", decode.optional(decode.int))
  |> decode.field("facetDistribution", decode.optional(decode.dynamic))
  |> decode.field("facetStats", decode.optional(decode.dynamic))
  |> decode.field("processingTimeMs", decode.int)
  |> decode.field("query", decode.string)
}
