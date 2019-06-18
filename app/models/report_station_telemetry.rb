class ReportStationTelemetry < ApplicationRecord
  belongs_to :station
  scope :today, -> { where(created_at: Time.now.beginning_of_day..Time.now.end_of_day)}

  def update_state(telemetry)
    update empty_slots: empty_slots + telemetry.empty_slots,
           free_bikes: free_bikes + telemetry.free_bikes,
           by_hour: hour_state(telemetry)
  end

  def hour_state(telemetry)
    n_by_hour = by_hour
    current_count = by_hour[telemetry.created_at.strftime('%H').to_s]
    return create_hour_node(telemetry) if current_count.blank?

    current_count['empty_slots'] = current_count['empty_slots'] + telemetry.empty_slots
    current_count['free_bikes'] = current_count['free_bikes'] + telemetry.free_bikes
    n_by_hour[telemetry.created_at.strftime('%H').to_s] = current_count
    n_by_hour
  end

  def create_hour_node(telemetry)
    new_hour = {
      "#{telemetry.created_at.strftime('%H')}": {
        'empty_slots': telemetry.empty_slots,
        'free_bikes': telemetry.free_bikes
      }
    }
    by_hour.merge! new_hour
  end
end
