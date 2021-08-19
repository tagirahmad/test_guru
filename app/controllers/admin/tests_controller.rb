# frozen_string_literal: true

class Admin
  class TestsController < Admin::BaseController
    before_action :set_tests, only: %i[index update_inline]
    before_action :set_test, only: %i[show destroy edit update update_inline]

    rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

    def index; end

    def show; end

    def new
      @test = Test.new
    end

    def create
      @test = current_user.created_tests.new(test_params)

      if @test.save
        redirect_to admin_tests_path, flash: { notification: t('.success') }
      else
        render 'new'
      end
    end

    def edit; end

    def update
      if @test.update(test_params)
        redirect_to admin_tests_path, flash: { notification: t('.edited') }
      else
        render :edit
      end
    end

    def update_inline
      if @test.update(test_params)
        redirect_to admin_tests_path
      else
        render :index
      end
    end

    def destroy
      @test.destroy
      redirect_to admin_tests_path
    end

    private

    def set_test
      @test = Test.find(params[:id])
    end

    def set_tests
      @tests = Test.all
    end

    def test_params
      params.require(:test).permit(:title, :level, :category_id, :time)
    end

    def rescue_with_test_not_found
      render plain: t('errors.cant_find_test')
    end
  end
end
