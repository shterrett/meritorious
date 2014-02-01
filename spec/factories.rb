FactoryGirl.define do
  factory :school do
    name 'Schrodinger High School'
  end

  factory :teacher do
    first_name 'Richard'
    last_name 'Feynman'
    email 'physics@theuniverse.com'
    password 'password123'
  end

  factory :student do
    first_name 'Ferris'
    last_name 'Bueller'
    email 'fbueller@example.com'
    school
    sequence(:student_id) { |n| "#{school.id}-#{n}" }
  end

  factory :classroom do
    teacher
    school
    name 'Quantum Mechanics'

    trait :populated do
      after(:create) do |classroom|
        classroom.students << create(:student, school: classroom.school)
      end
    end
  end

  factory :class_assignment do
    student nil
    classroom nil
  end

  factory :meeting do
    classroom
  end

  factory :mark do
    student nil
    teacher nil
    meeting nil
    content nil
    content_type 'Merit'
  end

  factory :merit do
  end

  factory :demerit do
  end
end
