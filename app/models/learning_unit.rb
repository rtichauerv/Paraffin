class LearningUnit < ApplicationRecord
  has_many :resources
  has_many :curriculum_affiliations
  has_many :curriculums, through: :curriculum_affiliations
  has_many :completed_learning_units
end
