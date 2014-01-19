class Meeting < ActiveRecord::Base
  belongs_to :classroom

  has_many :marks
end
