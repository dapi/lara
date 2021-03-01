require "test_helper"

class InvitesControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get invites_destroy_url
    assert_response :success
  end
end
