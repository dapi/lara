# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
room = StudyRoom.find_or_create_by(title: '5-й класс')

[
  ['Письменная Агата', '+79051985596'],
  ['Письменный Данил Викторович', '+79033891228'],
  ['Письменная Татьяна Николаевна', '+79613429022'],
  ['Кочнева Наталия Валерьевна', '+79196561039'],
].each do |user_info|
  User
    .create_with(full_name: user_info.first)
    .find_or_create_by(phone: user_info.second)
end
