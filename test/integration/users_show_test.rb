require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:brant)
    @non_admin = users(:dan)
  end

  test "inactive user show page redirect" do
    user = User.create(name: "Inactive User", email: "inactive@email.com",
                       password: "password", activated: false)
    log_in_as(@admin)
    get user_path(user)
    follow_redirect!
    assert_template 'static_pages/home'
  end
end
