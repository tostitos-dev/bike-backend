# frozen_string_literal: true

module Citybik
  # Define process to get telemetries for specific company
  class BaseImporter
    def initialize(company)
      @company = company
    end

    def import!
      prepare
      response_body = connect
      return unless verify response_body

      captures = process response_body
      persist captures
    end
  end
end
