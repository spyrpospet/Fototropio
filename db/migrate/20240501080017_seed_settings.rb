class SeedSettings < ActiveRecord::Migration[7.1]
  def change
    setting         = Setting.new
    setting.website = 'https://www.example.com'
    setting.save
  end
end
