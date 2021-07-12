class User < ApplicationRecord
  has_many :tests_users
  has_many :tests, through: :tests_users
  has_many :created_tests, class_name: 'Test', foreign_key: :author_id

  validates :name, presence: true

  scope :tests_by_level, -> (level) { Test.joins(:users).where(level: level, users: { id: self.id }) }
end
