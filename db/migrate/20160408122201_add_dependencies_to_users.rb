class AddDependenciesToUsers < ActiveRecord::Migration
  def change
    add_column :documents, :belongs_to, :user, index: true
  end
end
