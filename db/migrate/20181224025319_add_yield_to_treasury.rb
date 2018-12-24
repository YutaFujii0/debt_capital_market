class AddYieldToTreasury < ActiveRecord::Migration[5.2]
  def change
    add_column :treasuries, :cmp_interest, :float
    add_column :treasuries, :price, :float
  end
end
