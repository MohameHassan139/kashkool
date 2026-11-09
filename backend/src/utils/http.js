/** Error with an HTTP status and a stable machine-readable code. */
export class HttpError extends Error {
  constructor(status, code, message, details) {
    super(message || code);
    this.status = status;
    this.code = code;
    this.details = details;
  }
}

export const badRequest = (code, message, details) => new HttpError(400, code, message, details);
export const unauthorized = (message = 'Authentication required') => new HttpError(401, 'unauthorized', message);
export const forbidden = (code = 'forbidden', message = 'Not allowed') => new HttpError(403, code, message);
export const notFound = (code = 'not_found', message = 'Not found') => new HttpError(404, code, message);
export const conflict = (code, message) => new HttpError(409, code, message);

/** Express 4 does not catch async errors; wrap every async handler with this. */
export const asyncHandler = (fn) => (req, res, next) => {
  Promise.resolve(fn(req, res, next)).catch(next);
};

/** Validates `data` with a zod schema and throws a 400 with readable issues. */
export function parseBody(schema, data) {
  const result = schema.safeParse(data);
  if (!result.success) {
    throw badRequest(
      'validation_error',
      'Invalid request body',
      result.error.issues.map((i) => ({ path: i.path.join('.'), message: i.message })),
    );
  }
  return result.data;
}
