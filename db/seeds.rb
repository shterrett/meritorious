# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

school = School.create(name: 'Neighborhood House Charter School')
teacher = Teacher.create(first_name: 'Kate',
                         last_name: 'Gasaway',
                         email: 'kate@nhcs.org',
                         password: 'password',
                         password_confirmation: 'password',
                         school: school
                        )
classroom_1 = Classroom.create(name: 'Number Theory',
                               teacher: teacher,
                               school: school
                              )
classroom_2 = Classroom.create(name: 'Probability and Statistics',
                               teacher: teacher,
                               school: school
                              )
student_group_1 = (1..10).to_a.map do |n|
  Student.create(first_name: Faker::Name.first_name,
                 last_name: Faker::Name.last_name,
                 email: Faker::Internet.email,
                 student_id: "nhcs-1-#{n}",
                 school: school
                )
end

student_group_2 = (1..10).to_a.map do |n|
  Student.create(first_name: Faker::Name.first_name,
                 last_name: Faker::Name.last_name,
                 email: Faker::Internet.email,
                 student_id: "nhcs-2-#{n}",
                 school: school
                )
end

student_group_3 = (1..10).to_a.map do |n|
  Student.create(first_name: Faker::Name.first_name,
                 last_name: Faker::Name.last_name,
                 email: Faker::Internet.email,
                 student_id: "nhcs-3-#{n}",
                 school: school
                )
end

classroom_1.students << [*student_group_1, *student_group_3]
classroom_2.students << [*student_group_2, *student_group_3]
