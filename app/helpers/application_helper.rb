module ApplicationHelper
  def telegram_link(username)
    link_to '@' + username, 'https://t.me/' + username, target: '_blank'
  end
end
