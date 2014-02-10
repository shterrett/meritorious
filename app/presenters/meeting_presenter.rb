class MeetingPresenter
  def initialize(meeting)
    @meeting = meeting
    @classroom = meeting.classroom
  end

  def name
    classroom.name
  end

  def start_time
    I18n.l(meeting.start_time, format: :day_time)
  end

  def students
    classroom.students
  end

  def to_param
    meeting.id.to_s
  end

  private
  attr_reader :classroom, :meeting
end
