require 'spec_helper'

describe Meeting do
  it { expect(subject).to belong_to :classroom }
  it { expect(subject).to have_many :marks }
end
