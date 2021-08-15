# frozen_string_literal: true

class Badge < ApplicationRecord
  TYPES = %i[all_tests_from_category first_attempt all_tests_of_level].freeze

  enum achievement_type: TYPES

  belongs_to :category
  belongs_to :test

  has_many :badge_users
  has_many :users, through: :badge_users
end
