class CreateSmallCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :small_codes do |t|
      t.string :name
      t.string :serial_id
      t.references :large_code, foreign_key: true

      t.timestamps
    end
  end
end
