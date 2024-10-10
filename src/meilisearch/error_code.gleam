/// Exhaustive list of Meilisearch API errors
/// See [Error codes](https://www.meilisearch.com/docs/reference/errors/error_codes) for details of each code
import decode.{type Decoder}

pub type ErrorCode {
  ApiKeyAlreadyExists
  ApiKeyNotFound
  BadRequest
  DatabaseSizeLimitReached
  DocumentFieldsLimitReached
  DocumentNotFound
  DumpProcessFailed
  ImmutableApiKeyActions
  ImmutableApiKeyCreatedAt
  ImmutableApiKeyExpiresAt
  ImmutableApiKeyIndexes
  ImmutableApiKeyKey
  ImmutableApiKeyUid
  ImmutableApiKeyUpdatedAt
  ImmutableIndexUid
  ImmutableIndexUpdatedAt
  IndexAlreadyExists
  IndexCreationFailed
  IndexNotFound
  IndexPrimaryKeyAlreadyExists
  IndexPrimaryKeyMultipleCandidatesFound
  Internal
  InvalidApiKey
  InvalidApiKeyActions
  InvalidApiKeyDescription
  InvalidApiKeyExpiresAt
  InvalidApiKeyIndexes
  InvalidApiKeyLimit
  InvalidApiKeyName
  InvalidApiKeyOffset
  InvalidApiKeyUid
  InvalidSearchAttributesToSearchOn
  InvalidContentType
  InvalidDocumentCsvDelimiter
  InvalidDocumentId
  InvalidDocumentFields
  InvalidDocumentFilter
  InvalidDocumentLimit
  InvalidDocumentOffset
  InvalidDocumentGeoField
  InvalidFacetSearchFacetName
  InvalidFacetSearchFacetQuery
  InvalidIndexLimit
  InvalidIndexOffset
  InvalidIndexUid
  InvalidIndexPrimaryKey
  InvalidMultiSearchQueryFederated
  InvalidMultiSearchQueryPagination
  InvalidMultiSearchWeight
  InvalidMultiSearchQueriesRankingRules
  InvalidSearchAttributesToCrop
  InvalidSearchAttributesToHighlight
  InvalidSearchAttributesToRetrieve
  InvalidSearchCropLength
  InvalidSearchCropMarker
  InvalidSearchFacets
  InvalidSearchFilter
  InvalidSearchHighlightPostTag
  InvalidSearchHighlightPreTag
  InvalidSearchHitsPerPage
  InvalidSearchLimit
  InvalidSearchLocales
  InvalidSettingsLocalizedAttributes
  InvalidSearchMatchingStrategy
  InvalidSearchOffset
  InvalidSearchPage
  InvalidSearchQ
  InvalidSearchRankingScoreThreshold
  InvalidSearchShowMatchesPosition
  InvalidSearchSort
  InvalidSettingsDisplayedAttributes
  InvalidSettingsDistinctAttribute
  InvalidSettingsFacetingSortFacetValuesBy
  InvalidSettingsFacetingMaxValuesPerFacet
  InvalidSettingsFilterableAttributes
  InvalidSettingsPagination
  InvalidSettingsRankingRules
  InvalidSettingsSearchableAttributes
  InvalidSettingsSearchCutoffMs
  InvalidSettingsSortableAttributes
  InvalidSettingsStopWords
  InvalidSettingsSynonyms
  InvalidSettingsTypoTolerance
  InvalidSimilarRankingScoreThreshold
  InvalidState
  InvalidStoreFile
  InvalidSwapDuplicateIndexFound
  InvalidSwapIndexes
  InvalidTaskAfterEnqueuedAt
  InvalidTaskAfterFinishedAt
  InvalidTaskAfterStartedAt
  InvalidTaskBeforeEnqueuedAt
  InvalidTaskBeforeFinishedAt
  InvalidTaskBeforeStartedAt
  InvalidTaskCanceledBy
  InvalidTaskIndexUids
  InvalidTaskLimit
  InvalidTaskStatuses
  InvalidTaskTypes
  InvalidTaskUids
  IoError
  IndexPrimaryKeyNoCandidateFound
  MalformedPayload
  MissingApiKeyActions
  MissingApiKeyExpiresAt
  MissingApiKeyIndexes
  MissingAuthorizationHeader
  MissingContentType
  MissingDocumentFilter
  MissingDocumentId
  MissingIndexUid
  MissingFacetSearchFacetName
  MissingMasterKey
  MissingPayload
  MissingSwapIndexes
  MissingTaskFilters
  NoSpaceLeftOnDevice
  NotFound
  PayloadTooLarge
  TaskNotFound
  TooManyOpenFiles
  TooManySearchRequests
  UnretrievableDocument
}

