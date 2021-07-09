class Test < ApplicationRecord
  belongs_to :category

  def self.sorted_title_for_category(category_title)
    joins(:category).where(categories: {title: category_title}).order(title: :desc).pluck(:title)
  end

end
