require "test_helper"

class RelationsControllerTest < ActionDispatch::IntegrationTest
  test "should get follow" do
    get relations_follow_url
    assert_response :success
  end

  test "should get unfollow" do
    get relations_unfollow_url
    assert_response :success
  end
end
