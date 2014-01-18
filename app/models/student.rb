class Student < ActiveRecord::Base
  include Schizo::Data

  has_many :class_assignments
  has_many :classrooms, through: :class_assignments
end
