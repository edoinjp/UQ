# Required Gems
require 'faker'

# Clear previous records
puts 'Destroying all previous records'
Participation.destroy_all
puts 'All participations are destroyed'
Classroom.destroy_all
puts 'All classrooms are destroyed'
User.destroy_all
puts 'All users are destroyed'
Lesson.destroy_all
puts 'All lessons are destroyed'
Question.destroy_all
puts 'All questions are destroyed'
Choice.destroy_all
puts 'All choices are destroyed'

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
  user: teacher
)
puts "Mr. DuPaty's classroom has been created!"

# Seed Lesson
puts 'Creating a lesson...'
lesson = Lesson.create!(
  classroom: classroom,
  title: 'Oral Communication'
)
puts "The #{lesson.title} seed lesson has been created!"

# Seed Styled Lesson [Visual]
puts 'Creating visual lesson...'
visual_lesson = StyledLesson.create!(
  lesson: lesson,
  style: 'visual',
  content: ''
)

# Attaching the 8 lesson images to the visual_lesson
file1 = File.open(Rails.root.join('db/files/visual_lesson/lessonimg_1.jpg'))
visual_lesson.files.attach(io: file1, filename: 'visual_1.jpg')

file2 = File.open(Rails.root.join('db/files/visual_lesson/lessonimg_2.jpg'))
visual_lesson.files.attach(io: file2, filename: 'visual_2.jpg')

file3 = File.open(Rails.root.join('db/files/visual_lesson/lessonimg_3.jpg'))
visual_lesson.files.attach(io: file3, filename: 'visual_3.jpg')

file4 = File.open(Rails.root.join('db/files/visual_lesson/lessonimg_4.jpg'))
visual_lesson.files.attach(io: file4, filename: 'visual_4.jpg')

file5 = File.open(Rails.root.join('db/files/visual_lesson/lessonimg_5.jpg'))
visual_lesson.files.attach(io: file5, filename: 'visual_5.jpg')

file6 = File.open(Rails.root.join('db/files/visual_lesson/lessonimg_6.jpg'))
visual_lesson.files.attach(io: file6, filename: 'visual_6.jpg')

file7 = File.open(Rails.root.join('db/files/visual_lesson/lessonimg_7.jpg'))
visual_lesson.files.attach(io: file7, filename: 'visual_7.jpg')

file8 = File.open(Rails.root.join('db/files/visual_lesson/lessonimg_8.jpg'))
visual_lesson.files.attach(io: file8, filename: 'visual_8.jpg')

puts 'Visual lesson has been created!'

# Seed Styled Lesson [Aural]
puts 'Creating aural lesson...'
aural_lesson = StyledLesson.create!(
  lesson: lesson,
  style: 'aural',
  content: ''
)

# Attaching audio file to aural_lesson
file9 = File.open(Rails.root.join('db/files/aural_lesson.mp3'))
aural_lesson.files.attach(io: file9, filename: 'aural.mp3')

puts 'Aural lesson has been created!'

# Seed Styled Lesson [Reading]
puts 'Creating reading lesson...'
reading_lesson = StyledLesson.create!(
  lesson: lesson,
  style: 'reading',
  content: ''
)

# Attaching an open file to reading_lesson
file10 = File.open(Rails.root.join('db/files/reading_lesson.docx'))
reading_lesson.files.attach(io: file10, filename: 'reading.docx')

puts 'Reading lesson has been created!'

# Seed Styled Lesson [Kinesthetic]
puts 'Creating kinesthetic lesson...'
kinesthetic_lesson = StyledLesson.create!(
  lesson: lesson,
  style: 'kinesthetic',
  content: ''
)

# Attaching a video file to kinesthetic_lesson
file11 = File.open(Rails.root.join('db/files/kinesthetic_lesson.mp4'))
kinesthetic_lesson.files.attach(io: file11, filename: 'kinesthetic.mp4')

puts 'Kinesthetic lesson has been created!'

# 1st Seed Question
puts 'Creating lesson quiz questions...'
question1 = Question.create!(
  lesson: lesson,
  description: 'What does the CEFR exam evaluate?' # Will need to change this data type
)
puts "The #{lesson.title} homework questions have been created!"

# 1st Seed Choices
puts 'Creating lesson quiz choices...'
Choice.create!(
  question: question1,
  description: 'It is good for your reading practice.', # Will need to change this data type
  correct: false
)
Choice.create!(
  question: question1,
  description: 'It is valuable in Japanese universities.', # Will need to change this data type
  correct: false
)
Choice.create!(
  question: question1,
  description: 'It evaluates your conversation skill.', # Will need to change this data type
  correct: true
)
Choice.create!(
  question: question1,
  description: 'It can help you with your listening.', # Will need to change this data type
  correct: false
)

# 2nd Seed Question
question2 = Question.create!(
  lesson: lesson,
  description: 'Who\'s the GOAT of the NBA?' # Will need to change this data type
)

# 2nd Seed Choices
puts 'Creating lesson quiz choices...'
Choice.create!(
  question: question2,
  description: 'Kobe Bryant', # Will need to change this data type
  correct: false
)
Choice.create!(
  question: question2,
  description: 'Michael Jordan', # Will need to change this data type
  correct: true
)
Choice.create!(
  question: question2,
  description: 'Lebron James', # Will need to change this data type
  correct: false
)
Choice.create!(
  question: question2,
  description: 'Wilt Chamberlain', # Will need to change this data type
  correct: false
)
puts 'All choices are done!'
