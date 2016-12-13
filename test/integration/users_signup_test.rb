require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path params: { user: { name: "",
                                         email: "user@invalid",
                                         password: "foo",
                                         password_confirmation: "bar"} }
    end
    assert_template 'users/new'
    assert_select 'div.alert'
    assert_select 'form[action="/users"]'
  end

  test "valid signup information with account activation" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path params: { user: { name: "testor",
                                         email: "testor@email.com",
                                         password: "password",
                                         password_confirmation: "password"} }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    refute user.activated?
    log_in_as(user)
    refute is_logged_in?
    get edit_account_activate_path("invalid token", email: user.email)
    refute is_logged_in?
    get edit_account_activate_path(user.activation_token, email: "wrong email")
    refute is_logged_in?
    get edit_account_activate_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
