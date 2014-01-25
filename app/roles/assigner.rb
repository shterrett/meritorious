module Assigner
  extend ActiveSupport::Concern

  included do
    has_many :marks
  end

  def can_assign?(assignee)
    students.include? assignee
  end
end
