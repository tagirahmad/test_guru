# frozen_string_literal: true

class BadgesController < ApplicationController
  before_action :authenticate_user!

  def index
    @badges = Badge.all
  end

  def my_badges
    @badges = current_user.badges
  end
end
