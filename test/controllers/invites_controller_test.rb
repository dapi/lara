require "test_helper"

class InvitesControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    delete invite_path(invites(:one))
    assert_response :redirect
  end
end
