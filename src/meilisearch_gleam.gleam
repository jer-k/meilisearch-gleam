import gleam/httpc
import gleam/io
import meilisearch/indexes

pub fn main() {
  let request = indexes.fetch_info("/books")
  let res = httpc.send(request)
  case res {
    Ok(res) -> {
      case indexes.response(res) {
        Ok(indexes) -> {
          io.debug(indexes)
          "yay"
        }
        Error(err) -> {
          io.debug(err)
          "nay"
        }
      }
    }
    Error(err) -> {
      io.debug(err)
      "err"
    }
  }
}
