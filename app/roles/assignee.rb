module Assignee
  extend ActiveSupport::Concern

  included do
    has_many :marks
  end
end
