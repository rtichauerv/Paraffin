class AddDescriptionToModels < ActiveRecord::Migration[7.0]
  def change
    add_column :curriculums, :description, :string
    add_column :learning_units, :description, :string
    add_column :resources, :description, :string
  end
end
