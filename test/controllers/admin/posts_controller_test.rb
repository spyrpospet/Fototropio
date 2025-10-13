require "test_helper"

class Admin::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = Admin.create!(email: "admin@example.com", password: "password", password_confirmation: "password")
    sign_in @admin

    @post = Post.new(status: true, sort_order: 1)
    @post.send("title_#{I18n.default_locale}=", "Sample Post")
    @post.send("description_#{I18n.default_locale}=", "Desc")
    @post.save!
  end

  test "index renders edit link with data-turbo=false to avoid frame navigation" do
    get admin_posts_path
    assert_response :success

    edit_href = Rails.application.routes.url_helpers.edit_admin_post_path(@post)
    assert_includes @response.body, edit_href
    assert_includes @response.body, 'data-turbo="false"'
  end
end
