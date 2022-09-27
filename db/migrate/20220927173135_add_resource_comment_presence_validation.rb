class AddResourceCommentPresenceValidation < ActiveRecord::Migration[7.0]
  def change
    change_column_null :resource_comments, :content, false
  end
end
