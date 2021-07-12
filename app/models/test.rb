class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :tests_users
  has_many :users, through: :tests_users
  has_many :questions

  validates :title, presence: true, uniqueness: { scope: [:level] }
  validates :level, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }, allow_nil: false

  scope :simple, -> { where(level: 0..1) }
  scope :medium, -> { where(level: 2..4) }
  scope :difficult, -> { where(level: 5..Float::INFINITY) }

  scope :sorted_title_for_category, -> { joins(:category).where(categories: {title: category_title}).order(title: :desc).pluck(:title) }
end
