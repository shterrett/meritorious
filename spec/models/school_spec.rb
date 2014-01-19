require 'spec_helper'

describe School do
  it { expect(subject).to have_many :teachers }
  it { expect(subject).to have_many :students }
  it { expect(subject).to have_many :classrooms }

  it { expect(subject).to validate_presence_of(:name) }
  it 'validates that the name is unique' do
    create(:school, name: 'test school')
    expect(subject).to validate_uniqueness_of(:name)
  end
end
