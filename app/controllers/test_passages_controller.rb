# frozen_string_literal: true

class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]

  def show; end

  def result; end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render 'show'
    end
  end

  def gist
    client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
    current_question = @test_passage.current_question

    gist_question_service = GistQuestionService.new(current_question, client)
    gist_question_service.call

    if gist_question_service.success?
      Gist.create!(url: gist_question_service.gist_link, user_id: current_user.id, question_id: current_question.id)
    end

    flash_options = if gist_question_service.success?
                      { notice: "#{t('.success')} #{view_context.link_to('Gist link',
                                                                         gist_question_service.gist_link,
                                                                         target: '_blank')}" }
                    else
                      { alert: t('.failure') }
                    end

    redirect_to @test_passage, flash_options
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
