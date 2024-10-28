require "test_helper"

class MultitudesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @multitude = multitudes(:one)
  end

  test "should get index" do
    get multitudes_url
    assert_response :success
  end

  test "should get new" do
    get new_multitude_url
    assert_response :success
  end

  test "should create multitude" do
    assert_difference("Multitude.count") do
      post multitudes_url, params: { multitude: { banner: @multitude.banner, description: @multitude.description, icon: @multitude.icon, title: @multitude.title } }
    end

    assert_redirected_to multitude_url(Multitude.last)
  end

  test "should show multitude" do
    get multitude_url(@multitude)
    assert_response :success
  end

  test "should get edit" do
    get edit_multitude_url(@multitude)
    assert_response :success
  end

  test "should update multitude" do
    patch multitude_url(@multitude), params: { multitude: { banner: @multitude.banner, description: @multitude.description, icon: @multitude.icon, title: @multitude.title } }
    assert_redirected_to multitude_url(@multitude)
  end

  test "should destroy multitude" do
    assert_difference("Multitude.count", -1) do
      delete multitude_url(@multitude)
    end

    assert_redirected_to multitudes_url
  end
end
