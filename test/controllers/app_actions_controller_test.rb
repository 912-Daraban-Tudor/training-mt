require "test_helper"

class AppActionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @app_action = app_actions(:one)
  end

  test "should get index" do
    get app_actions_url
    assert_response :success
  end

  test "should get new" do
    get new_app_action_url
    assert_response :success
  end

  test "should create app_action" do
    assert_difference("AppAction.count") do
      post app_actions_url, params: { app_action: { name: @app_action.name } }
    end

    assert_redirected_to app_action_url(AppAction.last)
  end

  test "should show app_action" do
    get app_action_url(@app_action)
    assert_response :success
  end

  test "should get edit" do
    get edit_app_action_url(@app_action)
    assert_response :success
  end

  test "should update app_action" do
    patch app_action_url(@app_action), params: { app_action: { name: @app_action.name } }
    assert_redirected_to app_action_url(@app_action)
  end

  test "should destroy app_action" do
    assert_difference("AppAction.count", -1) do
      delete app_action_url(@app_action)
    end

    assert_redirected_to app_actions_url
  end
end
