module Category::Search
  extend ActiveSupport::Concern

  included do
    include MeiliSearch::Rails
    filters = []
    search_fields = [
      :status,
      :menu,
      :handle,
      :sort_order,
      :descendants
    ]

    meilisearch do
      attribute :status
      attribute :menu
      attribute :handle
      attribute :sort_order

      attribute :descendants do
        self.descendants.map(&:title)
      end

      attribute :descendants_ids do
        self.descendants.map(&:id)
      end

      I18n.available_locales.each do |locale|
        attribute "title_#{locale}"
        attribute "description_#{locale}"
        attribute "slug_#{locale}"

        search_fields << "title_#{locale}"
        filters       << "slug_#{locale}"
      end

      [:status, :menu].each do |filter|
        filters << filter
      end

      filterable_attributes filters
      searchable_attributes search_fields
      sortable_attributes [:title, :sort_order]
    end

  end
end