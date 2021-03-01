class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    render :not_authenticated, status: 402
  end
end
