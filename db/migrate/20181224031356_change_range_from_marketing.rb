class ChangeRangeFromMarketing < ActiveRecord::Migration[5.2]
  def change
    remove_column :marketings, :range
    add_column :marketings, :range, :float, array: true
  end
end
