class CreatingMarks
  def initialize(teacher, classroom)
    @teacher = teacher
    @classroom = classroom
  end

  def create(mark_params)
    Mark.new.tap do |mark|
      mark.teacher = @teacher
      mark.classroom = @classroom
      mark.content = build_content(mark_params)
    end
  end

  def build_content(mark_params)
    mark_params[:type].to_s.capitalize.safe_constantize.create
  end
end
