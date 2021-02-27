class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :memberships
  has_many :study_rooms, through: :memberships

  before_validation do
    self.phone = Phonelib.parse(phone).to_s
  end

  validates :name, presence: true
  validates :surname, presence: true
  validates :phone, presence: true, phone: true

  # ФИО
  def full_name
    [surname, firstname, middlename].compact.join(' ')
  end

  # ФИО
  def full_name=(value)
    self.surname, self.firstname, self.middlename = value.chomp.squish.split(/\s/)
  end
end
