class GistQuestionService
  def initialize(question, client = nil)
    @question = question
    @test = @question.test
    @client = client || GithubClient.new
  end

  def call
    @result = @client.create_gist(gist_params)
  end

  def gist_link
    @result[:html_url]
  end

  def success?
    @client.last_response.status == 201
  end

  private

  def gist_params
    {
      description: I18n.t('services.gist_question_service.description', test_title: @test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end