pub fn error_code_decoder() -> Decoder(ErrorCode) {
  decode.string
  |> decode.then(fn(decoded_string) {
    case decoded_string {
      "api_key_already_exists" -> decode.into(ApiKeyAlreadyExists)
      "api_key_not_found" -> decode.into(ApiKeyNotFound)
      "bad_request" -> decode.into(BadRequest)
      "database_size_limit_reached" -> decode.into(DatabaseSizeLimitReached)
      "document_fields_limit_reached" -> decode.into(DocumentFieldsLimitReached)
      "document_not_found" -> decode.into(DocumentNotFound)
      "dump_process_failed" -> decode.into(DumpProcessFailed)
      "immutable_api_key_actions" -> decode.into(ImmutableApiKeyActions)
      "immutable_api_key_created_at" -> decode.into(ImmutableApiKeyCreatedAt)
      "immutable_api_key_expires_at" -> decode.into(ImmutableApiKeyExpiresAt)
      "immutable_api_key_indexes" -> decode.into(ImmutableApiKeyIndexes)
      "immutable_api_key_key" -> decode.into(ImmutableApiKeyKey)
      "immutable_api_key_uid" -> decode.into(ImmutableApiKeyUid)
      "immutable_api_key_updated_at" -> decode.into(ImmutableApiKeyUpdatedAt)
      "immutable_index_uid" -> decode.into(ImmutableIndexUid)
      "immutable_index_updated_at" -> decode.into(ImmutableIndexUpdatedAt)
      "index_already_exists" -> decode.into(IndexAlreadyExists)
      "index_creation_failed" -> decode.into(IndexCreationFailed)
      "index_not_found" -> decode.into(IndexNotFound)
      "index_primary_key_already_exists" ->
        decode.into(IndexPrimaryKeyAlreadyExists)
      "index_primary_key_multiple_candidates_found" ->
        decode.into(IndexPrimaryKeyMultipleCandidatesFound)
      "internal" -> decode.into(Internal)
      "invalid_api_key" -> decode.into(InvalidApiKey)
      "invalid_api_key_actions" -> decode.into(InvalidApiKeyActions)
      "invalid_api_key_description" -> decode.into(InvalidApiKeyDescription)
      "invalid_api_key_expires_at" -> decode.into(InvalidApiKeyExpiresAt)
      "invalid_api_key_indexes" -> decode.into(InvalidApiKeyIndexes)
      "invalid_api_key_limit" -> decode.into(InvalidApiKeyLimit)
      "invalid_api_key_name" -> decode.into(InvalidApiKeyName)
      "invalid_api_key_offset" -> decode.into(InvalidApiKeyOffset)
      "invalid_api_key_uid" -> decode.into(InvalidApiKeyUid)
      "invalid_search_attributes_to_search_on" ->
        decode.into(InvalidSearchAttributesToSearchOn)
      "invalid_content_type" -> decode.into(InvalidContentType)
      "invalid_document_csv_delimiter" ->
        decode.into(InvalidDocumentCsvDelimiter)
      "invalid_document_id" -> decode.into(InvalidDocumentId)
      "invalid_document_fields" -> decode.into(InvalidDocumentFields)
      "invalid_document_filter" -> decode.into(InvalidDocumentFilter)
      "invalid_document_limit" -> decode.into(InvalidDocumentLimit)
      "invalid_document_offset" -> decode.into(InvalidDocumentOffset)
      "invalid_document_geo_field" -> decode.into(InvalidDocumentGeoField)
      "invalid_facet_search_facet_name" ->
        decode.into(InvalidFacetSearchFacetName)
      "invalid_facet_search_facet_query" ->
        decode.into(InvalidFacetSearchFacetQuery)
      "invalid_index_limit" -> decode.into(InvalidIndexLimit)
      "invalid_index_offset" -> decode.into(InvalidIndexOffset)
      "invalid_index_uid" -> decode.into(InvalidIndexUid)
      "invalid_index_primary_key" -> decode.into(InvalidIndexPrimaryKey)
      "invalid_multi_search_query_federated" ->
        decode.into(InvalidMultiSearchQueryFederated)
      "invalid_multi_search_query_pagination" ->
        decode.into(InvalidMultiSearchQueryPagination)
      "invalid_multi_search_weight" -> decode.into(InvalidMultiSearchWeight)
      "invalid_multi_search_queries_ranking_rules" ->
        decode.into(InvalidMultiSearchQueriesRankingRules)
      "invalid_search_attributes_to_crop" ->
        decode.into(InvalidSearchAttributesToCrop)
      "invalid_search_attributes_to_highlight" ->
        decode.into(InvalidSearchAttributesToHighlight)
      "invalid_search_attributes_to_retrieve" ->
        decode.into(InvalidSearchAttributesToRetrieve)
      "invalid_search_crop_length" -> decode.into(InvalidSearchCropLength)
      "invalid_search_crop_marker" -> decode.into(InvalidSearchCropMarker)
      "invalid_search_facets" -> decode.into(InvalidSearchFacets)
      "invalid_search_filter" -> decode.into(InvalidSearchFilter)
      "invalid_search_highlight_post_tag" ->
        decode.into(InvalidSearchHighlightPostTag)
      "invalid_search_highlight_pre_tag" ->
        decode.into(InvalidSearchHighlightPreTag)
      "invalid_search_hits_per_page" -> decode.into(InvalidSearchHitsPerPage)
      "invalid_search_limit" -> decode.into(InvalidSearchLimit)
      "invalid_search_locales" -> decode.into(InvalidSearchLocales)
      "invalid_settings_localized_attributes" ->
        decode.into(InvalidSettingsLocalizedAttributes)
      "invalid_search_matching_strategy" ->
        decode.into(InvalidSearchMatchingStrategy)
      "invalid_search_offset" -> decode.into(InvalidSearchOffset)
      "invalid_search_page" -> decode.into(InvalidSearchPage)
      "invalid_search_q" -> decode.into(InvalidSearchQ)
      "invalid_search_ranking_score_threshold" ->
        decode.into(InvalidSearchRankingScoreThreshold)
      "invalid_search_show_matches_position" ->
        decode.into(InvalidSearchShowMatchesPosition)
      "invalid_search_sort" -> decode.into(InvalidSearchSort)
      "invalid_settings_displayed_attributes" ->
        decode.into(InvalidSettingsDisplayedAttributes)
      "invalid_settings_distinct_attribute" ->
        decode.into(InvalidSettingsDistinctAttribute)
      "invalid_settings_faceting_sort_facet_values_by" ->
        decode.into(InvalidSettingsFacetingSortFacetValuesBy)
      "invalid_settings_faceting_max_values_per_facet" ->
        decode.into(InvalidSettingsFacetingMaxValuesPerFacet)
      "invalid_settings_filterable_attributes" ->
        decode.into(InvalidSettingsFilterableAttributes)
      "invalid_settings_pagination" -> decode.into(InvalidSettingsPagination)
      "invalid_settings_ranking_rules" ->
        decode.into(InvalidSettingsRankingRules)
      "invalid_settings_searchable_attributes" ->
        decode.into(InvalidSettingsSearchableAttributes)
      "invalid_settings_search_cutoff_ms" ->
        decode.into(InvalidSettingsSearchCutoffMs)
      "invalid_settings_sortable_attributes" ->
        decode.into(InvalidSettingsSortableAttributes)
      "invalid_settings_stop_words" -> decode.into(InvalidSettingsStopWords)
      "invalid_settings_synonyms" -> decode.into(InvalidSettingsSynonyms)
      "invalid_settings_typo_tolerance" ->
        decode.into(InvalidSettingsTypoTolerance)
      "invalid_similar_ranking_score_threshold" ->
        decode.into(InvalidSimilarRankingScoreThreshold)
      "invalid_state" -> decode.into(InvalidState)
      "invalid_store_file" -> decode.into(InvalidStoreFile)
      "invalid_swap_duplicate_index_found" ->
        decode.into(InvalidSwapDuplicateIndexFound)
      "invalid_swap_indexes" -> decode.into(InvalidSwapIndexes)
      "invalid_task_after_enqueued_at" ->
        decode.into(InvalidTaskAfterEnqueuedAt)
      "invalid_task_after_finished_at" ->
        decode.into(InvalidTaskAfterFinishedAt)
      "invalid_task_after_started_at" -> decode.into(InvalidTaskAfterStartedAt)
      "invalid_task_before_enqueued_at" ->
        decode.into(InvalidTaskBeforeEnqueuedAt)
      "invalid_task_before_finished_at" ->
        decode.into(InvalidTaskBeforeFinishedAt)
      "invalid_task_before_started_at" ->
        decode.into(InvalidTaskBeforeStartedAt)
      "invalid_task_canceled_by" -> decode.into(InvalidTaskCanceledBy)
      "invalid_task_index_uids" -> decode.into(InvalidTaskIndexUids)
      "invalid_task_limit" -> decode.into(InvalidTaskLimit)
      "invalid_task_statuses" -> decode.into(InvalidTaskStatuses)
      "invalid_task_types" -> decode.into(InvalidTaskTypes)
      "invalid_task_uids" -> decode.into(InvalidTaskUids)
      "io_error" -> decode.into(IoError)
      "index_primary_key_no_candidate_found" ->
        decode.into(IndexPrimaryKeyNoCandidateFound)
      "malformed_payload" -> decode.into(MalformedPayload)
      "missing_api_key_actions" -> decode.into(MissingApiKeyActions)
      "missing_api_key_expires_at" -> decode.into(MissingApiKeyExpiresAt)
      "missing_api_key_indexes" -> decode.into(MissingApiKeyIndexes)
      "missing_authorization_header" -> decode.into(MissingAuthorizationHeader)
      "missing_content_type" -> decode.into(MissingContentType)
      "missing_document_filter" -> decode.into(MissingDocumentFilter)
      "missing_document_id" -> decode.into(MissingDocumentId)
      "missing_index_uid" -> decode.into(MissingIndexUid)
      "missing_facet_search_facet_name" ->
        decode.into(MissingFacetSearchFacetName)
      "missing_master_key" -> decode.into(MissingMasterKey)
      "missing_payload" -> decode.into(MissingPayload)
      "missing_swap_indexes" -> decode.into(MissingSwapIndexes)
      "missing_task_filters" -> decode.into(MissingTaskFilters)
      "no_space_left_on_device" -> decode.into(NoSpaceLeftOnDevice)
      "not_found" -> decode.into(NotFound)
      "payload_too_large" -> decode.into(PayloadTooLarge)
      "task_not_found" -> decode.into(TaskNotFound)
      "too_many_open_files" -> decode.into(TooManyOpenFiles)
      "too_many_search_requests" -> decode.into(TooManySearchRequests)
      "unretrievable_document" -> decode.into(UnretrievableDocument)
      _ -> decode.fail("Unknown ErrorCode: " <> decoded_string)
    }
  })
}
