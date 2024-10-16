import gleam/option.{type Option}

/// Client is the basic type used to make requests. Client should be initialized with client.new and provided
/// with the desired pagination options via `with_pagination`.
pub opaque type Client {
  Client(credentials: Credentials, pagination: PaginationOptions)
}

pub type Credentials {
  Credentials(base_url: String, master_key: Option(String))
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
pub fn new(credentials: Credentials) -> Client {
  Client(credentials, pagination: Default)
}

pub fn get_base_url(client: Client) -> String {
  client.credentials.base_url
}

pub fn get_master_key(client: Client) -> Option(String) {
  client.credentials.master_key
}
