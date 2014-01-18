require 'spec_helper'

describe CreatingMarks do
  it 'initializes with a teacher and classroom' do
    teacher = build_stubbed(:teacher)
    classroom = build_stubbed(:classroom)
    expect CreatingMarks.new(teacher, classroom)
  end

  it 'returns a mark with content type :merit' do
    teacher = build_stubbed(:teacher)
    classroom = build_stubbed(:classroom)
    mark_params = { type: :merit }
    context = CreatingMarks.new(teacher, classroom)

    mark = context.create(mark_params)

    expect(mark.content).to be_an_instance_of Merit
  end

  it 'returns a mark with content type :demerit' do
    teacher = build_stubbed(:teacher)
    classroom = build_stubbed(:classroom)
    mark_params = { type: :demerit }
    context = CreatingMarks.new(teacher, classroom)

    mark = context.create(mark_params)

    expect(mark.content).to be_an_instance_of Demerit
  end

  it 'associates the mark with the teacher and classroom' do
    teacher = build_stubbed(:teacher)
    classroom = build_stubbed(:classroom)
    mark_params = { type: :demerit }
    context = CreatingMarks.new(teacher, classroom)

    mark = context.create(mark_params)

    expect(mark.teacher).to eq teacher
    expect(mark.classroom).to eq classroom
  end
end
