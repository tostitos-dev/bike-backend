# frozen_string_literal: true

module Citybik
  # Class adapter for specific provider (Citybik)
  class CitybikImporter < Citybik::BaseImporter
    BASE_URL = ENV['BASE_URL']

    def prepare
      require 'rest-client'
    end

    def connect
      url = BASE_URL + @company.name
      response = RestClient::Request.execute(method: :get, url: url)
      JSON.parse response.body
    end

    def verify(body)
      return false unless body.is_a? Hash
      return false if body['network']['stations'].blank?

      true
    end

    def process(body)
      structured_data = []
      body['network']['stations'].each do |t|
        structured_data.push(refined_data(t))
      end
      structured_data
    end

    def refined_data(telemetry)
      {
        station: link_station(telemetry),
        empty_slots: telemetry['empty_slots'],
        free_bikes: telemetry['free_bikes'],
        captured_at: telemetry['timestamp'],
        raw_data: telemetry
      }
    end

    def link_station(telemetry)
      station = Station.find_by(external_id: telemetry['id'],
                                company: @company)
      return station unless station.blank?

      create_station(telemetry)
    end

    def create_station(telemetry)
      Station.create company: @company,
                     external_id: telemetry['id'],
                     raw_name: telemetry['name'],
                     latitude: telemetry['latitude'],
                     longitude: telemetry['longitude']
    end

    def persist(telemetries)
      telemetries.each do |t|
        Telemetry.create t
      end; 0
    end
  end
end
