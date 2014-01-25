class Student < ActiveRecord::Base
  include Schizo::Data

  belongs_to :school

  has_many :class_assignments
  has_many :classrooms, through: :class_assignments

  validates :student_id, presence: true,
                         uniqueness: { scope: :school_id }
end
