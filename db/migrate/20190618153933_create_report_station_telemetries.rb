class CreateReportStationTelemetries < ActiveRecord::Migration[6.0]
  def change
    create_table :report_station_telemetries do |t|
      t.references :station, foreign_key: true
      t.integer :empty_slots
      t.integer :free_bikes
      t.json :by_hour
      t.timestamps
    end
  end
end
