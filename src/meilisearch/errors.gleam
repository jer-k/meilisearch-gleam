//// Module containing all the error types defined by Meilisearch.
//// See [Status codes and Meilisearch errors](https://www.meilisearch.com/docs/reference/errors/overview) for more information.

import meilisearch/error_code.{type ErrorCode}
import meilisearch/error_type.{type ErrorType}

// Meilisearch uses the following standard HTTP codes for a successful or failed API request:
// Code	Description
//
// 200  Ok Everything worked as expected.
// 201  Created The resource has been created (synchronous)
// 202	Accepted The task has been added to the queue (asynchronous)
// 204	No Content The resource has been deleted or no content has been returned
// 205	Reset Content All the resources have been deleted
// 400	Bad Request The request was unacceptable, often due to missing a required parameter
// 401	Unauthorized No valid API key provided
// 403	Forbidden The API key doesn't have the permissions to perform the request
// 404	Not Found The requested resource doesn't exist

/// Meilisearch API Error
/// message	Human-readable description of the error
/// code	Meilisearch Error Code. See [Error codes](https://www.meilisearch.com/docs/reference/errors/error_codes)
/// error_type	Type of error returned. See [Errors](https://www.meilisearch.com/docs/reference/errors/overview#errors)
/// link	Link to the relevant section of the documentation
pub type MeilisearchError {
  MeilisearchError(
    message: String,
    code: ErrorCode,
    error_type: ErrorType,
    link: String,
  )
}
