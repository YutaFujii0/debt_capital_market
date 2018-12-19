class CreateDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :deals do |t|
      t.references :issuer, foreign_key: true
      t.references :deal_category, foreign_key: true
      t.date :pricing
      t.date :settlement

      t.timestamps
    end
  end
end
