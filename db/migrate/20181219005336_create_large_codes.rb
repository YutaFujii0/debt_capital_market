class CreateLargeCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :large_codes do |t|
      t.string :name
      t.string :serial_id

      t.timestamps
    end
  end
end
