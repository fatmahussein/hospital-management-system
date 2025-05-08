class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.references :patient, null: false, foreign_key: true
      t.datetime :date
      t.time :time
      t.string :status
      t.text :reason

      t.timestamps
    end
  end
end
