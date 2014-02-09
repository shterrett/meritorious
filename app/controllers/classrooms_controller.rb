class ClassroomsController < AuthenticatedController
  def index
    @classrooms = current_teacher.classrooms
  end

  def show
    @classroom = find_classroom
    @students = @classroom.students
  end

  private

  def find_classroom
    current_teacher.classrooms.find(params[:id])
  end
end
