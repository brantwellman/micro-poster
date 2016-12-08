require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:brant)
  end

  test "layout links as user not logged in" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
    get help_path
    assert_select "title", full_title("Help")
    get login_path
    assert_select "title", full_title("Log In")
    get users_path
    assert_redirected_to login_path
    get user_path(@user)
    assert_select "title", full_title("Brant")
    get edit_user_path(@user)
    assert_redirected_to login_path
  end

  test "layout links as logged in user" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
    get help_path
    assert_select "title", full_title("Help")
    get login_path
    assert_select "title", full_title("Log In")
    get users_path
    assert_select "title", full_title("All users")
    get user_path(@user)
    assert_select "title", full_title("Brant")
    get edit_user_path(@user)
    assert_select "title", full_title("Edit user")
  end
end
