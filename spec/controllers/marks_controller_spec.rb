require 'spec_helper'

describe MarksController do
  describe 'POST create' do
    it 'creates a mark for a student, teacher, classroom combination' do
      classroom = create(:classroom, :populated)
      teacher = classroom.teacher
      student = classroom.students.first

      sign_in teacher

      expect do
        post :create, { classroom_id: classroom.id,
                        student_id: student.id,
                        mark: { type: 'merit' }
                      }
      end.to change(Mark, :count).by(1)

      expect(student.as(Assignee).marks.pluck(:content_type)).to eq(['Merit'])
      expect(teacher.as(Assigner).marks.pluck(:content_type)).to eq(['Merit'])
      expect(classroom.marks.pluck(:content_type)).to eq(['Merit'])
    end
  end
end
