class User < ApplicationRecord
  has_and_belongs_to_many :tests
  
  def tests_by_level(level)
    Test.where(level: level, user_id: self.id)
  end
end
