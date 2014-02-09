require 'spec_helper'

describe Teacher do
  it { expect(subject).to have_many :classrooms }
  it { expect(subject).to have_many :meetings }
  it { expect(subject).to have_many :students }
  it { expect(subject).to belong_to :school }
  it { expect(subject).to respond_to :as }
  it { expect(subject).to validate_presence_of(:password) }
  it { expect(subject).to validate_presence_of(:email) }
  it { expect(subject).to validate_presence_of(:first_name) }
  it { expect(subject).to validate_presence_of(:last_name) }

  it 'validates email is unique' do
    create(:teacher, email: 'test@example.com')
    expect(subject).to validate_uniqueness_of(:email)
  end

  describe '#name' do
    it 'concatonates the first and last name' do
      teacher = build(:teacher)

      expect(teacher.name).to eq "#{teacher.first_name} #{teacher.last_name}"
    end
  end
end
