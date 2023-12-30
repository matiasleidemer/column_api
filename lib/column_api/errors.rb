# frozen_string_literal: true

module ColumnApi
  class Error < StandardError; end
  class BadRequestError < StandardError; end
  class UnauthorizedError < StandardError; end
end
