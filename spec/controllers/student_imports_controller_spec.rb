require 'spec_helper'

describe StudentImportsController do
  it 'imports students for a given classroom' do
    classroom = create(:classroom)
    teacher = classroom.teacher

    sign_in teacher

    expect do
      post :create, classroom_id: classroom.id, student_imports: uploaded_file('students.csv')
    end.to change(Student, :count).by(2)

    expect(response).to redirect_to(classroom_path(classroom))
    expect(flash[:success]).to eq 'Students successfully imported'
  end

  it 'imports students with errors' do
    classroom = create(:classroom)
    teacher = classroom.teacher
    errors = Student.create(first_name: 'Charles', student_id: '2cities').errors.full_messages

    sign_in teacher

    expect do
      post :create, classroom_id: classroom.id, student_imports: uploaded_file('valid_and_invalid_students.csv')
    end.to change(Student, :count).by(2)
    expect(assigns(:errors)).to eq({ 'Charles 2cities' => errors })
    expect(assigns(:students)).to match_array classroom.students
    expect(response).to render_template 'classrooms/show'
  end
end
