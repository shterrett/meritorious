require 'spec_helper'

describe CreatingMarks do
  it 'initializes with a teacher and class meeting' do
    teacher = build_stubbed(:teacher)
    meeting = build_stubbed(:meeting)
    expect CreatingMarks.new(teacher, meeting)
  end

  it 'returns a mark with content type :merit' do
    teacher = build_stubbed(:teacher)
    meeting = build_stubbed(:meeting)
    mark_params = { type: :merit }
    context = CreatingMarks.new(teacher, meeting)

    mark = context.create(mark_params)

    expect(mark.content).to be_an_instance_of Merit
  end

  it 'returns a mark with content type :demerit' do
    teacher = build_stubbed(:teacher)
    meeting = build_stubbed(:meeting)
    mark_params = { type: :demerit }
    context = CreatingMarks.new(teacher, meeting)

    mark = context.create(mark_params)

    expect(mark.content).to be_an_instance_of Demerit
  end

  it 'associates the mark with the teacher and meeting' do
    teacher = build_stubbed(:teacher)
    meeting = build_stubbed(:meeting)
    mark_params = { type: :demerit }
    context = CreatingMarks.new(teacher, meeting)

    mark = context.create(mark_params)

    expect(mark.teacher).to eq teacher
    expect(mark.meeting).to eq meeting
  end
end
