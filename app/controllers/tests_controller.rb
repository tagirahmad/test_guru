# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :set_test, only: %i[show start]
  before_action :set_user, only: :start

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all
  end

  def show; end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)

    if @test.save!
      redirect_to tests_path
    else
      render 'new'
    end
  end

  def start
    @user.tests.push << @test

    redirect_to @user.test_passage(@test)
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def set_user
    @user = User.find(session[:user_id])
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :author_id)
  end

  def rescue_with_test_not_found
    byebug
    render plain: "Can't find this test"
  end
end
