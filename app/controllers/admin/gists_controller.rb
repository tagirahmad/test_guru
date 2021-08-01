# frozen_string_literal: true

class Admin
  class GistsController < ApplicationController
    before_action :authenticate_user!

    def index
      @gists = Gist.all
    end

    def show
      @gist = Gist.find(params[:id])
    end
  end
end
