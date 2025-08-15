module Banner::Search
  extend ActiveSupport::Concern

  included do
    include MeiliSearch::Rails
    filters = []

    meilisearch do

      attribute :status
      attribute :position
      attribute :sort_order

      [:status, :position, :sort_order].each do |filter|
        filters << filter
      end

      filterable_attributes filters
      sortable_attributes [:sort_order]
    end

  end
end