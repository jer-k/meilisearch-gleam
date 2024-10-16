import decode
import meilisearch/index.{Index}

pub fn index_decoder() {
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
