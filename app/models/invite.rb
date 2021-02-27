class Invite < ApplicationRecord
  belongs_to :inviter, class_name: 'User'
  belongs_to :study_room

  enum role: [:student, :teacher, :parents]

  before_create do
    self.key = SecureRandom.alphanumeric(10)
  end

  def telegram_attach_url
    Settings.bot_link + '?start=i_' + key
  end
end
