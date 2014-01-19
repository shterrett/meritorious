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
      teacher = classroom.teacher
      student = classroom.students.first
      merit = create(:merit)
      mark = build(:mark, teacher: teacher, classroom: classroom, content: merit)
      context = AssigningMarks.new(teacher, student)

      context.assign(mark)

      expect(mark.reload.student).to eq(student)
      expect(student.as(Assignee).marks).to match_array([mark])
    end
  end
end
