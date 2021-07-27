# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_tests, class_name: 'Test', foreign_key: :author_id
  has_many :test_passages
  has_many :tests, through: :test_passages

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :last_name, presence: true
  validates :first_name, presence: true

  def admin?
    is_a?(Admin)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def tests_by_level(level)
    Test.joins(:users).where(level: level, users: { id: id })
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
