class MarksController < AuthenticatedController
  def create
    AssigningMarks.new(current_teacher, find_student).assign(build_mark)
    render json: { status: :ok }
  end

  private

  def find_classroom
    Classroom.find_by_id(params[:classroom_id])
  end

  def find_student
    Student.find_by_id(params[:student_id])
  end

  def build_mark
    CreatingMarks.new(current_teacher, find_classroom).create(mark_params)
  end

  def mark_params
    params.require(:mark).permit(:type)
  end
end
