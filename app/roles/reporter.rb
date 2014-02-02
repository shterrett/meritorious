module Reporter
  extend ActiveSupport::Concern

  included do
    has_many :marks
  end

  def merits
    marks.where(content_type: 'Merit')
  end

  def demerits
    marks.where(content_type: 'Demerit')
  end
end
