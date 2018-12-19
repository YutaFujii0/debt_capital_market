class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.references :investor, foreign_key: true
      t.references :marketing, foreign_key: true
      t.string :comment
      t.string :volume
      t.integer :intent

      t.timestamps
    end
  end
end
