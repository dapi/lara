class InvitesController < ApplicationController
  def destroy
    invite = Invite.find params[:id]
    invite.destroy!

    redirect_back fallback_location: root_path, notice: 'Инвайт удалён!'
  end
end
