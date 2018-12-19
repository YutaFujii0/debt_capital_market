class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :feedback, foreign_key: true
      t.string :spread
      t.string :volume

      t.timestamps
    end
  end
end
