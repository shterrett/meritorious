class MarksController < ApplicationController
  def create
    @teacher = find_teacher
    AssigningMarks.new(@teacher, find_student).assign(build_mark)
    render json: { status: :ok }
  end

  private

  def find_teacher
    Teacher.find_by_id(params[:teacher_id])
  end

  def find_classroom
    Classroom.find_by_id(params[:classroom_id])
  end

  def find_student
    Student.find_by_id(params[:student_id])
  end

  def build_mark
    CreatingMarks.new(@teacher, find_classroom).create(mark_params)
  end

  def mark_params
    params.require(:mark).permit(:type)
  end
end
