require "application_system_test_case"

class MultitudesTest < ApplicationSystemTestCase
  setup do
    @multitude = multitudes(:one)
  end

  test "visiting the index" do
    visit multitudes_url
    assert_selector "h1", text: "Multitudes"
  end

  test "should create multitude" do
    visit multitudes_url
    click_on "New multitude"

    fill_in "Banner", with: @multitude.banner
    fill_in "Description", with: @multitude.description
    fill_in "Icon", with: @multitude.icon
    fill_in "Title", with: @multitude.title
    click_on "Create Multitude"

    assert_text "Multitude was successfully created"
    click_on "Back"
  end

  test "should update Multitude" do
    visit multitude_url(@multitude)
    click_on "Edit this multitude", match: :first

    fill_in "Banner", with: @multitude.banner
    fill_in "Description", with: @multitude.description
    fill_in "Icon", with: @multitude.icon
    fill_in "Title", with: @multitude.title
    click_on "Update Multitude"

    assert_text "Multitude was successfully updated"
    click_on "Back"
  end

  test "should destroy Multitude" do
    visit multitude_url(@multitude)
    click_on "Destroy this multitude", match: :first

    assert_text "Multitude was successfully destroyed"
  end
end
