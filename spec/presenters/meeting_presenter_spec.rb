require 'spec_helper'

describe MeetingPresenter do
  describe 'classroom methods' do
    it 'delegates name to classroom' do
      classroom = create(:classroom)
      meeting = create(:meeting, classroom: classroom)

      presenter = MeetingPresenter.new(meeting)

      expect(presenter.name).to eq classroom.name
    end

    it 'delegates students to classroom' do
      classroom = create(:classroom)
      meeting = create(:meeting, classroom: classroom)
      students = create_list(:student, 2, school: classroom.school)
      classroom.students << students

      presenter = MeetingPresenter.new(meeting)

      expect(presenter.students).to match_array classroom.students
    end
  end

  describe 'meeting methods' do
    include Rails.application.routes.url_helpers

    it 'displays the meeting start time' do
      meeting = create(:meeting)

      presenter = MeetingPresenter.new(meeting)

      expect(presenter.start_time).to eq I18n.l(meeting.start_time, format: :day_time)
    end

    it 'returns the meeting id for to_param to allow paths to be constructed' do
      meeting = create(:meeting)

      presenter = MeetingPresenter.new(meeting)

      expect(presenter.to_param).to eq(meeting.id.to_s)
      expect(meeting_path(presenter)).to eq(meeting_path(meeting))
    end
  end
end
