class CreateDocuments < ActiveRecord::Migration
  def change
    
    create_table :documents do |t|
      t.string :filename
      t.string :content_type
      t.binary :file_contents
      t.string :file_size
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
    
    add_index :documents, [:user_id, :created_at]
    
  end
end
