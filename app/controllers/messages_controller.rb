class MessagesController < ApplicationController
  def index
    messages = Message.order('created_at desc')
    render locals: { messages: messages }
  end

  def new
  end

  def create
  end
end

