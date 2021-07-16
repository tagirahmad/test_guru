module QuestionsHelper
  def question_header(test_title, type)
    case type
    when :create then "Create #{test_title} Question"
    when :edit then "Edit #{test_title} Question"
    else
      "#{test_title} Question"
    end
  end
end
