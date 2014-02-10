class Meeting < ActiveRecord::Base
  include Schizo::Data

  belongs_to :classroom

  has_many :marks

  def start_time
    created_at.in_time_zone
  end
end
