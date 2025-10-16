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

  test "paginates posts on normal request" do
    # create many posts to trigger pagination (Pagy default per-page 20 here)
    25.times do |i|
      p = Post.new(status: true)
      p.send("title_#{I18n.default_locale}=", "Post #{i}")
      p.send("description_#{I18n.default_locale}=", "Desc #{i}")
      p.save!
    end

    get admin_posts_path(page: 2)
    assert_response :success
    # Expect that first page item is not present and a later one is present
    refute_includes @response.body, "Post 0"
    assert_includes @response.body, "Post 21"
  end

  test "paginates posts within turbo frame by rendering list partial" do
    25.times do |i|
      p = Post.new(status: true)
      p.send("title_#{I18n.default_locale}=", "Post #{i}")
      p.send("description_#{I18n.default_locale}=", "Desc #{i}")
      p.save!
    end

    get admin_posts_path(page: 2), headers: { "Turbo-Frame" => "search_body" }
    assert_response :success
    # Should include the turbo-frame wrapper and the expected records
    assert_includes @response.body, '<turbo-frame id="search_body"'
    refute_includes @response.body, "Post 0"
    assert_includes @response.body, "Post 21"
  end
end
