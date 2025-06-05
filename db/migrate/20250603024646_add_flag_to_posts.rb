class AddFlagToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :flag, :integer
  end
end
