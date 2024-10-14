# meilisearch_gleam

## About

I was looking to learn a bit more about Gleam and I saw the
[Meilisearch client](https://github.com/gleam-lang/awesome-gleam/issues/163) issue in
[awesome-gleam](https://github.com/gleam-lang/awesome-gleam) so I decided to take a swing at an implementation.
There are many official SDKs written by the Meilisearch team. You can find a list of them
[here](https://github.com/meilisearch/integration-guides?tab=readme-ov-file#-sdks-for-meilisearch-api).

View the [Issues](https://github.com/jer-k/meilisearch-gleam) in this repository to see the current status of this SDK.
I'm trying to document the different APIs and have smaller chunks of work that can be checked off periodically, instead
of trying to knock out large full API implementations at once.

### "Sans IO" approach

The approach with this package, because Gleam can compile to different targets, is that the library will construct
the HTTP requests and can parse the repsonses into records. However, however it is up to the project using this
package to actually execute the request with their given choice of http client. I like this idea but it proving
difficult in figuring out how to handle and parse the responses in a way that makes for a good developer experience.
See [Determine what is the best DX for handling responses is](https://github.com/jer-k/meilisearch-gleam/issues/1) if
you have any input.

[![Package Version](https://img.shields.io/hexpm/v/meilisearch_gleam)](https://hex.pm/packages/meilisearch_gleam)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/meilisearch_gleam/)

```sh
gleam add meilisearch_gleam@1
```
```gleam
import meilisearch_gleam

pub fn main() {
  // TODO: An example of the project in use
}
```

Further documentation can be found at <https://hexdocs.pm/meilisearch_gleam>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
