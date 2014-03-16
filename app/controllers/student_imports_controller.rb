class StudentImportsController < AuthenticatedController
  def create
    @classroom = current_teacher.classrooms.find(params[:classroom_id])
    @errors = ImportingStudents.new(params[:student_imports], @classroom).import
    if @errors.empty?
      flash[:success] = 'Students successfully imported'
      redirect_to classroom_path(params[:classroom_id])
    else
      @students = @classroom.students
      flash[:notice] = 'There were errors in the import'
      render 'classrooms/show'
    end
  end
end
