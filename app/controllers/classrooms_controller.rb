class ClassroomsController < AuthenticatedController
  respond_to :js, only: [:new]

  def index
    @classrooms = current_teacher.classrooms
  end

  def show
    @classroom = find_classroom
    @students = @classroom.students
  end

  def new
    @classroom = current_teacher.classrooms.build
  end

  def create
    @classroom = current_teacher.classrooms.build(classroom_params)
    if @classroom.save
      flash[:success] = 'Classroom created successfully'
    else
      flash[:failure] = 'Could not create classroom'
    end
    redirect_to classrooms_path
  end

  private

  def find_classroom
    current_teacher.classrooms.find(params[:id])
  end

  def classroom_params
    params.require(:classroom).permit(:name)
  end
end
