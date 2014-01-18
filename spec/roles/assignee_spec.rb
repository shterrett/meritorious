require 'spec_helper'

describe Assignee do
  describe 'associations' do
    it 'has many marks' do
      assignee = create(:student).as(Assignee)
      expect(assignee).to have_many :marks
    end
  end

  describe 'assigning merits and demerits' do
    it 'can accept a merit through marks' do
      merit = create(:merit)
      assignee = create(:student).as(Assignee)
      assignee.marks.create(content: merit)
      expect(assignee.marks.map(&:content)).to include(merit)
    end

    it 'can accept a demerit through marks' do
      demerit = create(:demerit)
      assignee = create(:student).as(Assignee)
      assignee.marks.create(content: demerit)
      expect(assignee.marks.map(&:content)).to include(demerit)
    end
  end
end
