class UsersController < ApplicationController
  def show
    user = User.find params[:id]
    render locals: { user: user }
  end

  private

  def permitted_params
    params.require(:user).permit(:reply_to_message_id, :text, :chat_id)
  end
end
