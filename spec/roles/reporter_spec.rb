require 'spec_helper'

describe Reporter do
  describe 'associations' do
    it 'has_many marks' do
      teacher = create(:teacher)

      reporter = teacher.as(Reporter)

      expect(reporter).to have_many(:marks)
    end

    it 'selects merits from marks' do
      teacher = create(:teacher)
      merit = create(:mark, content_type: 'Merit', content: create(:merit), teacher: teacher)

      reporter = teacher.as(Reporter)

      expect(reporter.merits).to match_array([merit])
    end

    it 'selects demerits from marks' do
      teacher = create(:teacher)
      demerit = create(:mark, content_type: 'Demerit', content: create(:demerit), teacher: teacher)

      reporter = teacher.as(Reporter)

      expect(reporter.demerits).to match_array([demerit])
    end
  end
end
