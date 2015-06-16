class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true, foreign_key: true
      t.string :category
      t.string :description
      t.date :date_posted
      t.date :deadline

      t.timestamps null: false
    end
  end
end
