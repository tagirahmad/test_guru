# frozen_string_literal: true

class BadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
  end

  def earn_badge
    Badge.all.each do |badge|
      @user.badges << badge if send(badge.rule, badge.parameter)
    end
  end

  private

  def all_tests_of_category(category_title)
    return false if @test_passage.test.category.title != category_title

    tests = Test.sorted_title_for_category(category_title).pluck(:id)
    completed = uniq_completed_test_ids(tests)

    tests.count == completed.count
  end

  def first_attempt(_args)
    passages_count = TestPassage.where(user: @test_passage.user, test: @test_passage.test, passed: true).count
    passages_count == 1
  end

  def all_tests_of_level(level)
    return false if level.to_i != @test_passage.test.level

    tests = Test.where(level: level).pluck(:id)
    completed = uniq_completed_test_ids(tests)

    tests.count == completed.count
  end

  def uniq_completed_test_ids(tests)
    @user
      .test_passages
      .where(passed: true, test: tests)
      .pluck(:test_id)
      .uniq
  end
end
