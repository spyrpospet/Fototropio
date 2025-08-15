xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
xml.urlset :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  @pages&.each do |page|
    xml.url do
      xml.loc map_url(page.slug)
      xml.lastmod page.updated_at.strftime("%Y-%m-%d")
    end
  end

  @brands&.each do |brand|
    xml.url do
      xml.loc map_url(brand.slug)
      xml.lastmod brand.updated_at.strftime("%Y-%m-%d")
    end
  end

  @categories&.each do |category|
    xml.url do
      if category.ancestors.present?
        xml.loc map_url((category.ancestors.map(&:slug).join("/") + "/" + category.slug))
      else
        xml.loc map_url(category.slug)
      end

      xml.lastmod category.updated_at.strftime("%Y-%m-%d")
    end
  end

  @products&.each do |product|
    next if product.categories.blank?

    xml.url do
      xml.loc map_url((product.first_category.slug + "/" + product.slug))
      xml.lastmod product.updated_at.strftime("%Y-%m-%d")
    end
  end
end