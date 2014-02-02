class Meeting < ActiveRecord::Base
  include Schizo::Data

  belongs_to :classroom

  has_many :marks
end
