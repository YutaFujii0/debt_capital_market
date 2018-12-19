class CreateTranches < ActiveRecord::Migration[5.2]
  def change
    create_table :tranches do |t|
      t.references :deal, foreign_key: true
      t.references :treasury, foreign_key: true
      t.integer :tenor
      t.integer :volume
      t.integer :interest_type
      t.float :coupon
      t.integer :restriction
      t.float :spread
      t.integer :book_runners, array: true
      t.float :portion
      t.integer :management_fee
      t.integer :underwriting_fee
      t.integer :sales_fee

      t.timestamps
    end
  end
end
