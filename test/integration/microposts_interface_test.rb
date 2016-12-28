require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:brant)
  end

  test "microposts interface" do
    log_in_as(@user)
    get root_path
    assert_select 'ul.pagination', count: 1
    assert_select 'input[type=file]'
    # Invalid mp submission
    assert_no_difference "Micropost.count" do
      post microposts_path, params: { micropost: { content: "" } }
    end
    assert_select 'div#error_explanation'
    # Valid mp submission
    content = "This is some test content for the post"
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference "Micropost.count", 1 do
      post microposts_path, params: { micropost: { content: content, picture: picture } }
    end
    assert Micropost.first.picture?
    follow_redirect!
    assert_match content, response.body
    assert_select 'span.content'
    # Delete mp
    assert_select 'a', text: 'Delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference "Micropost.count", -1 do
      delete micropost_path(first_micropost)
    end
    assert_redirected_to root_path
    # Visit different user - no delete links
    get user_path(users(:dan))
    assert_select 'a', text: 'Delete', count: 0
  end

  test "micropost sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.microposts.count} microposts", response.body
    user_2 = users(:doubleA)
    log_in_as(user_2)
    get root_path
    assert_match "0 microposts", response.body
    user_2.microposts.create!(content: "new micropost")
    get root_path
    assert_match "1 micropost", response.body
  end
end
