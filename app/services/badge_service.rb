# frozen_string_literal: true

class BadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
  end

  def earn_badge
    Badge.all.each do |badge|
      give_badge_to_user(badge) if send(badge.rule, badge.parameter)
    end
  end

  private

  def give_badge_to_user(badge)
    @user_badge = UserBadge.new(
      user_id: @user.id,
      badge_id: badge.id
    )

    errors.add(:badges, :error) unless @user_badge.save
  end

  def all_tests_of_category(category_title)
    return false if @test_passage.test.category.title != category_title

    tests = Test.where(category: Category.find_by(title: category_title)).pluck(:id)
    completed = @test_passage
                .user
                .test_passages
                .where(test: tests)
                .pluck(:test_id)
                .uniq

    @test_passage.passed? && tests.count == completed.count
  end

  def first_attempt(_args)
    TestPassage.where(user: @test_passage.user, test: @test_passage.test).count == 1
  end

  def all_tests_of_level(level)
    return false if level.to_i != @test_passage.test.level

    tests = Test.where(level: level).pluck(:id)

    completed = @test_passage
                .user
                .test_passages
                .where(passed: true, test: tests)
                .pluck(:test_id)
                .uniq

    tests.count == completed.count
  end
end
