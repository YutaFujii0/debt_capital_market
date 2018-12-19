class CreateInvestors < ActiveRecord::Migration[5.2]
  def change
    create_table :investors do |t|
      t.string :name
      t.string :team
      t.references :small_investor_category, foreign_key: true
      t.string :address
      t.integer :tel
      t.string :email

      t.timestamps
    end
  end
end
