require "application_system_test_case"

class AppActionsTest < ApplicationSystemTestCase
  setup do
    @app_action = app_actions(:one)
  end

  test "visiting the index" do
    visit app_actions_url
    assert_selector "h1", text: "App actions"
  end

  test "should create app action" do
    visit app_actions_url
    click_on "New app action"

    fill_in "Name", with: @app_action.name
    click_on "Create App action"

    assert_text "App action was successfully created"
    click_on "Back"
  end

  test "should update App action" do
    visit app_action_url(@app_action)
    click_on "Edit this app action", match: :first

    fill_in "Name", with: @app_action.name
    click_on "Update App action"

    assert_text "App action was successfully updated"
    click_on "Back"
  end

  test "should destroy App action" do
    visit app_action_url(@app_action)
    click_on "Destroy this app action", match: :first

    assert_text "App action was successfully destroyed"
  end
end
