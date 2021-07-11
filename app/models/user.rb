class User < ApplicationRecord
  has_and_belongs_to_many :tests
  
  def tests_by_level(level)
    Test.joins(:users).where(level: level, users: { id: self.id })
  end
end
