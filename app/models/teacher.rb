class Teacher < ActiveRecord::Base
  include Schizo::Data

  has_many :classrooms
  has_many :students, through: :classrooms
  has_many :meetings, through: :classrooms
  belongs_to :school

  devise(:database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable
        )
end
