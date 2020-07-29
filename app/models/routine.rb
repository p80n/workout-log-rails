class Routine < ApplicationRecord
  belongs_to :muscle_group
  has_many :exerciess, through: :routine_exercise
end
