module ApplicationHelper
  def telegram_link(info)
    username = info['username'] || info['id'].to_s
    link_to '@' + username, 'https://t.me/' + username, target: '_blank'
  end
end
