class CreateStations < ActiveRecord::Migration[6.0]
  def change
    create_table :stations do |t|
      t.references :company, foreign_key: true
      t.string :name
      t.string :slug
      t.string :raw_name
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.timestamps
    end
  end
end
