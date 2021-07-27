# frozen_string_literal: true

module TestsHelper
  LEVELS = { 0 => :simple, 1 => :simple, 2 => :medium, 4 => :medium, 5 => :difficult }.freeze

  def test_level(test)
    LEVELS[test.level] || :difficult
  end

  def go_back_to_tests
    link_to 'Back', tests_path
  end
end
