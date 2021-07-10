class Test < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :users

  def self.sorted_title_for_category(category_title)
    joins(:category).where(categories: {title: category_title}).order(title: :desc).pluck(:title)
  end

end
