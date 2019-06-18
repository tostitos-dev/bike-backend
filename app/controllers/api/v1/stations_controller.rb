# frozen_string_literal: true

# GET method for consult all availables stations
class Api::V1::StationsController < Api::V1::BaseController
  before_action :set_default_locale

  def index
    stations_summary = []
    Station.all.each { |s| stations_summary.push(s.summary) }
    render json: (stations_summary.sort_by { |k| k[:name] })
  end

  def daily_indicators
    time_now = Time.now
    result = {
      current_time: {
        day: time_now.strftime('%d'),
        mouth: (I18n.t :abbr_month_names, scope: :date)[time_now.month].capitalize,
        year: time_now.strftime('%Y')
      },
      # total: '',
      # use: "",
      # free:""
    }
    render json: result
  end

  private

  def set_default_locale
    I18n.default_locale = :'es-CL'
  end
end
