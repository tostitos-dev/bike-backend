# frozen_string_literal: true

# GET method for consult all availables stations
class Api::V1::StationsController < Api::V1::BaseController
  def index
    stations_summary = []
    Station.all.each { |s| stations_summary.push(s.summary) }
    render json: stations_summary
  end
end
