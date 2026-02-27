require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "is invalid without content" do
    comment = Comment.new(content: nil)
    assert_not comment.valid?
    assert_includes comment.errors[:content], "can't be blank"
  end
end

