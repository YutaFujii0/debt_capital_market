class ChangeTypeOfDealCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :deal_categories, :name
    add_column :deal_categories, :name, :string, array: true
  end
end
