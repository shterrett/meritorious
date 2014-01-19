class Mark < ActiveRecord::Base
  belongs_to :student
  belongs_to :teacher
  belongs_to :meeting
  belongs_to :content, polymorphic: true
end
