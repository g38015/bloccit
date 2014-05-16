class AddFriendlyIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :slug, :string
    add_index :topics, :slug
  end
end
