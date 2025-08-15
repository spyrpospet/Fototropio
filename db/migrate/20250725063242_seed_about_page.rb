class SeedAboutPage < ActiveRecord::Migration[7.1]
  def change
    Page.create!(
      title: "About page",
      handle: "about",
      status: "published"
    )
  end
end
