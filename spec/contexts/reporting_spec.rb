require 'spec_helper'

describe Reporting do
  it 'initializes a reporter' do
    meeting = create(:meeting)
    meeting.stub(:as).and_call_original

    Reporting.new(meeting)

    expect(meeting).to have_received(:as).with(Reporter).exactly(1).times
  end

  describe 'by_meeting' do
    it 'reduces the set of marks by student' do
      classroom = create(:classroom)
      meeting = create(:meeting, classroom: classroom)
      student = create(:student, school: classroom.school)
      student.classrooms << classroom
      marks = [
                create(:mark, content_type: 'Merit', content: create(:merit)),
                create(:mark, content_type: 'Merit', content: create(:merit)),
                create(:mark, content_type: 'Demerit', content: create(:demerit)),
                create(:mark, content_type: 'Demerit', content: create(:demerit))
              ]
      student.as(Assignee) do |assignee|
        assignee.marks << marks
      end
      meeting.marks << marks

      reporting = Reporting.new(meeting)
      report = reporting.csv_data(:meeting)

      expect(report.first).to eq([student.name, student.student_id, 2, 2])
    end
  end

  describe 'by_student_meeting' do
    it 'returns the marks for a particular student for a particular meeting (as the reporter)' do
      classroom = create(:classroom)
      meeting = create(:meeting, classroom: classroom)
      student = create(:student, school: classroom.school)
      student.classrooms << classroom
      marks = [
                create(:mark, content_type: 'Merit', content: create(:merit)),
                create(:mark, content_type: 'Merit', content: create(:merit)),
                create(:mark, content_type: 'Demerit', content: create(:demerit)),
                create(:mark, content_type: 'Demerit', content: create(:demerit))
              ]
      student.as(Assignee) do |assignee|
        assignee.marks << marks
      end
      meeting.marks << marks

      reporting = Reporting.new(meeting)
      report = reporting.data(:student_meeting, student)

      expect(report).to be_an_instance_of StudentMarksPresenter
      expect(report.merits_count).to eq(2)
      expect(report.demerits_count).to eq(2)
    end
  end
end
