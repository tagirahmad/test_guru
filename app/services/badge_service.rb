# frozen_string_literal: true

class BadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
  end

  def earn_badge
    first_attempt_badge = Badge::TYPES.find_index(:first_attempt)
    all_tests_from_category_badge = Badge::TYPES.find_index(:all_tests_from_category)
    all_tests_of_level_badge = Badge::TYPES.find_index(:all_tests_of_level)

    add_badge(first_attempt_badge) if first_attempt?
    add_badge(all_tests_from_category_badge) if passing_all_tests_from_category?(@test_passage.test.category)
    add_badge(all_tests_of_level_badge) if passing_all_tests_of_level?(@test_passage.test.level)
  end

  def first_attempt?
    TestPassage.where(user: @test_passage.user, test: @test_passage.test).count == 1
  end

  def passing_all_tests_from_category?(category)
    tests = Test.where(category: category).pluck(:id)
    completed = @test_passage
                .user
                .test_passages
                .where(test: tests)
                .pluck(:test_id)
                .uniq
    tests.count == completed.count
  end

  def passing_all_tests_of_level?(level)
    tests = Test.where(level: level).pluck(:id)
    completed = @test_passage
                .user
                .test_passages
                .where(test: tests)
                .pluck(:test_id)
                .uniq
    tests.count == completed.count
  end

  private

  def add_badge(achievement_type)
    badge = Badge.find_by(test: @test_passage.test, achievement_type: achievement_type)
    @user.badges << badge if badge.present?
  end
end
