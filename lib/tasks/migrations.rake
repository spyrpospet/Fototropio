namespace :migrations do
  task old_to_new: :environment do
    old_images_url = Rails.root.join("public", "old-images")

    mysql_config = {
      adapter:  'mysql2',
      host:     'localhost',
      username: 'root',
      password: '',
      database: 'emvalomenos'
    }
    post_config = {
      adapter:  'postgresql',
      host:     'localhost',
      username: 'postgres',
      password: 'root',
      database: 'emvalomenos',
      port:     "5432"
    }

    mysql_client          = ActiveRecord::Base.establish_connection(mysql_config)
    mysql_body_text       = mysql_client.connection.execute("SELECT * FROM bodytext")
    mysql_availabilities  = mysql_client.connection.execute("SELECT * FROM availability")
    mysql_suppliers       = mysql_client.connection.execute("SELECT * FROM suppliers")
    mysql_categories      = mysql_client.connection.execute("SELECT * FROM categories")
    mysql_groups          = mysql_client.connection.execute("SELECT * FROM groups")
    mysql_filters         = mysql_client.connection.execute("SELECT * FROM filters")
    old_products          = mysql_client.connection.execute("SELECT * FROM products")
    mysql_product_atts    = mysql_client.connection.execute("SELECT * FROM products_atts")
    mysql_product_images  = mysql_client.connection.execute("SELECT * FROM products_images")
    mysql_product_filters = mysql_client.connection.execute("SELECT * FROM products_filters")

    ActiveRecord::Base.establish_connection(post_config)

    # mysql_suppliers&.each do |row|
    #   brand                   = Brand.find_or_initialize_by(id: row[0])
    #   brand.title             = row[1]
    #   brand.slug              = row[1]
    #
    #   if row[2].present? && File.exist?("#{old_images_url}/logos/#{row[2]}")
    #     brand.image.purge if brand.image.attached?
    #
    #     brand.image           = File.open("#{old_images_url}/logos/#{row[2]}")
    #   end
    #
    #   brand.save
    # end
    #
    # wanted_ids    = [6,4,5,2,3,7,35,53,54,55]
    #
    # mysql_body_text&.each do |row|
    #   next unless wanted_ids.include?(row[0])
    #
    #   page                  = Page.find_or_initialize_by(id: row[0])
    #   page.title            = row[1]
    #   page.description      = row[4]
    #
    #   page.save
    # end
    #
    # mysql_availabilities&.each do |row|
    #   availability          = Availability.find_or_initialize_by(id: row[0])
    #   availability.title    = row[1]
    #   availability.can_buy  = row[2] == 1 ? true : false
    #
    #   availability.save
    # end
    #
    # mysql_categories&.each do |row|
    #   category                  = Category.find_or_initialize_by(id: row[3])
    #   category.title            = row[0]
    #   category.description      = row[9]
    #   category.meta_title       = row[20]
    #   category.meta_description = row[22]
    #   category.slug             = row[2]
    #   category.status           = row[16] == 0 ? true : false
    #
    #   if row[5].present? && File.exist?("#{old_images_url}/category_img/#{row[5]}")
    #     category.image.purge if category.image.present?
    #
    #     category.image.attach(io: File.open("#{old_images_url}/category_img/#{row[5]}"), filename: row[5])
    #   end
    #
    #   category.save
    # end
    #
    # mysql_categories&.each do |row|
    #   next if row[4] == 0
    #
    #   category           = Category.find(row[3])
    #   category.parent_id = row[4]
    #   category.save
    # end
    #
    # mysql_groups&.each do |row|
    #   option              = Option.find_or_initialize_by(id: row[0])
    #   option.title        = row[1]
    #
    #   option.save
    # end
    #
    # mysql_filters&.each do |filter|
    #   option          = Option.find_by(id: filter[1])
    #
    #   next if option.blank?
    #
    #   item            = Item.find_or_initialize_by(id: filter[0])
    #   item.option     = option
    #   item.title      = filter[2]
    #
    #   item.save
    # end
    #
    #     brands          = Brand.all.pluck(:id)
    #     categories      = Category.all.pluck(:id)
    #
    #     old_product&.each do |row|
    #       next unless categories.include?(row[54].to_i)
    #
    #       attrs                      = mysql_product_atts.first { |att| att[1] == row[0] }
    #       product                    = Product.find_or_initialize_by(id: row[0])
    #       product.title              = row[2]
    #
    #       product.mixanismos        = row[69]
    #       product.kristalo          = row[70]
    #       product.kantran           = row[71]
    #       product.plaisio           = row[72]
    #       product.brasele           = row[73]
    #       product.louraki           = row[74]
    #       product.koumpoma          = row[75]
    #       product.adiavroxo         = row[76]
    #       product.diametros         = row[77]
    #       product.leitourgeies      = row[78]
    #       product.eggyhsh           = row[79]
    #       product.metalo            = row[80]
    #       product.finirisma         = row[81]
    #       product.varos_kosmimatos  = row[82]
    #       product.eidos             = row[83]
    #       product.kopsimo           = row[84]
    #       product.varos_petras      = row[85]
    #       product.katharotita       = row[86]
    #       product.diastaseis        = row[87]
    #
    #       product.description        = row[6]
    #       product.code               = row[1]
    #       product.mpn                = row[66] if row[66].present?
    #       product.price              = row[20]
    #       product.offer              = attrs[6]
    #       product.availability_id    = (row[67].to_i == 0 ? 6 : row[67].to_i)
    #       product.brand_id           = row[48].to_i if brands.include?(row[48].to_i)
    #       product.meta_description   = row[53]
    #       product.slug               = row[50] if row[50].present?
    #
    #       product.categories         << Category.find_by(id: row[54].to_i)
    #
    #
    #       product.save(validate: false) rescue binding.pry
    #     end

    # Product.find_each do |product|
    #   product.images.purge
    # end

    # Product.find_each do |product|
    #   next if product.images.present?
    #
    #   mysql_product = old_product.select { |row| row[0] == product.id }.first
    #
    #   if mysql_product.present?
    #     if mysql_product[10].present? && File.exist?("#{old_images_url}/#{mysql_product[10]}")
    #       blob = ActiveStorage::Blob.create_and_upload!(
    #         io: File.open("#{old_images_url}/#{mysql_product[10]}"),
    #         filename: mysql_product[10]
    #       )
    #       product.images.attach(blob)
    #     end
    #
    #     if mysql_product[11].present? && File.exist?("#{old_images_url}/#{mysql_product[11]}")
    #       product.images.attach(io: File.open("#{old_images_url}/#{mysql_product[11]}"), filename: mysql_product[11])
    #     end
    #
    #     if mysql_product[12].present? && File.exist?("#{old_images_url}/#{mysql_product[12]}")
    #       product.images.attach(io: File.open("#{old_images_url}/#{mysql_product[12]}"), filename: mysql_product[12])
    #     end
    #
    #     if mysql_product[12].present? && File.exist?("#{old_images_url}/#{mysql_product[12]}")
    #       product.images.attach(io: File.open("#{old_images_url}/#{mysql_product[12]}"), filename: mysql_product[12])
    #     end
    #
    #     if mysql_product[13].present? && File.exist?("#{old_images_url}/#{mysql_product[13]}")
    #       product.images.attach(io: File.open("#{old_images_url}/#{mysql_product[13]}"), filename: mysql_product[13])
    #     end
    #
    #     if mysql_product[14].present? && File.exist?("#{old_images_url}/#{mysql_product[14]}")
    #       product.images.attach(io: File.open("#{old_images_url}/#{mysql_product[14]}"), filename: mysql_product[14])
    #     end
    #
    #     if mysql_product[15].present? && File.exist?("#{old_images_url}/#{mysql_product[15]}")
    #       product.images.attach(io: File.open("#{old_images_url}/#{mysql_product[15]}"), filename: mysql_product[15])
    #     end
    #
    #     if mysql_product[16].present? && File.exist?("#{old_images_url}/#{mysql_product[16]}")
    #       product.images.attach(io: File.open("#{old_images_url}/#{mysql_product[16]}"), filename: mysql_product[16])
    #     end
    #
    #     if mysql_product[17].present? && File.exist?("#{old_images_url}/#{mysql_product[17]}")
    #       product.images.attach(io: File.open("#{old_images_url}/#{mysql_product[17]}"), filename: mysql_product[17])
    #     end
    #
    #     if mysql_product[18].present? && File.exist?("#{old_images_url}/#{mysql_product[18]}")
    #       product.images.attach(io: File.open("#{old_images_url}/#{mysql_product[18]}"), filename: mysql_product[18])
    #     end
    #
    #     if mysql_product[19].present? && File.exist?("#{old_images_url}/#{mysql_product[19]}")
    #       product.images.attach(io: File.open("#{old_images_url}/#{mysql_product[19]}"), filename: mysql_product[19])
    #     end
    #   end
    #
    #   images  = mysql_product_images.select { |img| img[1] == product.id }.sort_by { |img| img[4] }
    #
    #   images&.each do |img|
    #     next unless File.exist?("#{old_images_url}/#{img[2]}")
    #
    #     product.images.attach(io: File.open("#{old_images_url}/#{img[2]}"), filename: img[2])
    #   end
    # end

    # Product.find_each do |product|
    #   mysql_filters = mysql_product_filters.select { |row| row[1] == product.id }
    #
    #   mysql_filters&.each do |filter|
    #     item = Item.find_by(id: filter[2])
    #
    #     next if item.blank?
    #
    #     option_product          = OptionsProduct.new
    #     option_product.product  = product
    #     option_product.option   = item.option
    #     option_product.save
    #
    #     option_product_item                 = OptionsProductsItem.new
    #     option_product_item.options_product = option_product
    #     option_product_item.item            = item
    #     option_product_item.save
    #   end
    # end

    # Product.find_each do |product|
    #   attrs = mysql_product_atts.select { |att| att[1] == product.id }.first
    #
    #   next if attrs.blank?
    #
    #   if attrs[2].to_d == 0 && attrs[6].to_d.positive?
    #     product.price = attrs[6].to_d
    #   else
    #     product.price = attrs[2].to_d
    #     product.offer = (attrs[6].to_d == 0 ? nil : attrs[6].to_d)
    #   end
    #
    #   product.save
    # end

    Product.find_each do |product|
      old_product   = old_products.select do |row|
        row[0] == product.id
      end.first

      next if old_product.blank?

      product_attrs = mysql_product_atts.select { |item| item[1] == product.id }

      price = 0
      offer = 0

      if product_attrs.length > 1
        list      = product_attrs.map {|item| [item[0], [item[2], item[6]].max]}
        max_item  = list.max_by { |item| item[1] }
        item      = product_attrs.select { |item| item[0] == max_item[0] }.first

        price     = item[2]
        offer     = (product_attrs[6].to_d == 0 ? nil : product_attrs[6].to_d)
      else
        product_attrs = product_attrs.first
        price         = product_attrs[2]
        offer         = (product_attrs[6].to_d == 0 ? nil : product_attrs[6].to_d)
      end

      if price.to_d.zero? && offer.to_d.positive?
        price = offer
        offer = nil
      end

      mechanism = {
        "1" => "Quartz ακριβείας",
        "2" => "Quartz ελβετικός μηχανισμός ακριβείας",
        "3" => "Αυτόματος ελβετικός μηχανισμός",
        "4" => "Αυτόματος μηχανισμός",
        "5" => "Quartz ψηφιακός ακριβείας",
        "6" => "Κουρδιστός ελβετικός μηχανισμός",
        "7" => "Κουρδιστός μηχανισμός"
      }

      crystal = {
        "1" => "Αχάρακτο κρύσταλλο σαπφείρου",
        "2" => "Ορυκτό κρύσταλλο",
        "3" => "Ανθεκτικό πλάστικό",
        "4" => "Ορυκτό μεγάλης αντοχής",
      }

      frame_material = {
        "1" => "Ανοξείδωτο ατσάλι",
        "2" => "Μαύρο ανοξείδωτο ατσάλι",
        "3" => "Μαύρο καουτσούκ",
        "4" => "Τιτάνιο",
        "5" => "Επιχρυσωμένο ανοξείδωτο ατσάλι",
        "6" => "Δίχρωμο ανοξείδωτο ατσάλι",
        "7" => "Ατσάλι χρυσό κ18",
        "8" => "Επιχρυσωμένο ανοξείδωτο ατσάλι",
        "10" => "Πολυκαρβονικό",
        "11" => "Χρυσό 18κ",
        "12" => "Μεταλλικό",
        "13" => "ΠΛΑΣΤΙΚΟ",
        "14" => "ΑΛΟΥΜΙΝΙΟ",
        "15" => "Ασήμι",
      }

      bracelet = {
        "1" => "Ανοξείδωτο ατσάλι",
        "2" => "Μαύρο ανοξείδωτο ατσάλι",
        "3" => "Τιτάνιο",
        "4" => "Επιχρυσωμένο ανοξείδωτο ατσάλι",
        "5" => "Χρυσό κ18",
        "6" => "Δίχρωμο ανοξείδωτο ατσάλι",
        "7" => "Ατσάλι χρυσό κ18",
        "8" => "Πολυκαρβονικό",
        "9" => "ΑΛΟΥΜΙΝΙΟ",
        "10" => "ΜΕΤΑΛΛΙΚΟ",
        "11" => "Ασήμι"
      }

      strap = {
        "1" => "Δερμάτινο",
        "2" => "Αλιγάτορας",
        "3" => "Καουτσούκ",
        "4" => "Πλαστικό",
        "5" => "Σιλικόνη"
      }

      clasp = {
        "1" => "Ασφαλείας",
        "2" => "Τοκάς απλός",
        "3" => "Αναδιπλούμενος τοκάς",
      }

      material_metal = {
        "1" => "Ατσάλι",
        "2" => "Χρυσό 14κ",
        "3" => "Χρυσό 18κ",
        "4" => "Χρυσό 9κ",
        "5" => "Λευκόχρυσο 14κ",
        "6" => "Λευκόχρυσο 18κ",
        "7" => "Λευκόχρυσο 9κ",
        "8" => "ρόζ χρυσό 14κ",
        "9" => "ρόζ χρυσό 18κ",
        "10" => "ρόζ χρυσό 9κ",
        "11" => "Επίχρυσο",
        "12" => "Επιχρυσωμένο ατσάλι",
        "13" => "Ορείχαλκος",
        "14" => "Ασήμι"
      }

      finish = {
        "1" => "Λουστρέ",
        "2" => "Σαγρέ",
        "3" => "Μάτ/Σαγρέ",
        "4" => "Λουστρέ ματ εσωτερικό",
        "5" => "Σφυριλατό",
        "6" => "Ματ λουστρέ"
      }

      product.mechanism       = mechanism[old_product[69]]       if old_product[69].to_i.positive?
      product.crystal         = crystal[old_product[70]]         if old_product[70].to_i.positive?
      product.dial_color      = old_product[71]
      product.frame_material  = frame_material[old_product[72]]  if old_product[72].to_i.positive?
      product.bracelet        = bracelet[old_product[73]]        if old_product[73].to_i.positive?
      product.strap           = strap[old_product[74]]           if old_product[74].to_i.positive?
      product.clasp           = clasp[old_product[75]]           if old_product[75].to_i.positive?
      product.raincoat        = old_product[76]
      product.case_size       = old_product[77]
      product.operations      = old_product[78]
      product.warranty        = old_product[79]
      product.material_metal  = material_metal[old_product[80]]  if old_product[80].to_i.positive?
      product.finish          = finish[old_product[81]]          if old_product[81].to_i.positive?
      product.weight          = old_product[82]
      product.stone           = old_product[83]
      product.stone_cutting   = old_product[84]
      product.stone_weight    = old_product[85]
      product.stone_color     = old_product[86]
      product.stone_purity    = old_product[87]
      product.jewelry_dimensions = old_product[88]
      product.price           = price
      product.offer           = offer
      product.save
    end
  end
end
