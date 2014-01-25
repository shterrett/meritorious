require 'spec_helper'

describe Student do
  it { expect(subject).to belong_to :school }
  it { expect(subject).to have_many :class_assignments }
  it { expect(subject).to have_many :classrooms }

  it { expect(subject).to validate_presence_of :student_id }

  it { expect(subject).to respond_to :as }

  describe 'student id' do
    it 'validates uniqueness within a school' do
      school = create(:school)
      existing_student = create(:student, school: school)
      student = build(:student,
                      student_id: existing_student.student_id,
                      school: school
                     )
      expect(student).not_to be_valid
      expect(student.errors).to have_key :student_id
    end

    it 'allows duplicate ids between schools' do
      school_1 = create(:school)
      school_2 = create(:school, name: 'new name')
      existing_student = create(:student, school: school_1)
      student = build(:student,
                      student_id: existing_student.student_id,
                      school: school_2
                     )
      expect(student).to be_valid
    end
  end
end
