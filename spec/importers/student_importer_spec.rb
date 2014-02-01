require 'spec_helper'

describe StudentImporter do
  it 'imports students a csv of students into a specific classroom' do
    classroom = create(:classroom)
    student_importer = StudentImporter.new(file('students.csv'), classroom)

    student_1_attributes = { first_name: 'Mark',
                             last_name: 'Twain',
                             student_id: 'abc123'
                           }
    student_2_attributes = { first_name: 'Jane',
                             last_name: 'Austen',
                             student_id: 'def456'
                           }

    expect do
      student_importer.import
    end.to change(Student, :count).by(2)

    expect(classroom.students.map do |student|
             student.attributes.symbolize_keys
               .slice(:first_name, :last_name, :student_id)
           end
          ).to match_array([student_1_attributes, student_2_attributes])
    expect(classroom.students.map do |student|
             student.school
           end
          ).to match_array([classroom.school, classroom.school])
  end

  it 'does not import a user who already exists in the classroom' do
    classroom = create(:classroom)

    student_1_attributes = { first_name: 'Mark',
                             last_name: 'Twain',
                             student_id: 'abc123'
                           }
    student_2_attributes = { first_name: 'Jane',
                             last_name: 'Austen',
                             student_id: 'def456'
                           }
    existing_student = Student.create(student_1_attributes.merge(school_id: classroom.school.id))
    classroom.students << existing_student

    student_importer = StudentImporter.new(file('students.csv'), classroom)

    expect do
      student_importer.import
    end.to change(Student, :count).by(1)

    expect(classroom.students.map do |student|
      student.attributes.symbolize_keys
        .slice(:first_name, :last_name, :student_id)
      end
    ).to match_array([student_1_attributes, student_2_attributes])
  end

  it 'adds a student who exists at the school to the classroom without importing them' do
    classroom = create(:classroom)

    student_1_attributes = { first_name: 'Mark',
                             last_name: 'Twain',
                             student_id: 'abc123'
                           }
    student_2_attributes = { first_name: 'Jane',
                             last_name: 'Austen',
                             student_id: 'def456'
                           }
    existing_student = Student.create(student_1_attributes.merge(school_id: classroom.school.id))

    student_importer = StudentImporter.new(file('students.csv'), classroom)

    expect do
      student_importer.import
    end.to change(Student, :count).by(1)

    expect(classroom.students.map do |student|
      student.attributes.symbolize_keys
        .slice(:first_name, :last_name, :student_id)
      end
    ).to match_array([student_1_attributes, student_2_attributes])
  end

  it 'imports the email address if provided' do
    classroom = create(:classroom)
    student_attributes = { first_name: 'Anthony',
                           last_name: 'Burgess',
                           email: 'aburgess@example.com',
                           student_id: 'krowkcolc'
                         }

    student_importer = StudentImporter.new(file('student_with_email.csv'), classroom)

    expect do
      student_importer.import
    end.to change(Student, :count).by(1)

    expect(classroom.students.map do |student|
             student.attributes.symbolize_keys
               .slice(:first_name, :last_name, :email, :student_id)
           end
          ).to match_array([student_attributes])
  end

  it 'ignores attributes not on the student model' do
    classroom = create(:classroom)
    student_attributes = { first_name: 'Anthony',
                           last_name: 'Burgess',
                           email: 'aburgess@example.com',
                           student_id: 'krowkcolc'
                         }

    student_importer = StudentImporter.new(file('student_with_extra_columns.csv'), classroom)

    expect do
      student_importer.import
    end.to change(Student, :count).by(1)

    expect(classroom.students.map do |student|
             student.attributes.symbolize_keys
               .slice(:first_name, :last_name, :email, :student_id)
           end
          ).to match_array([student_attributes])
  end

  it 'does not add a class_assignment record if the student record is invalid' do
    classroom = create(:classroom)
    student_importer = StudentImporter.new(file('student_missing_id.csv'), classroom)

    expect do
      student_importer.import
    end.to change(ClassAssignment, :count).by(0)
  end

  it 'records an error if a student is missing the student id' do
    classroom = create(:classroom)
    student_importer = StudentImporter.new(file('student_missing_id.csv'), classroom)

    errors = Student.create(first_name: 'Ayn', last_name: 'Rand').errors.full_messages

    expect do
      student_importer.import
    end.to change(Student, :count).by(0)
    expect(student_importer.row_errors).to eq({ 'Ayn Rand' => errors })
  end

  it 'records an error if a student is missing their first name' do
    classroom = create(:classroom)
    student_importer = StudentImporter.new(file('student_missing_first_name.csv'), classroom)
    errors = Student.create(last_name: 'Dickens', student_id: '2cities').errors.full_messages

    expect do
      student_importer.import
    end.to change(Student, :count).by(0)

    expect(student_importer.row_errors).to eq({ 'Dickens 2cities' => errors })
  end

  it 'records an error if a student is missing their last name' do
    classroom = create(:classroom)
    student_importer = StudentImporter.new(file('student_missing_last_name.csv'), classroom)
    errors = Student.create(first_name: 'Charles', student_id: '2cities').errors.full_messages

    expect do
      student_importer.import
    end.to change(Student, :count).by(0)

    expect(student_importer.row_errors).to eq({ 'Charles 2cities' => errors })
  end

  it 'records an error and does not import if a required column is missing from the file' do
    classroom = create(:classroom)
    student_importer = StudentImporter.new(file('students_missing_column.csv'), classroom)

    expect do
      student_importer.import
    end.to change(Student, :count).by(0)

    expect(student_importer.row_errors).to eq({ 'file' => 'Missing column: student_id' })
  end

  def file(file_name)
    Rack::Test::UploadedFile.new(Rails.root.join('spec', 'data', 'importers', file_name), 'text/csv')
  end
end
