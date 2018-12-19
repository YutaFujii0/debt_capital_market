class CreateUserInvestors < ActiveRecord::Migration[5.2]
  def change
    create_table :user_investors do |t|
      t.references :user, foreign_key: true
      t.references :investor, foreign_key: true
      t.boolean :main

      t.timestamps
    end
  end
end
