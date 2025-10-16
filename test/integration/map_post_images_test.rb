require "test_helper"

class MapPostImagesTest < ActionDispatch::IntegrationTest
  test "post page renders images from description" do
    # Ensure fixtures are loaded
    post = posts(:published)
    # Sanity: translation provides slug
    get map_url(slugs: 'sample-post')
    assert_response :success
    assert_includes @response.body, '<img'
    assert_includes @response.body, 'src="/images/sample.png"'
  end
end
