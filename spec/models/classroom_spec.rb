require 'spec_helper'

describe Classroom do
  it { expect(subject).to belong_to :teacher }
  it { expect(subject).to belong_to :school }
  it { expect(subject).to have_many :class_assignments }
  it { expect(subject).to have_many :students }
  it { expect(subject).to have_many :meetings }
  it { expect(subject).to have_many :marks }

  describe 'valdiations' do
    it { expect(subject).to validate_presence_of :name }
  end
end
