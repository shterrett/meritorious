require 'spec_helper'

feature 'importing students into classrooms' do
  scenario 'import students into a classroom' do
    classroom = create(:classroom)
    teacher = classroom.teacher

    sign_in_as teacher
    visit classroom_path(classroom)

    import = StudentImport.new(classroom)
    import.import_file 'students.csv'
    expect(import).to have_success_flash
    expect(import).to have_student 'Jane Austen'
    expect(import).to have_student 'Mark Twain'
  end

  scenario 'import students into a classroom with errors' do
    classroom = create(:classroom)
    teacher = classroom.teacher

    sign_in_as teacher
    visit classroom_path(classroom)
    import = StudentImport.new(classroom)
    import.import_file 'valid_and_invalid_students.csv'

    expect(import).to have_error_flash
    expect(import).to have_student 'Jane Austen'
    expect(import).to have_student 'Mark Twain'
    expect(import).to have_error "Charles 2cities: Last name can't be blank"
  end

  scenario 'import students fails' do
    classroom = create(:classroom)
    teacher = classroom.teacher

    sign_in_as teacher
    visit classroom_path(classroom)
    import = StudentImport.new(classroom)
    import.import_file 'students_missing_column.csv'

    expect(import).to have_error_flash
    expect(import).to have_error 'file: Missing column: student_id'
  end
end
