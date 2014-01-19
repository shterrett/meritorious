class Student < ActiveRecord::Base
  include Schizo::Data

  belongs_to :school

  has_many :class_assignments
  has_many :classrooms, through: :class_assignments
end
