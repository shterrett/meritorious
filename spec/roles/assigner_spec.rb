require 'spec_helper'

describe Assigner do
  describe 'associations' do
    it 'has_many marks' do
      assigner = create(:teacher).as(Assigner)
      expect(assigner).to have_many(:marks)
    end
  end

  describe '#can_assign?' do
    it 'returns true if the assignee is a student of the assigner' do
      school = create(:school)
      assigner = create(:teacher, school: school).as(Assigner)
      classroom = create(:classroom, teacher: assigner, school: school)
      assignee = create(:student, school: school).as(Assignee)
      assignee.classrooms << classroom

      expect(assigner.can_assign?(assignee)).to be_true
    end

    it 'returns false if the assignee is not a student of the assigner' do
      assigner = create(:teacher).as(Assigner)
      assignee = create(:student).as(Assignee)

      expect(assigner.can_assign?(assignee)).to be_false
    end
  end
end
