class CreateUnderwriters < ActiveRecord::Migration[5.2]
  def change
    create_table :underwriters do |t|
      t.string :name
      t.string :abbreviation

      t.timestamps
    end
  end
end
