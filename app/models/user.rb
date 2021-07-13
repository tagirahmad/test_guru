# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tests_users
  has_many :tests, through: :tests_users
  has_many :created_tests, class_name: 'Test', foreign_key: :author_id

  validates :name, presence: true

  def tests_by_level(level)
    Test.joins(:users).where(level: level, users: { id: id })
  end
end
