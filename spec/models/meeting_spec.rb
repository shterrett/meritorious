require 'spec_helper'

describe Meeting do
  it { expect(subject).to belong_to :classroom }
  it { expect(subject).to have_many :marks }
  it { expect(subject).to respond_to :as }

  describe '#start_time' do
    it 'returns created_at in the time-zone of the server' do
      Timecop.freeze do
        meeting = create(:meeting)

        expect(meeting.start_time).to eq Time.zone.now
      end
    end
  end
end
