# frozen_string_literal: true

class Badge < ApplicationRecord
  enum achievement_type: BadgeAchievement::TYPES

  belongs_to :category
  belongs_to :test

  has_many :badge_users
  has_many :users, through: :badge_users
end
