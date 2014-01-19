require 'spec_helper'

describe Teacher do
  it { expect(subject).to respond_to :as }
  it { expect(subject).to validate_presence_of(:password) }
  it { expect(subject).to validate_presence_of(:email) }

  it 'validates email is unique' do
    create(:teacher, email: 'test@example.com')
    expect(subject).to validate_uniqueness_of(:email)
  end
end
