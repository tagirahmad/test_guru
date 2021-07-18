# frozen_string_literal: true

module TestPassagesHelper
  def passage_congratulation
    if @test_passage.passed?
      content_tag(:p, 'Success!!!')
    else
      content_tag(:p, 'Test is not passed...')
    end
  end
end
