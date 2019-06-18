class Telemetry < ApplicationRecord
  belongs_to :station
  validate :repeated, on: :create
  scope :repeated, ->(date, station) { where(captured_at: date, station: station) }
  scope :now, -> { where(created_at: (Time.now - 1.minute)..Time.now)}
  after_create :report_station_update

  def repeated
    errors.add(:repeated, 'repeated') unless Telemetry.repeated(captured_at,
                                                                station)
                                                      .empty?
  end

  def report_station_update
    report = ReportStationTelemetry.find_by(station: station,
                                            created_at: created_at.beginning_of_day..created_at.end_of_day)
    return create_report if report.blank?

    report.update_state self
  end

  def create_report
    station.report_station_telemetries.create empty_slots: empty_slots,
                                              free_bikes: free_bikes,
                                              by_hour: {
                                                "#{created_at.strftime('%H')}": {
                                                  'empty_slots': empty_slots,
                                                  'free_bikes': free_bikes
                                                }
                                              }
  end
end
