class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :tests_users
  has_many :users, through: :tests_users
  has_many :questions

  def self.sorted_title_for_category(category_title)
    joins(:category).where(categories: {title: category_title}).order(title: :desc).pluck(:title)
  end

end
