require "test_helper"

class BlogPostTest < ActiveSupport::TestCase
  test "draft? returns correct answer" do
    assert blog_posts(:draft).draft?
    refute blog_posts(:scheduled).draft?
    refute blog_posts(:published).draft?
  end

  test "published? returns correct answer" do
    refute blog_posts(:draft).published?
    refute blog_posts(:scheduled).published?
    assert blog_posts(:published).published?
  end

  test "scheduled? returns correct answer" do
    refute blog_posts(:draft).scheduled?
    assert blog_posts(:scheduled).scheduled?
    refute blog_posts(:published).scheduled?
  end
end
