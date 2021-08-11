# frozen_string_literal: true

class FeedbacksController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def create
    message = params[:message]

    if message.strip.empty?
      flash.now[:alert] = t('.failure')
      render :index
    else
      FeedbackMailer.send_feedback(current_user, message).deliver_now
      flash[:notice] = t('.success')
      redirect_to root_path
    end
  end
end
