class SearchController < CommonController
  def index
    @products = Product.search(search_params[:query], {
      attributesToSearchOn: ["title_#{I18n.locale}", :code],
      matchingStrategy: "all"
    })
  end

  private

  def search_params
    params.fetch(:search, {}).permit(:query)
  end
end
