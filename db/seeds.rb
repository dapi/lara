# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
study_room = StudyRoom
  .find_or_create_by!(title: '5-й класс')

inviter = User
  .create_with(full_name: 'super master')
  .find_or_create_by!(telegram_id: 1)

[
  ['Письменная Агата', :student],
  ['Письменный Данил Викторович', :parents],
  ['Письменная Татьяна Николаевна', :parents],
  ['Кочнева Наталия Валерьевна', :teacher]
].each do |info|
  Invite
    .create_with(role: info.second)
    .find_or_create_by!(full_name: info.first, inviter: inviter, study_room: study_room)
end
