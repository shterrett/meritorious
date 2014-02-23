class MeetingReportExportsController < AuthenticatedController
  def create
    meeting = current_teacher.meetings.find(params[:meeting_id])
    report = Reporting.new(meeting)
    @data = report.csv_data(:meeting)
  end
end
