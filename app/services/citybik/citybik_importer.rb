# frozen_string_literal: true

module Citybik
  class CitybikImporter < Citybik::BaseImporter
    BASE_URL = ENV['BASE_URL']

    def prepare
      require 'rest-client'
    end

    def connect
      url = BASE_URL + @company.name
      response = RestClient::Request.execute(method: :get, url: url)
      Rails.logger.info "RESPONSE #{response}"
      JSON.parse response.body
    end

    def verify(_body)
      true
    end

    def process(body)

    end

    def persist(telemetries)
    end
  end
end