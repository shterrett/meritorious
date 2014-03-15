require 'spec_helper'

describe ImportingStudents do
  it 'initializes with an file and a classroom' do
    file = uploaded_file('students.csv')
    classroom = create(:classroom)
    expect(ImportingStudents.new(file, classroom))
  end

  it 'successfully imports students' do
    file = uploaded_file('students.csv')
    classroom = create(:classroom)
    importing = ImportingStudents.new(file, classroom)
    expect do
      importing.import
    end.to change(Student, :count).by(2)
  end

  it 'returns the errors hash from the import' do
    file = uploaded_file('student_missing_last_name.csv')
    classroom = create(:classroom)
    errors = Student.create(first_name: 'Charles', student_id: '2cities').errors.full_messages
    importing = ImportingStudents.new(file, classroom)

    expect(importing.import).to eq({ 'Charles 2cities' => errors })
  end

  it 'returns an empty errors hash if the import was successful' do
    file = uploaded_file('students.csv')
    classroom = create(:classroom)
    importing = ImportingStudents.new(file, classroom)

    expect(importing.import).to eq({})
  end
end
