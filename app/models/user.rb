class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :memberships
  has_many :study_rooms, through: :memberships
  has_many :parents_relationships, foreign_key: :children_id, class_name: 'Relationship', counter_cache: true
  has_many :children_relationships, foreign_key: :parent_id, class_name: 'Relationship', counter_cache: true
  has_many :children, through: :children_relationships
  has_many :parents, through: :parents_relationships, inverse_of: :children
  has_many :invites
  has_many :messages

  before_validation do
    self.phone = Phonelib.parse(phone).to_s if phone.present?
  end

  validates :firstname, presence: true
  validates :surname, presence: true
  validates :phone, phone: { allow_blank: true }, uniqueness: { allow_blank: true }
  validates :telegram_id, uniqueness: true

  def name
    [firstname, middlename].compact.join(' ')
  end

  # ФИО
  def full_name
    [surname, firstname, middlename].compact.join(' ')
  end

  # ФИО
  def full_name=(value)
    self.surname, self.firstname, self.middlename = value.chomp.squish.split(/\s/)
  end
end
