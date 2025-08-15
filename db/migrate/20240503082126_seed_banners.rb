class SeedBanners < ActiveRecord::Migration[7.1]
  def change
    new_banner          = Banner.new
    new_banner.url      = ""
    new_banner.position = Banner::HOME
    new_banner.save!

    new_banner          = Banner.new
    new_banner.url      = ""
    new_banner.position = Banner::HOME
    new_banner.save!

    new_banner          = Banner.new
    new_banner.url      = ""
    new_banner.position = Banner::HOME_BEST_SELLER
    new_banner.save!
  end
end
