# frozen_string_literal: true

class Admin
  class QuestionsController < ApplicationController
    before_action :find_test, only: %i[index new create]
    before_action :find_question, only: %i[show destroy edit update]

    rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

    def index
      @questions = @test.questions
    end

    def show; end

    def new
      @question = @test.questions.new
    end

    def create
      @question = @test.questions.new(question_params)

      if @question.save
        redirect_to test_questions_path
      else
        render 'new'
      end
    end

    def edit; end

    def update
      if @question.update(question_params)
        redirect_to admin_question_path
      else
        render 'edit'
      end
    end

    def destroy
      @question.destroy
      render plain: t('.deleted')
    end

    private

    def find_test
      @test = Test.find(params[:test_id])
    end

    def find_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:body)
    end

    def rescue_with_question_not_found
      render plain: t('errors.cant_find_question')
    end
  end
end
