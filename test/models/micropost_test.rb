require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:brant)
    @micropost = Micropost.new(content: "Testy content", user_id: @user.id)
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    refute @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = "   "
    refute @micropost.valid?
  end

  test "contents should have maximum of 140 chars" do
    @micropost.content = "a" * 141
    refute @micropost.valid?
  end
end
