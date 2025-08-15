class SeedCategoryAndBrandHandle < ActiveRecord::Migration[7.1]
  include CustomTools

  def change
    Category.all.each do |category|
      category.handle = CustomTools.convert_cas_inline(category.title_el.downcase)
      category.save
    end

    Brand.all.each do |brand|
      brand.handle = CustomTools.convert_cas_inline(brand.title_el.downcase)
      brand.save(validate: false)
    end
  end
end
