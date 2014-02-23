require 'spec_helper'

describe ClassroomsController do
  describe 'GET new' do
    it 'instantiates a classroom for the teacher' do
      teacher = create(:teacher)

      sign_in teacher

      get :new, format: :js

      classroom = assigns(:classroom)
      expect(classroom.teacher).to eq teacher
      expect(classroom.school).to eq teacher.school
    end
  end

  describe 'POST create' do
    it 'creates a classroom for the teacher' do
      teacher = create(:teacher)

      sign_in teacher

      expect do
        post :create,
             classroom: { name: 'Quantum Physics' },
             format: :js
      end.to change(Classroom, :count).by(1)

      classroom = Classroom.find_by(name: 'Quantum Physics')
      expect(classroom.teacher).to eq teacher
      expect(classroom.school).to eq teacher.school
      expect(flash[:success]).to eq 'Classroom created successfully'
    end

    it 'fails to create a classroom' do
      teacher = create(:teacher)

      sign_in teacher

      expect do
        post :create,
             classroom: { name: '' },
             format: :js
      end.to change(Classroom, :count).by(0)

      expect(flash[:failure]).to eq 'Could not create classroom'
    end
  end
end
