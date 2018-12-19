class CreateLargeInvestorCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :large_investor_categories do |t|
      t.string :name
      t.integer :serial_id

      t.timestamps
    end
  end
end
