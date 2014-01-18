FactoryGirl.define do
  factory :teacher do
    first_name 'Richard'
    last_name 'Feynman'
    email 'physics@theuniverse.com'
  end

  factory :student do
    first_name 'Ferris'
    last_name 'Bueller'
    email 'fbueller@example.com'
  end

  factory :classroom do
    teacher
    name 'Quantum Mechanics'

    trait :populated do
      after(:create) do |classroom|
        classroom.students << create(:student)
      end
    end
  end

  factory :class_assignment do
    student nil
    classroom nil
  end

  factory :mark do
    student nil
    teacher nil
    classroom nil
    content nil
    content_type 'Merit'
  end

  factory :merit do
  end

  factory :demerit do
  end
end
