# frozen_string_literal: true

class Admin
  class BadgesController < Admin::BaseController
    before_action :set_badge, only: %i[show destroy edit update]

    rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

    def index
      @badges = Badge.all
    end

    def show; end

    def new
      @badge = Badge.new
    end

    def create
      @badge = Badge.new(badge_params)

      if @badge.save
        redirect_to admin_badges_path, flash: { notification: t('.success') }
      else
        render 'new'
      end
    end

    def edit; end

    def update
      if @badge.update(badge_params)
        redirect_to admin_badges_path, flash: { notification: t('.edited') }
      else
        render :edit
      end
    end

    def destroy
      @badge.destroy
      redirect_to admin_badges_path
    end

    private

    def badge_params
      params.require(:badge).permit(:name, :image, :category_id, :test_id)
    end

    def set_badge
      @badge = Badge.find(params[:id])
    end

    def rescue_with_test_not_found
      render plain: t('errors.cant_find_badge')
    end
  end
end
