# frozen_string_literal: true

class Admin
  class BaseController < ApplicationController
    layout 'admin'

    before_action :authenticate_user!
    before_action :admin_required!

    private

    def admin_required!
      redirect_to(root_path, alert: 'You are not authorized to do this') unless current_user.admin?
    end
  end
end
