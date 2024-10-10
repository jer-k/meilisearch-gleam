import envoy
import gleam/option.{type Option, None, Some}

/// Client is the basic type used to make requests. Client should be initialized with client.new and provided
/// with the desired pagination options via `with_pagination`.
pub opaque type Client {
  Client(
    base_url: String,
    master_key: Option(String),
    pagination: PaginationOptions,
  )
}

/// Paginated endpoints accept `limit` and `offset` query parameters.
///
/// # Example
///
/// ```gleam
/// let client = client.new()
///
/// // Sets the limit to 100
/// client |> with_pagination(Limit(100)) |> ...
///
/// // Sets the offset to 20
/// client |> with_pagination(Offset(20)) |> ...
///
/// // Sets the limit to 100 and the offset to 20
/// client |> with_pagination(Paginate(100, 20)) |> ...
/// ```
pub type PaginationOptions {
  Default
  Limit(Int)
  Offset(Int)
  Paginate(limit: Int, offset: Int)
}

/// Initializes a Client with default pagination settings.
pub fn new() -> Client {
  let assert Ok(base_url) = envoy.get("MEILISEARCH_BASE_URL")
  Client(base_url, master_key_environment_variable(), pagination: Default)
}

pub fn get_base_url(client: Client) -> String {
  client.base_url
}

pub fn get_master_key(client: Client) -> Option(String) {
  client.master_key
}

fn master_key_environment_variable() -> Option(String) {
  case envoy.get("MEILISEARCH_MASTER_KEY") {
    Ok(value) -> Some(value)
    Error(_) -> None
  }
}
