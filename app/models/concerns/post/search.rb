module Post::Search
  extend ActiveSupport::Concern

  included do
    include MeiliSearch::Rails
    filters = []

    meilisearch do
      I18n.available_locales.each do |locale|
        attribute "title_#{locale}"
        attribute "description_#{locale}"
        attribute "slug_#{locale}"

        filters << "slug_#{locale}"
      end

      attribute :status
      attribute :sort_order

      [:status, :menu].each do |filter|
        filters << filter
      end

      filterable_attributes filters
      sortable_attributes [:title, :sort_order]
    end

  end
end