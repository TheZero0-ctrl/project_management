require "test_helper"

class TaskFilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get task_files_show_url
    assert_response :success
  end
end
