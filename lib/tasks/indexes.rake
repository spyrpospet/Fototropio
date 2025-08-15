namespace :indexes do
  task reindex: :environment do
    Category.reindex!
    Product.reindex!
    Brand.reindex!
    Page.reindex!
    Banner.reindex!
  end
end
