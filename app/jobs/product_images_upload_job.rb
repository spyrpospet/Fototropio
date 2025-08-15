class ProductImagesUploadJob < ApplicationJob
  queue_as :default

  def perform(product, image_tmp_path)
    # get image from path
    image = File.open(image_tmp_path)

    # attach image to product
    product.images.attach(io: image, filename: File.basename(image_tmp_path))
  end
end
