import gleam/option
import meilisearch/client

pub const credentials = client.Credentials(
  base_url: "http://localhost:7700",
  master_key: option.Some("gleeunitTestMasterKey"),
)
