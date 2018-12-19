class CreateUserIssuers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_issuers do |t|
      t.references :user, foreign_key: true
      t.references :issuer, foreign_key: true
      t.boolean :main

      t.timestamps
    end
  end
end
