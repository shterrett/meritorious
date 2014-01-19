require 'spec_helper'

describe Mark do
  it { expect(subject).to belong_to :content }
  it { expect(subject).to belong_to :teacher }
  it { expect(subject).to belong_to :student }
  it { expect(subject).to belong_to :meeting }

  describe 'polymorhism' do
    it 'can be a merit' do
      merit = Merit.new
      mark = Mark.new(content: merit)
      mark.save
      expect(mark.content).to be_an_instance_of Merit
    end

    it' can be a demerit' do
      demerit = Demerit.new
      mark = Mark.new(content: demerit)
      mark.save
      expect(mark.content).to be_an_instance_of Demerit
    end
  end
end
