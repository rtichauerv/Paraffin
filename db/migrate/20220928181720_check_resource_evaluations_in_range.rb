class CheckResourceEvaluationsInRange < ActiveRecord::Migration[7.0]
  def change
    add_check_constraint :resource_evaluations, 'evaluation IN (1,2,3,4,5)', 
    name: 'evaluation_check_constraint'
  end
end
