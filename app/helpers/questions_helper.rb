# frozen_string_literal: true

module QuestionsHelper
  def question_header(question)
    "#{question.new_record? ? t('admin.questions.new.create') : t('admin.questions.new.edit')} #{question.test.title} #{t('admin.questions.new.question')}" # rubocop:disable Layout/LineLength
  end
end
