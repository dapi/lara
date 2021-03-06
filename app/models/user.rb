class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :memberships
  has_many :parents_relationships, foreign_key: :children_id, class_name: 'Relationship', counter_cache: true
  has_many :children_relationships, foreign_key: :parent_id, class_name: 'Relationship', counter_cache: true
  has_many :children, through: :children_relationships
  # Дети как студенты
  has_many :children_students, through: :children, source: :students, class_name: 'Student'

  has_many :parents, through: :parents_relationships, inverse_of: :children
  has_many :invites, inverse_of: :inviter, foreign_key: :inviter_id, dependent: :destroy
  has_many :messages, dependent: :delete_all

  has_many :wallet_transfers, foreign_key: :payer_id, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :student_wallets, through: :students, source: :wallet

  before_validation do
    self.phone = Phonelib.parse(phone).to_s if phone.present?
  end

  validates :firstname, presence: true
  validates :phone, phone: { allow_blank: true }, uniqueness: { allow_blank: true }
  validates :telegram_id, uniqueness: true

  def public_name
    name
  end

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
