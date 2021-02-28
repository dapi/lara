class Wallet < ApplicationRecord
  STAR = '⭐️'
  belongs_to :student

  def humanized
    if stars.zero?
      'Нет звёзд'
    else
      STAR + stars.to_s
    end
  end
end
