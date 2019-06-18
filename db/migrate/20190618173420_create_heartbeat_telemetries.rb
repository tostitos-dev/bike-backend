class CreateHeartbeatTelemetries < ActiveRecord::Migration[6.0]
  def change
    create_table :heartbeat_telemetries do |t|
      t.integer :empty_slots
      t.integer :free_bikes
      t.timestamps
    end
  end
end
