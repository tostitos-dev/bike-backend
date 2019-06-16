# frozen_string_literal: true

# GET method for consult all availables stations
class Api::V1::StationsController < Api::V1::BaseController
  def index
    stations = Station.all
    render json: stations
  end
end
