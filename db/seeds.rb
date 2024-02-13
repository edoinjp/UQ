# Required Gems
require 'faker'

# Clear previous records
puts 'Destroying all previous records'
User.destroy_all

# Seed Teacher
puts 'Creating teacher...'
teacher = User.create!(
  first_name: 'Rashad',
  last_name: 'DuPaty',
  learning_style: 'kinesthetic',
  email: 'abc@abc.com',
  password: 'password',
  teacher: true
)
puts "Mr. #{teacher.last_name} has been created!"

# Seed Students
puts 'Creating students...'
20.times do
  student = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    learning_style: %w[visual aural reading kinesthetic].sample,
    email: Faker::Internet.email,
    password: 'password',
    teacher: false
  )
  puts "#{student.first_name} has been created!"
end
puts 'All students are done!'

# Seed Classroom
puts 'Creating classroom...'
classroom = Classroom.create!(
  teacher_id: teacher.id
)
puts "Mr. #{classroom.teacher_id.last_name}'s classroom has been created!"
