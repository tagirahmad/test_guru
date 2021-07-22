class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies[:current_url] || root_path, flash: { notification: 'You are successfully logged in' }
    else
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    cookies[:current_url] = nil
    redirect_to login_path, flash: { notification: 'You are signed out' }
  end
end
