class CreateMarketings < ActiveRecord::Migration[5.2]
  def change
    create_table :marketings do |t|
      t.date :date
      t.string :marketing
      t.string :volume
      t.string :range
      t.string :strategy

      t.timestamps
    end
  end
end
