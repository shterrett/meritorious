require 'spec_helper'

describe Student do
  it { expect(subject).to belong_to :school }
  it { expect(subject).to have_many :class_assignments }
  it { expect(subject).to have_many :classrooms }

  it { expect(subject).to respond_to :as }
end
