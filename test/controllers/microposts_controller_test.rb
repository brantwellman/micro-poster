require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @micropost = microposts(:fruit)
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Micropost.count" do
      post microposts_path, params: { micropost: { content: "This is content" } }
    end
    assert_redirected_to login_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Micropost.count" do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_path
  end

  test "should not delete mps and redirect when not proper user" do
    log_in_as(users(:brant))
    micropost = microposts(:ants)
    assert_no_difference "Micropost.count" do
      delete micropost_path(micropost)
    end
    assert_redirected_to root_path
  end
end
