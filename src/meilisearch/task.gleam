import gleam/option.{type Option}
import meilisearch/error.{type Error}

pub type Task {
  Task(
    task_type: TaskType,
    status: TaskStatus,
    enqueued_at: String,
    uid: Option(Int),
    index_uid: Option(String),
    cancelled_by: Option(Int),
    details: Option(TaskDetails),
    error: Option(Error),
    duration: Option(String),
    started_at: Option(String),
    finished_at: Option(String),
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
pub type TaskDetails {
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
