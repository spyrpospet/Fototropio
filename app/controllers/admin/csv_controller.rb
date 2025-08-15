require 'rubygems'
require 'zip'
require 'roo'

class Admin::CsvController < Admin::CommonController
  include CustomTools

  def upload
    unzip_file
    upload_csv
  end

  def unzip_file
    file                 = upload_params[:file]

    return if file.blank?

    csv_path             = Rails.root.join("csv")

    FileUtils.mkdir_p(csv_path) if !File.directory?(csv_path)

    # Clean up existing contents of csv directory
    FileUtils.rm_rf(Dir.glob("#{Rails.root.join('csv')}/*"))

    zips_directory_path  = csv_path

    # write file tp zips directory path
    File.open(zips_directory_path.join(file.original_filename), 'wb') do |f|
      f.write(file.read)
    end

    # unzip file
    Zip::File.open(zips_directory_path.join(file.original_filename)) do |zip_file|
      zip_file.each do |entry|
        # create file
        File.open(zips_directory_path.join(entry.name), 'wb') do |f|
          f.write(entry.get_input_stream.read)
        end
      end

      zip_file.close
    end
  end

  def upload_csv
    file_path                     = Rails.root.join("csv")

    xlsx                          = Roo::Spreadsheet.open(file_path.join("products.xlsx").to_s)

    row                           = xlsx.sheet(0).row(1)

    mechanism_is_filter           = row[13].include?("filter=1") ? true : false
    crystal_is_filter             = row[14].include?("filter=1") ? true : false
    dial_color_is_filter          = row[15].include?("filter=1") ? true : false
    frame_material_is_filter      = row[16].include?("filter=1") ? true : false
    bracelet_is_filter            = row[17].include?("filter=1") ? true : false
    strap_is_filter               = row[18].include?("filter=1") ? true : false
    clasp_is_filter               = row[19].include?("filter=1") ? true : false
    raincoat_is_filter            = row[20].include?("filter=1") ? true : false
    case_size_is_filter           = row[21].include?("filter=1") ? true : false
    operations_is_filter          = row[22].include?("filter=1") ? true : false
    warranty_is_filter            = row[23].include?("filter=1") ? true : false
    material_metal_is_filter      = row[24].include?("filter=1") ? true : false
    gold_karats_is_filter         = row[25].include?("filter=1") ? true : false
    finish_is_filter              = row[26].include?("filter=1") ? true : false
    weight_is_filter              = row[27].include?("filter=1") ? true : false
    stone_is_filter               = row[28].include?("filter=1") ? true : false
    stone_cutting_is_filter       = row[29].include?("filter=1") ? true : false
    stone_weight_is_filter        = row[30].include?("filter=1") ? true : false
    stone_color_is_filter         = row[31].include?("filter=1") ? true : false
    stone_purity_is_filter        = row[32].include?("filter=1") ? true : false

    (1..xlsx.last_row).each do |index|
      next unless index > 2

      row                         = xlsx.sheet(0).row(index)

      row_category                = row[7]
      category                    = nil

      if row_category.present?
        if row_category.include?("|")
          row_category.split("|").each_with_index do |item, index|

            pre_category          = Category.find_or_initialize_by(handle: CustomTools.convert_cas_inline(item.downcase))
            pre_category.title    = item if pre_category.new_record?
            pre_category.parent   = Category.find_by(handle: CustomTools.convert_cas_inline(row_category.split("|")[index - 1].downcase)) if index > 0

            pre_category.save

            category = pre_category if index == row_category.split("|").length - 1
          end
        else
          pre_category        = Category.find_or_initialize_by(id: 617)
          pre_category.title  = row_category if pre_category.new_record?
          pre_category.save

          category = pre_category
        end
      end

      product                               = Product.find_or_initialize_by(code: row[0])

      product.title                         = row[1]
      product.price                         = row[5]
      product.offer                         = row[6]
      product.short_description             = row[10]
      product.description                   = row[11]
      product.sex                           = row[12]
      product.mechanism                     = row[13]
      product.mechanism_is_filter           = mechanism_is_filter
      product.crystal                       = row[14]
      product.crystal_is_filter             = crystal_is_filter
      product.dial_color                    = row[15]
      product.dial_color_is_filter          = dial_color_is_filter
      product.frame_material                = row[16]
      product.frame_material_is_filter      = frame_material_is_filter
      product.bracelet                      = row[17]
      product.bracelet_is_filter            = bracelet_is_filter
      product.strap                         = row[18]
      product.strap_is_filter               = strap_is_filter
      product.clasp                         = row[19]
      product.clasp_is_filter               = clasp_is_filter
      product.raincoat                      = row[20]
      product.raincoat_is_filter            = raincoat_is_filter
      product.case_size                     = row[21]
      product.case_size_is_filter           = case_size_is_filter
      product.operations                    = row[22]
      product.operations_is_filter          = operations_is_filter
      product.warranty                      = row[23]
      product.warranty_is_filter            = warranty_is_filter
      product.material_metal                = row[24]
      product.material_metal_is_filter      = material_metal_is_filter
      product.gold_karats                   = row[25]
      product.gold_karats_is_filter         = gold_karats_is_filter
      product.finish                        = row[26]
      product.finish_is_filter              = finish_is_filter
      product.weight                        = row[27]
      product.weight_is_filter              = weight_is_filter
      product.stone                         = row[28]
      product.stone_is_filter               = stone_is_filter
      product.stone_cutting                 = row[29]
      product.stone_cutting_is_filter       = stone_cutting_is_filter
      product.stone_weight                  = row[30]
      product.stone_weight_is_filter        = stone_weight_is_filter
      product.stone_color                   = row[31]
      product.stone_color_is_filter         = stone_color_is_filter
      product.stone_purity                  = row[32]
      product.stone_purity_is_filter        = stone_purity_is_filter
      product.jewelry_dimensions            = row[33]

      if row[34].present?
        label = Label.find_by(title: row[34])
        product.label = label if label.present?
      end

      product.availability                  = Availability.available
      product.categories                    << category unless product.categories.include?(category)

      product.save! rescue binding.pry

      pre_collection              = row[8]
      pre_brand                   = row[9]

      if pre_brand.present? && pre_collection.present?
        collection                = Brand.find_or_initialize_by(title: pre_collection.upcase)
        collection.is_collection  = true
        collection.products       << product
        collection.save!

        product.collection        = collection.title
        product.save!

        brand                     = Brand.find_or_initialize_by(title: pre_collection.upcase)
        brand.parent              = collection
        brand.save!
      elsif pre_brand.present? && pre_collection.blank?
        brand                     = Brand.find_or_initialize_by(title: pre_brand.upcase)
        brand.products            << product
        brand.save!
      end

      puts "New product with code #{product.code} was created"

      image                       = row[2]

      if image.present? && File.exist?("#{file_path}/#{image}") && product.images.blank?
        product.images.attach(io: File.open("#{file_path}/#{image}"), filename:image)
      end
    end

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update("csv-success", partial: "/admin/csv/success") }
    end
  end

  private


  def upload_params
    params.fetch(:upload).permit(:file)
  end
end
