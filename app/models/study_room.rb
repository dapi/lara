class StudyRoom < ApplicationRecord
  belongs_to :classroom_teacher, class_name: 'User', optional: true

  has_many :students
  has_many :student_users, through: :students, source: :user
  has_many :teachers
  has_many :teacher_users, through: :teachers, source: :user

  has_many :invites
  has_many :parents, through: :student_users

  validates :title, presence: true

  def get_role(user)
    return :student if student_users.include?(user)
    return :teacher if teacher_users.include?(user)
    return :parents if parents.include?(user)
    return :classroom_teacher if classroom_teacher.present? && classroom_teacher == user

    :unknown
  end
end
