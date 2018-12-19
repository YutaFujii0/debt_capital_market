class CreateSmallInvestorCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :small_investor_categories do |t|
      t.string :name
      t.integer :serial_id
      t.references :large_investor_category, foreign_key: true

      t.timestamps
    end
  end
end
