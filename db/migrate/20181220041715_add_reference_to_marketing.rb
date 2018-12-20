class AddReferenceToMarketing < ActiveRecord::Migration[5.2]
  def change
    add_reference :marketings, :tranche, foreign_key: true
  end
end
