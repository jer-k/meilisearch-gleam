import decode.{type Decoder}

import gleam/option.{type Option}
import meilisearch/error.{type Error}

pub opaque type Task {
  Task(
    uid: Int,
    index_uid: Option(String),
    task_type: TaskType,
    status: TaskStatus,
    cancelled_by: Option(Int),
    details: TaskDetails,
    error: Option(Error),
    duration: String,
    enqueued_at: String,
    started_at: String,
    finished_at: String,
  )
}

/// Status of the task.
pub type TaskStatus {
  Enqueued
  Processing
  Succeeded
  Failed
  Canceled
}

/// Type of operation performed by the task.
pub type TaskType {
  IndexCreation
  IndexUpdate
  IndexDeletion
  IndexSwap
  DocumentAdditionOrUpdate
  DocumentDeletion
  SettingsUpdate
  DumpCreation
  TaskCancelation
  TaskDeletion
  SnapshotCreation
}

// Placeholders
pub type RankingRules

pub type SearchableAttributes

pub type DisplayedAttributes

pub type FilterableAttributes

pub type SortableAttributes

pub type StopWords

pub type Synonyms

pub type DistinctAttribute

pub type SwapIndexesParams

/// Detailed information on the Task payload. The contents depend on the Task's TaskType.
pub opaque type TaskDetails {
  TaskDetails(
    // Number of documents sent
    received_documents: Option(Int),
    // Number of documents successfully indexed/updated in Meilisearch
    indexed_documents: Option(Int),
    // Number of deleted documents
    deleted_documents: Option(Int),
    // Number of documents found on a batch-delete
    provided_ids: Option(Int),
    // Primary key on index creation
    primary_key: Option(String),
    // Ranking rules on settings actions
    ranking_rules: Option(RankingRules),
    // Searchable attributes on settings actions
    searchable_attributes: Option(SearchableAttributes),
    // Displayed attributes on settings actions
    displayed_attributes: Option(DisplayedAttributes),
    // Filterable attributes on settings actions
    filterable_attributes: Option(FilterableAttributes),
    // Sortable attributes on settings actions
    sortable_attributes: Option(SortableAttributes),
    // Stop words on settings actions
    stop_words: Option(StopWords),
    // Synonyms on settings actions
    synonyms: Option(Synonyms),
    // Distinct attribute on settings actions
    distinct_attribute: Option(DistinctAttribute),
    // Object containing the payload originating the `indexSwap` task creation
    swaps: Option(SwapIndexesParams),
    // Number of tasks that matched the originalQuery filter
    matched_tasks: Option(Int),
    // Number of tasks that were canceled
    canceled_tasks: Option(Int),
    // Number of tasks that were deleted
    deleted_tasks: Option(Int),
    // Query parameters used to filter the tasks
    original_filter: Option(String),
  )
}

pub fn task_decoder() {
  decode.into({
    use uid <- decode.parameter
    use index_uid <- decode.parameter
    use task_type <- decode.parameter
    use status <- decode.parameter
    use cancelled_by <- decode.parameter
    use details <- decode.parameter
    use error <- decode.parameter
    use duration <- decode.parameter
    use enqueued_at <- decode.parameter
    use started_at <- decode.parameter
    use finished_at <- decode.parameter
    Task(
      uid: uid,
      index_uid: index_uid,
      task_type: task_type,
      status: status,
      cancelled_by: cancelled_by,
      details: details,
      error: error,
      duration: duration,
      enqueued_at: enqueued_at,
      started_at: started_at,
      finished_at: finished_at,
    )
  })
  |> decode.field("uid", decode.int)
  |> decode.field("indexUid", decode.optional(decode.string))
  |> decode.field("type", task_type_decoder())
  |> decode.field("status", task_status_decoder())
  |> decode.field("cancelledBy", decode.optional(decode.int))
  |> decode.field("details", task_details_decoder())
  |> decode.field("error", decode.optional(error.error_decoder()))
  |> decode.field("duration", decode.string)
  |> decode.field("enqueuedAt", decode.string)
  |> decode.field("startedAt", decode.string)
  |> decode.field("finishedAt", decode.string)
}

pub fn task_type_decoder() -> Decoder(TaskType) {
  decode.string
  |> decode.then(fn(decoded_string) {
    case decoded_string {
      "indexCreation" -> decode.into(IndexCreation)
      "indexUpdate" -> decode.into(IndexUpdate)
      "indexDeletion" -> decode.into(IndexDeletion)
      "indexSwap" -> decode.into(IndexSwap)
      "documentAdditionOrUpdate" -> decode.into(DocumentAdditionOrUpdate)
      "documentDeletion" -> decode.into(DocumentDeletion)
      "settingsUpdate" -> decode.into(SettingsUpdate)
      "dumpCreation" -> decode.into(DumpCreation)
      "taskCancelation" -> decode.into(TaskCancelation)
      "taskDeletion" -> decode.into(TaskDeletion)
      "snapshotCreation" -> decode.into(SnapshotCreation)
      _ -> decode.fail("Unknown ErrorType: " <> decoded_string)
    }
  })
}

pub fn task_status_decoder() -> Decoder(TaskStatus) {
  decode.string
  |> decode.then(fn(decoded_string) {
    case decoded_string {
      "enqueued" -> decode.into(Enqueued)
      "processing" -> decode.into(Processing)
      "succeeded" -> decode.into(Succeeded)
      "failed" -> decode.into(Failed)
      "canceled" -> decode.into(Canceled)
      _ -> decode.fail("Unknown ErrorType: " <> decoded_string)
    }
  })
}

pub fn task_details_decoder() -> Decoder(TaskDetails) {
  decode.string
  |> decode.then(fn(decoded_string) {
    case decoded_string {
      _ -> decode.fail("Unknown ErrorType: " <> decoded_string)
    }
  })
}
