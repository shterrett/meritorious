module Assigner
  extend ActiveSupport::Concern

  included do
    has_many :classrooms
    has_many :students, through: :classrooms
  end

  def can_assign?(assignee)
    students.include? assignee
  end
end
