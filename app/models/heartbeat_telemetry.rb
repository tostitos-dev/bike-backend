class HeartbeatTelemetry < ApplicationRecord
  scope :last_hour, -> { where(created_at: (Time.now - 1.hour)..Time.now) }
end
