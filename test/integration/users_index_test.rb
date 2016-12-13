require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:brant)
    @non_admin = users(:dan)
  end

  test "index as admin" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'ul.pagination', count: 2
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      if user == !@admin
        assert_select 'a[href=?]', user_path(user), text: 'Delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test "index does not display inactive users" do
    User.create(name: "Inactive User", email: "inactive@email.com",
                password: "password", activated: false)
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'a', text: "Inactive User", count: 0
  end
end
