class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :phone
      t.integer :age
      t.string :gender

      t.timestamps
    end
  end
end
