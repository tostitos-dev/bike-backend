# frozen_string_literal: true

# Background task for generate report every 1 minute
class UpdateReportTelemetryJob < ApplicationJob
  queue_as :default

  def perform
    free_bikes = 0
    empty_slots = 0
    Station.all.each do |station|
      free_bikes += station.telemetries.last.free_bikes
      empty_slots += station.telemetries.last.empty_slots
    end
    HeartbeatTelemetry.create free_bikes: free_bikes,
                              empty_slots: empty_slots
  end
end
