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
      }
    }.merge! bike_stats
    render json: result
  end

  def bike_stats
    stats = general_stats
    {
      bike_stats: {
        total: stats[0] + stats[1],
        use: stats[0],
        free: stats[1]
      }
    }
  end

  def general_stats
    use = 0
    free = 0
    Station.all.each do |station|
      use += station.telemetries.last.empty_slots
      free += station.telemetries.last.free_bikes
    end
    [use, free]
  end

  private

  def set_default_locale
    I18n.default_locale = :'es-CL'
  end
end
