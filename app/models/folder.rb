class Folder < ActiveRecord::Base
    acts_as_tree
    belongs_to :user
    has_many :documents
    
    def initialize(params = {})
    folder = params.delete(:folder)
    super
    if folder
      self.name = sanitize_filename(folder.original_name)
      self.parent_id = folder.parent_id
      self.user_id = folder.user_id
    end
    end
end