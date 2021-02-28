module StarsHelper
  def humanized_stars(stars)
    if stars.zero?
      'Нет звёзд'
    else
      stars.to_s + Wallet::STAR
    end
  end
end
