class SessionsController < Devise::SessionsController
  def create
    byebug
    super
    # set_flash_message! :notice, :signed_in
    flash[:notice] = "Hello, #{current_user.full_name}"
  end
end