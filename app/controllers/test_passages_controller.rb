# frozen_string_literal: true

class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]

  def show
    redirect_if_time_expired

    return unless @test_passage.test.questions.empty?

    flash[:alert] = t('.no_questions')
    redirect_to tests_path
  end

  def result; end

  def update # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    if params[:answer_ids].nil?
      flash.now[:alert] = t('.please_answer')
      render 'show'
      return
    end

    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      redirect_if_time_expired
      send_mail(@test_passage)

      if @test_passage.passed?
        @test_passage.update(passed: true)
        earn_badge
      end

      redirect_to result_test_passage_path(@test_passage)
    else
      render 'show'
    end
  end

  def gist # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
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

  def send_mail(test_passage)
    TestsMailer.completed_test(test_passage).deliver_now
  end

  def earn_badge
    BadgeService.new(@test_passage).earn_badge
  end

  def redirect_if_time_expired
    return unless @test_passage.remaining_time <= 0

    redirect_to(result_test_passage_path(@test_passage), alert: 'Time is over')
  end
end
