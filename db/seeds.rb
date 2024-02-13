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

  )
end
