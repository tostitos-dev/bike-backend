class CreateTelemetries < ActiveRecord::Migration[6.0]
  def change
    create_table :telemetries do |t|
      t.references :station, foreign_key: true
      t.datetime :captured_at
      t.integer :empty_slots
      t.integer :free_bikes
      t.json :raw_data
      t.timestamps
    end
  end
end
