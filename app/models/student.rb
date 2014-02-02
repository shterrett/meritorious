class Student < ActiveRecord::Base
  include Schizo::Data

  belongs_to :school

  has_many :class_assignments
  has_many :classrooms, through: :class_assignments

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :student_id, presence: { message: :blank },
                         uniqueness: { scope: :school_id,
                                       message: :unique
                                     }

  def name
    "#{first_name} #{last_name}"
  end
end
