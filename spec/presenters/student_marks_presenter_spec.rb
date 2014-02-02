require 'spec_helper'

describe StudentMarksPresenter do
  describe 'student methods' do
    it 'returns the student name' do
      student = create(:student)
      presenter = StudentMarksPresenter.new(student)

      expect(presenter.name).to eq(student.name)
    end

    it 'returns the student_id' do
      student = create(:student)
      presenter = StudentMarksPresenter.new(student)

      expect(presenter.student_id).to eq(student.student_id)
    end

    it 'can add a list of merits to existing merits' do
      merit = create(:mark, content_type: 'Merit', content: create(:merit))
      student = create(:student)
      presenter = StudentMarksPresenter.new(student)
      presenter.add_merits([merit])

      expect(presenter.merits).to match_array([merit])
    end

    it 'can add a list of demerits to existing demerits' do
      demerit = create(:mark, content_type: 'Merit', content: create(:demerit))
      student = create(:student)
      presenter = StudentMarksPresenter.new(student)
      presenter.add_demerits([demerit])

      expect(presenter.demerits).to match_array([demerit])
    end

    it 'formats the information in a csv row' do
      merit = create(:mark, content_type: 'Merit', content: create(:merit))
      demerit = create(:mark, content_type: 'Demerit', content: create(:demerit))
      student = create(:student)
      presenter = StudentMarksPresenter.new(student)
      presenter.add_merits([merit])
      presenter.add_demerits([demerit])

      expect(presenter.to_row).to eq([student.name, student.student_id, 1, 1])
    end
  end
end
