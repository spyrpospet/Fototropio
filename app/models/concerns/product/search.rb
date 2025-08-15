module Product::Search
  extend ActiveSupport::Concern

  included do
    include MeiliSearch::Rails

    meilisearch do
      filters       = []
      sortables     = []
      searchables   = []

      I18n.available_locales.each do |locale|
        attribute "title_#{locale}"
        attribute "description_#{locale}"
        attribute "brand_#{locale}" do
          brand&.send("title_#{locale}")
        end

        attribute "categories_#{locale}" do
          categories.map { |category| category.send("slug_#{locale}") }
        end

        attribute "filters_#{locale}" do
          options_products.filters.map do |options_products|
            next unless options_products.option.is_published?

            {options_products.option.send("title_#{locale}") => options_products.options_products_item.map { |options_products_item| options_products_item.item.send("title_#{locale}") }}
          end
        end

        attribute "filters_#{locale}" do
          options_products.filters.map do |options_products|
            next unless options_products.option.is_published?

            {options_products.option.send("title_#{locale}") => options_products.options_products_item.map { |options_products_item| options_products_item.item.send("title_#{locale}") }}
          end
        end

        attribute "filter_options_#{locale}" do
          options_products.filters.map do |options_products|
            next unless options_products.option.is_published?
            options_products.option.send("title_#{locale}")
          end
        end

        attribute "filter_items_#{locale}" do
          options_products.filters.map do |options_products|
            next unless options_products.option.is_published?
            options_products.options_products_item.map { |options_products_item| options_products_item.item.send("title_#{locale}") }
          end
        end

        filters << "filters_#{locale}"
        filters << "filter_options_#{locale}"
        filters << "filter_items_#{locale}"
        searchables << "title_#{locale}"
        searchables << "categories_#{locale}"
      end

      attribute :code
      attribute :sku
      attribute :mpn
      attribute :offer
      attribute :status
      attribute :best_seller
      attribute :new_arrival
      attribute :sort_order

      attribute :net_price do
        net_price.to_f
      end

      attribute :collection do
        send("collection")
      end

      filters << :collection

      attribute :category_ids do
        categories.pluck(:id).join(' ')
      end

      searchables << :code
      searchables << :category_ids

      [:status, :best_seller, :new_arrival, :sort_order].each do |attribute|
        filters << attribute
      end

      sortables << :sort_order
      sortables << :net_price

      filterable_attributes filters
      sortable_attributes sortables
      searchable_attributes searchables
    end

  end
end