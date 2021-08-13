# frozen_string_literal: true

class Badge < ApplicationRecord
  enum achievement_type: %i[all_tests first_attempt all_tests_of_level]

  belongs_to :category
  belongs_to :test
end
