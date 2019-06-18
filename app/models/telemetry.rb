class Telemetry < ApplicationRecord
  belongs_to :station
  validate :repeated, on: :create
  scope :repeated, ->(date, station) { where(captured_at: date, station: station) }

  def repeated
    errors.add(:repeated, 'repeated telemetry') unless Telemetry.repeated(captured_at, station).empty?
  end
end
