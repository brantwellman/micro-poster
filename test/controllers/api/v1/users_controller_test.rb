require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase

  def setup
    @user1 = users(:brant)
    @user2 = users(:dan)
  end

  test "show action responds with json and returns user" do
    get :show, params: { id: @user1.id }, format: :json

    parsed_user = JSON.parse(response.body)

    assert_response 200
    assert_equal @user1.name, parsed_user["name"]
    assert_equal @user1.email, parsed_user["email"]
  end

  test "index action responds with json and returns all users" do
    get :index, format: :json

    parsed_users = JSON.parse(response.body)
    parsed1 = parsed_users.first
    parsed2 = parsed_users[1]

    assert_response 200
    assert_equal 34, parsed_users.count
  end

  test "user api exposes only id, email, name attributes" do
    get :show, params: { id: @user1.id }, format: :json

    parsed_user = JSON.parse(response.body)

    assert_equal @user1.name, parsed_user["name"]
    assert_equal @user1.email, parsed_user["email"]
    assert_equal @user1.id, parsed_user["id"]
    refute parsed_user["admin"]
    assert_equal 3, parsed_user.count
  end
end
