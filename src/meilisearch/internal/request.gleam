import gleam/http
import gleam/http/request.{type Request, Request}
import gleam/option.{None, Some}
import meilisearch/client.{type Client}
import meilisearch/version

pub fn get(client: Client, path: String) -> Request(String) {
  base_request(path, client)
  |> set_headers(client)
  |> request.set_method(http.Get)
}

pub fn post(client: Client, path: String, body: String) {
  base_request(path, client)
  |> set_headers(client)
  |> request.set_body(body)
  |> request.set_method(http.Post)
}

pub fn patch(client: Client, path: String, body: String) {
  base_request(path, client)
  |> set_headers(client)
  |> request.set_body(body)
  |> request.set_method(http.Patch)
}

pub fn delete(client: Client, path: String) {
  let base_request =
    base_request(path, client)
    |> set_headers(client)

  Request(..base_request, method: http.Delete)
}

fn base_request(path: String, client: Client) -> Request(String) {
  let assert Ok(base_req) = request.to(client.get_base_url(client) <> path)
  base_req
}

fn set_headers(request: Request(String), client: Client) -> Request(String) {
  request.prepend_header(request, "content-type", "application/json")
  |> set_authorization_header(client)
  |> request.prepend_header("user-agent", version.qualified_version())
}

fn set_authorization_header(
  request: Request(String),
  client: Client,
) -> Request(String) {
  case client.get_master_key(client) {
    Some(value) ->
      request.prepend_header(request, "authorization", "Bearer " <> value)
    None -> request
  }
}
