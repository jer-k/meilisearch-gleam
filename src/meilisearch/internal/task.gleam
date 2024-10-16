import decode.{type Decoder}
import meilisearch/error
import meilisearch/task.{
  type TaskDetails, type TaskStatus, type TaskType, Canceled,
  DocumentAdditionOrUpdate, DocumentDeletion, DumpCreation, Enqueued, Failed,
  IndexCreation, IndexDeletion, IndexSwap, IndexUpdate, Processing,
  SettingsUpdate, SnapshotCreation, Succeeded, Task, TaskCancelation,
  TaskDeletion,
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
  |> decode.field("uid", decode.optional(decode.int))
  |> decode.field("indexUid", decode.optional(decode.string))
  |> decode.field("type", task_type_decoder())
  |> decode.field("status", task_status_decoder())
  |> decode.field("cancelledBy", decode.optional(decode.int))
  |> decode.field("details", decode.optional(task_details_decoder()))
  |> decode.field("error", decode.optional(error.error_decoder()))
  |> decode.field("duration", decode.optional(decode.string))
  |> decode.field("enqueuedAt", decode.string)
  |> decode.field("startedAt", decode.optional(decode.string))
  |> decode.field("finishedAt", decode.optional(decode.string))
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
