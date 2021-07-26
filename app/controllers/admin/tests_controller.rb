# frozen_string_literal: true

class Admin::TestsController < Admin::BaseController
  before_action :set_test, only: %i[show start destroy edit update]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all
  end

  def show; end

  def new
    @test = Test.new
  end

  def create
    @test = current_user.created_tests.new(test_params)

    if @test.save
      redirect_to admin_tests_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @test.update(test_params)
      redirect_to admin_tests_path, notification: 'Test edited!'
    else
      render :edit
    end
  end

  def start
    current_user.tests.push << @test

    redirect_to current_user.test_passage(@test)
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :author_id)
  end

  def rescue_with_test_not_found
    render plain: "Can't find this test"
  end
end
