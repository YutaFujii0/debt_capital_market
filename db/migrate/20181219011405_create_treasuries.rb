class CreateTreasuries < ActiveRecord::Migration[5.2]
  def change
    create_table :treasuries do |t|
      t.integer :serial_id
      t.integer :tenor
      t.date :issue
      t.date :maturity
      t.float :coupon
      t.integer :payment_per_an

      t.timestamps
    end
  end
end
