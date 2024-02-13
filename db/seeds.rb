# Required Gems
require 'faker'

# Clear previous records
Participation.destroy_all

Classroom.destroy_all
puts 'All classrooms are destroyed'
puts 'Destroying all previous records'
User.destroy_all
puts 'All users are destroyed'
Lesson.destroy_all
puts 'All lessons are destroyed'
Question.destroy_all
Choice.destroy_all
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
puts teacher.persisted?
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
  user: teacher,
  name: "Classroom Name",

)
puts "Mr. DuPaty's classroom has been created!"

# Seed Lesson
puts 'Creating a lesson...'
lesson = Lesson.create!(
  classroom: classroom,
  title: "Oral Communication"
)
puts "The #{lesson.title} seed lesson has been created!"

# 1st Seed Question
puts 'Creating lesson quiz questions...'
question_1 = Question.create!(
  lesson: lesson,
  description: 'What does the CEFR exam evaluate?' # Will need to change this data type
)
puts "The #{lesson.title} homework questions have been created!"

# 1st Seed Choices
puts 'Creating lesson quiz choices...'
Choice.create!(
  question: question_1,
  description: 'It is good for your reading practice.', # Will need to change this data type
  correct: false
)
Choice.create!(
  question: question_1,
  description: 'It is valuable in Japanese universities.', # Will need to change this data type
  correct: false
)
Choice.create!(
  question: question_1,
  description: 'It evaluates your conversation skill.', # Will need to change this data type
  correct: true
)
Choice.create!(
  question: question_1,
  description: 'It can help you with your listening.', # Will need to change this data type
  correct: false
)

# 2nd Seed Question
question_2 = Question.create!(
  lesson: lesson,
  description: 'Who\'s the GOAT of the NBA?' # Will need to change this data type
)

# 2nd Seed Choices
puts 'Creating lesson quiz choices...'
Choice.create!(
  question: question_2,
  description: 'Kobe Bryant', # Will need to change this data type
  correct: false
)
Choice.create!(
  question: question_2,
  description: 'Michael Jordan', # Will need to change this data type
  correct: true
)
Choice.create!(
  question: question_2,
  description: 'Lebron James', # Will need to change this data type
  correct: false
)
Choice.create!(
  question: question_2,
  description: 'Wilt Chamberlain', # Will need to change this data type
  correct: false
)
puts 'All choices are done!'
