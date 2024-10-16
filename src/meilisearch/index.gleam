import gleam/option.{type Option}

pub type Index {
  Index(
    uid: String,
    primary_key: Option(String),
    created_at: String,
    updated_at: String,
  )
}
