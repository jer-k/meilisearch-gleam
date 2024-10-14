import gleam/httpc
import gleam/io
import meilisearch/index
import meilisearch/response.{MeilisearchListResponse, MeilisearchResponse}

import gleam/option.{Some}

pub fn main() {
  todo
  // let request = index.fetch_info("books")
  // //let request = index.indexes()
  // let res = httpc.send(request)
  // case res {
  //   Ok(res) -> {
  //     case index.response(request, res) {
  //       Ok(indexes) -> {
  //         io.debug(indexes)
  //         "yay"
  //       }
  //       Error(err) -> {
  //         io.debug(err)
  //         "nay"
  //       }
  //     }
  //   }
  //   Error(err) -> {
  //     io.debug(err)
  //     "err"
  //   }
  // }
}
