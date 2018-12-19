class CreateVeryImportantInvestors < ActiveRecord::Migration[5.2]
  def change
    create_table :very_important_investors do |t|
      t.references :tranche, foreign_key: true
      t.references :investor, foreign_key: true

      t.timestamps
    end
  end
end
