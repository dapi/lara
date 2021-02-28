class Wallet < ApplicationRecord
  STAR = '⭐️'
  belongs_to :student

  def humanized
    if stars.zero?
      'Нет звёзд'
    else
      stars.to_s + STAR
    end
  end
end
