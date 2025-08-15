xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", 'xmlns:g' => 'http://base.google.com/ns/1.0' do
  xml.channel do
    xml.title "Emvalomenos Google store"
    xml.link "https://store.google.com"

    @products&.each do |product|
      next if product.first_category.blank?
      next if product.main_image.blank?

      xml.item do
        xml.tag!('g:id', product.id)
        xml.tag!('g:title', product.title)
        xml.tag!('g:description', product.description) if product.description.present?
        xml.tag!('g:link', map_url([product.first_category.slug, product.slug]))
        xml.tag!('g:image_link', "https://" + request.host + url_for(product.main_image))
        xml.tag!('g:condition', "new")
        xml.tag!('g:availability', "in stock")
        xml.tag!('g:price', "#{product.net_price.to_s} EUR")
        xml.tag!('g:brand', product.brand.title) if product.brand.present?
      end
    end
  end
end