require 'spec_helper'

describe MeetingReportExportsController do
  it 'exports a csv of the by_meeting report' do
    school = create(:school)
    teacher = create(:teacher, school: school)
    classroom = create(:classroom, teacher: teacher, school: school)
    student = create(:student, school: school)
    classroom.students << student
    content = create(:merit)
    meeting = create(:meeting, classroom: classroom)
    create(:mark,
            student: student,
            teacher: teacher,
            meeting: meeting,
            content: content
           )

    sign_in teacher
    post :create, meeting_id: meeting.id, format: :csv

    report = Reporting.new(meeting)
    data = report.csv_data(:meeting)
    expect(assigns(:data).send(:data)).to eq data.send(:data)
  end
end
