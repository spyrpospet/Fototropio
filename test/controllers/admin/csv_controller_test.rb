require "test_helper"

class Admin::CsvControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get admin_csv_upload_url
    assert_response :success
  end
end
