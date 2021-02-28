module ActionStart
  def start!(message = '', *args)
    if logged_in?
      respond_with :message,
        text: "#{current_user.firstname}, привет!"
    elsif message.gsub!(/^i_/,'')
      invite = Invite.find_by(key: message)
      if invite.present?
        accept_invite invite
      else
        respond_with :message,
          text: 'Похоже у Вас устаревшая ссылка, обратитесь к тому кто вам её выдал чтобы дали новую!'
      end
    else
      raise Unauthenticated
    end
  end

end
