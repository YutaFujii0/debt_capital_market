class CreateIssuers < ActiveRecord::Migration[5.2]
  def change
    create_table :issuers do |t|
      t.string :name
      t.references :small_code, foreign_key: true
      t.string :list_id

      t.timestamps
    end
  end
end
