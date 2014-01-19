require 'spec_helper'

describe ClassAssignment do
  it { expect(subject).to belong_to :student }
  it { expect(subject).to belong_to :classroom }
end
