class AddDescriptionToLearningUnits < ActiveRecord::Migration[7.0]
  def change
    add_column :learning_units, :description, :string
  end
end
