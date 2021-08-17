# frozen_string_literal: true

class Badge < ApplicationRecord
  RULES = %i[all_tests_of_category first_attempt all_tests_of_level].freeze

  has_many :user_badges
  has_many :user, through: :user_badges
  has_many :test, through: :user_badges

  validates :name, presence: true
  validates :rule, presence: true
  validates :parameter, presence: true
  validates :image, presence: true
end
