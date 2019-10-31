class AddPolymorphismToLikesTable < ActiveRecord::Migration[6.0]
  def change
      add_column :likes, :likeable_id, :bigint
      add_column :likes, :likeable_type, :string
      remove_column :likes, :comment_id
      remove_column :likes, :artwork_id
  end
  add_index :likes, [:likeable_id, :likeable_type]
end
