class Classroom < ActiveRecord::Base
  belongs_to :school
  belongs_to :teacher

  has_many :class_assignments
  has_many :students, through: :class_assignments
  has_many :meetings
  has_many :marks, through: :meetings

  validates :name, presence: true
end
