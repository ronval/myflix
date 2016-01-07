class AddForeignKeyForUserIds < ActiveRecord::Migration
  def change

    add_column :reviews, :user_id, :integer
    add_column :reviews, :review_content, :text
  end
end
