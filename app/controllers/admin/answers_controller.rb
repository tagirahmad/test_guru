# frozen_string_literal: true

class Admin::AnswersController < ApplicationController
  before_action :find_question, only: %i[new create]
  before_action :set_answer, only: %i[show edit update destroy]

  # GET /answers/1 or /answers/1.json
  def show; end

  # GET /answers/new
  def new
    @answer = @question.answers.new
  end

  # GET /answers/1/edit
  def edit; end

  # POST /answers or /answers.json
  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to @answer
    else
      render 'new'
    end
  end

  # PATCH/PUT /answers/1 or /answers/1.json
  def update
    if @answer.update(answer_params)
      redirect_to admin_answer_path
    else
      render 'edit'
    end
  end

  # DELETE /answers/1 or /answers/1.json
  def destroy
    @answer.destroy
    redirect_to @answer.question
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def answer_params
    params.require(:answer).permit(:body, :correct)
  end
end
