import gleam/http/response.{Response}
import gleam/json
import gleam/list
import gleeunit/should
import helpers
import meilisearch/indexes/list as index_list

pub fn request_test() {
  let request = index_list.request(helpers.credentials)

  request.path |> should.equal("/indexes")
}

pub fn handle_response_test() {
  let body =
    json.object([
      #(
        "results",
        json.preprocessed_array([
          json.object([
            #("uid", json.string("books")),
            #("createdAt", json.string("2022-03-08T10:00:27.377346Z")),
            #("updatedAt", json.string("2022-03-08T10:00:27.391209Z")),
            #("primaryKey", json.string("id")),
          ]),
          json.object([
            #("uid", json.string("meteorites")),
            #("createdAt", json.string("2022-03-08T10:00:44.518768Z")),
            #("updatedAt", json.string("2022-03-08T10:00:44.582083Z")),
            #("primaryKey", json.string("id")),
          ]),
          json.object([
            #("uid", json.string("movies")),
            #("createdAt", json.string("2022-02-10T07:45:15.628261Z")),
            #("updatedAt", json.string("2022-02-21T15:28:43.496574Z")),
            #("primaryKey", json.string("id")),
          ]),
        ]),
      ),
      #("offset", json.int(0)),
      #("limit", json.int(3)),
      #("total", json.int(5)),
    ])
    |> json.to_string

  let response = Response(status: 200, body: body, headers: [])
  let assert Ok(list_response) = index_list.handle_response(response)

  list_response.results |> list.length |> should.equal(3)
  list_response.offset |> should.equal(0)
  list_response.limit |> should.equal(3)
  list_response.total |> should.equal(5)
}
