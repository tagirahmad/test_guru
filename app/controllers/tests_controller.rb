class TestsController < ApplicationController
  before_action :find_test, only: :show

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all

    render json: @tests
  end

  def show
    render json: @test
  end

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

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :author_id)
  end

  def rescue_with_test_not_found
    render plain: "Can't find this test"
  end
end
