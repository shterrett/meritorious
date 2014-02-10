class MeetingsController < AuthenticatedController
  def create
    @meeting = Meeting.create(classroom: find_classroom)
    redirect_to meeting_path(@meeting)
  end

  def show
    @meeting = MeetingPresenter.new(find_meeting)
  end

  private

  def find_classroom
    current_teacher.classrooms.find(params[:classroom_id])
  end

  def find_meeting
    current_teacher.meetings.find(params[:id])
  end
end
