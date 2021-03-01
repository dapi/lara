class WelcomeController < ApplicationController
  def index
    flash.notice ='Привет'
  end
end
