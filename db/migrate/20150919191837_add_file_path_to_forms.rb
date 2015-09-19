class AddFilePathToForms < ActiveRecord::Migration
  def change
    add_column :forms, :file_path, :string
  end
end
