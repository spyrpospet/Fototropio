class AddShortDescriptionToProductTranslations < ActiveRecord::Migration[7.1]
  def change
    add_column :product_translations, :short_description, :text, null: true
  end
end
