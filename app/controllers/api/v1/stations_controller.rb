# frozen_string_literal: true

# GET method for consult all availables stations
class Api::V1::StationsController < Api::V1::BaseController
  before_action :set_default_locale

  def index
    stations_summary = []
    Station.all.each { |s| stations_summary.push(s.summary) }
    render json: (stations_summary.sort_by { |k| k[:name] })
  end

  private

  def set_default_locale
    I18n.default_locale = :'es-CL'
  end
end
