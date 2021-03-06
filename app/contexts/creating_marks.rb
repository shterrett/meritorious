class CreatingMarks
  def initialize(teacher, meeting)
    @teacher = teacher
    @meeting = meeting
  end

  def create(mark_params)
    Mark.new.tap do |mark|
      mark.teacher = @teacher
      mark.meeting = @meeting
      mark.content = build_content(mark_params)
    end
  end

  def build_content(mark_params)
    mark_params[:type].to_s.capitalize.safe_constantize.create
  end
end
