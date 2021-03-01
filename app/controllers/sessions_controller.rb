class SessionsController < ApplicationController
  def destroy
    logout
    redirect_back fallback_location: root_path, notice: 'До свидания!'
  end
end
