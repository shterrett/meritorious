require 'spec_helper'

describe AssigningMarks do
  describe 'initialization and roles' do
    it 'initializes with a teacher and a student' do
      teacher = build_stubbed(:teacher)
      student = build_stubbed(:student)
      expect AssigningMarks.new(teacher, student)
    end

    it 'gives the teacher the :assigner role' do
      teacher = build_stubbed(:teacher)
      teacher.stub(:as)
      student = build_stubbed(:student)
      AssigningMarks.new(teacher, student)
      expect(teacher).to have_received(:as).with(Assigner)
    end

    it 'gives the student the :assignee role' do
      teacher = build_stubbed(:teacher)
      student = build_stubbed(:student)
      student.stub(:as)
      AssigningMarks.new(teacher, student)
      expect(student).to have_received(:as).with(Assignee)
    end
  end

  describe 'assigning marks' do
    it 'adds the mark to the student' do
      classroom = create(:classroom, :populated)
      meeting = create(:meeting, classroom: classroom)
      teacher = classroom.teacher
      student = classroom.students.first
      merit = create(:merit)
      mark = build(:mark, teacher: teacher, meeting: meeting, content: merit)
      context = AssigningMarks.new(teacher, student)

      context.assign(mark)

      expect(mark.reload.student).to eq(student)
      expect(student.as(Assignee).marks).to match_array([mark])
    end

    it 'does not assign the mark if the student does not belong to the teacher' do
      school = create(:school)
      classroom = create(:classroom, :populated, school: school)
      meeting = create(:meeting, classroom: classroom)
      teacher = classroom.teacher
      student = create(:student, school: school)
      merit = create(:merit)
      mark = build(:mark, teacher: teacher, meeting: meeting, content: merit)
      context = AssigningMarks.new(teacher, student)

      result = context.assign(mark)

      expect do
        mark.reload
      end.to raise_error(ActiveRecord::RecordNotFound)
      expect(result).to be_nil
    end
  end
end
