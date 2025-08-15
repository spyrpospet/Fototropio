# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_08_16_174420) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.integer "position", default: 0
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["position"], name: "index_active_storage_attachments_on_position"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "availabilities", force: :cascade do |t|
    t.string "handle"
    t.boolean "can_buy", default: false, null: false
    t.integer "sort_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["can_buy"], name: "index_availabilities_on_can_buy"
    t.index ["handle"], name: "index_availabilities_on_handle"
    t.index ["sort_order"], name: "index_availabilities_on_sort_order"
  end

  create_table "availability_translations", force: :cascade do |t|
    t.bigint "availability_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["availability_id"], name: "index_availability_translations_on_availability_id"
    t.index ["locale"], name: "index_availability_translations_on_locale"
  end

  create_table "banner_translations", force: :cascade do |t|
    t.bigint "banner_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "sub_title"
    t.index ["banner_id"], name: "index_banner_translations_on_banner_id"
    t.index ["locale"], name: "index_banner_translations_on_locale"
  end

  create_table "banners", force: :cascade do |t|
    t.string "url"
    t.string "position"
    t.boolean "status", default: true
    t.integer "sort_order", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sort_order"], name: "index_banners_on_sort_order"
    t.index ["status"], name: "index_banners_on_status"
  end

  create_table "brand_translations", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.string "meta_title"
    t.text "meta_description"
    t.text "slug"
    t.index ["brand_id"], name: "index_brand_translations_on_brand_id"
    t.index ["locale"], name: "index_brand_translations_on_locale"
  end

  create_table "brands", force: :cascade do |t|
    t.string "record_type"
    t.uuid "record_id"
    t.boolean "status", default: true
    t.integer "sort_order", default: 0
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.boolean "is_collection", default: false
    t.string "handle"
    t.index ["ancestry"], name: "index_brands_on_ancestry"
    t.index ["deleted_at"], name: "index_brands_on_deleted_at"
    t.index ["handle"], name: "index_brands_on_handle"
    t.index ["is_collection"], name: "index_brands_on_is_collection"
    t.index ["sort_order"], name: "index_brands_on_sort_order"
    t.index ["status"], name: "index_brands_on_status"
  end

  create_table "brands_categories", id: false, force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.bigint "category_id", null: false
    t.index ["brand_id", "category_id"], name: "index_brands_categories_on_brand_id_and_category_id"
    t.index ["category_id", "brand_id"], name: "index_brands_categories_on_category_id_and_brand_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "record_type"
    t.uuid "record_id"
    t.boolean "menu", default: false
    t.string "handle"
    t.boolean "status", default: true
    t.integer "sort_order", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.integer "product_price_percentage"
    t.string "url"
    t.string "url_title"
    t.integer "price_change_from_product_code"
    t.integer "price_change_to_product_code"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
    t.index ["deleted_at"], name: "index_categories_on_deleted_at"
    t.index ["handle"], name: "index_categories_on_handle"
    t.index ["menu"], name: "index_categories_on_menu"
    t.index ["product_price_percentage"], name: "index_categories_on_product_price_percentage"
    t.index ["sort_order"], name: "index_categories_on_sort_order"
    t.index ["status"], name: "index_categories_on_status"
  end

  create_table "categories_posts", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categories_posts_on_category_id"
    t.index ["post_id"], name: "index_categories_posts_on_post_id"
  end

  create_table "categories_products", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categories_products_on_category_id"
    t.index ["product_id"], name: "index_categories_products_on_product_id"
  end

  create_table "category_translations", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.string "meta_title"
    t.text "meta_description"
    t.text "slug"
    t.index ["category_id"], name: "index_category_translations_on_category_id"
    t.index ["locale"], name: "index_category_translations_on_locale"
  end

  create_table "countries", force: :cascade do |t|
    t.string "title"
    t.boolean "default", default: false
    t.integer "sort_order", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["default"], name: "index_countries_on_default"
    t.index ["deleted_at"], name: "index_countries_on_deleted_at"
    t.index ["sort_order"], name: "index_countries_on_sort_order"
  end

  create_table "item_translations", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["item_id"], name: "index_item_translations_on_item_id"
    t.index ["locale"], name: "index_item_translations_on_locale"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "option_id", null: false
    t.integer "sort_order", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_items_on_deleted_at"
    t.index ["option_id"], name: "index_items_on_option_id"
    t.index ["sort_order"], name: "index_items_on_sort_order"
  end

  create_table "label_translations", force: :cascade do |t|
    t.bigint "label_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["label_id"], name: "index_label_translations_on_label_id"
    t.index ["locale"], name: "index_label_translations_on_locale"
  end

  create_table "labels", force: :cascade do |t|
    t.boolean "status", default: true
    t.integer "sort_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_labels_on_status"
  end

  create_table "option_products_relations", force: :cascade do |t|
    t.bigint "parent_id", null: false
    t.bigint "options_product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["options_product_id"], name: "index_option_products_relations_on_options_product_id"
    t.index ["parent_id"], name: "index_option_products_relations_on_parent_id"
  end

  create_table "option_translations", force: :cascade do |t|
    t.bigint "option_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["locale"], name: "index_option_translations_on_locale"
    t.index ["option_id"], name: "index_option_translations_on_option_id"
  end

  create_table "options", force: :cascade do |t|
    t.integer "sort_order", default: 0, null: false
    t.boolean "status", default: true
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_options_on_deleted_at"
    t.index ["sort_order"], name: "index_options_on_sort_order"
    t.index ["status"], name: "index_options_on_status"
  end

  create_table "options_products", force: :cascade do |t|
    t.bigint "option_id", null: false
    t.bigint "product_id", null: false
    t.boolean "required", default: false
    t.boolean "filter", default: true
    t.integer "sort_order", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "characteristic", default: false
    t.index ["characteristic"], name: "index_options_products_on_characteristic"
    t.index ["filter"], name: "index_options_products_on_filter"
    t.index ["option_id"], name: "index_options_products_on_option_id"
    t.index ["product_id"], name: "index_options_products_on_product_id"
    t.index ["sort_order"], name: "index_options_products_on_sort_order"
  end

  create_table "options_products_items", force: :cascade do |t|
    t.bigint "options_product_id", null: false
    t.bigint "item_id", null: false
    t.integer "sort_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_options_products_items_on_item_id"
    t.index ["options_product_id"], name: "index_options_products_items_on_options_product_id"
    t.index ["sort_order"], name: "index_options_products_items_on_sort_order"
  end

  create_table "orders", force: :cascade do |t|
    t.json "data"
    t.integer "status", default: 0
    t.integer "sort_order", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "total", precision: 10, scale: 2, default: "0.0"
    t.string "code", null: false
    t.index ["code"], name: "index_orders_on_code"
    t.index ["sort_order"], name: "index_orders_on_sort_order"
    t.index ["status"], name: "index_orders_on_status"
  end

  create_table "page_translations", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.string "meta_title"
    t.text "meta_description"
    t.text "slug"
    t.text "left_column"
    t.text "right_column"
    t.index ["locale"], name: "index_page_translations_on_locale"
    t.index ["page_id"], name: "index_page_translations_on_page_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "record_type"
    t.uuid "record_id"
    t.boolean "menu", default: false
    t.boolean "footer", default: false
    t.boolean "status", default: true
    t.integer "sort_order", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "qlink", default: false
    t.string "handle"
    t.string "ancestry"
    t.index ["ancestry"], name: "index_pages_on_ancestry"
    t.index ["deleted_at"], name: "index_pages_on_deleted_at"
    t.index ["footer"], name: "index_pages_on_footer"
    t.index ["handle"], name: "index_pages_on_handle"
    t.index ["menu"], name: "index_pages_on_menu"
    t.index ["qlink"], name: "index_pages_on_qlink"
    t.index ["sort_order"], name: "index_pages_on_sort_order"
    t.index ["status"], name: "index_pages_on_status"
  end

  create_table "post_translations", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.string "meta_title"
    t.text "meta_description"
    t.text "slug"
    t.index ["locale"], name: "index_post_translations_on_locale"
    t.index ["post_id"], name: "index_post_translations_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.boolean "status", default: true
    t.integer "sort_order", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "popular", default: false
    t.index ["popular"], name: "index_posts_on_popular"
    t.index ["sort_order"], name: "index_posts_on_sort_order"
    t.index ["status"], name: "index_posts_on_status"
  end

  create_table "product_translations", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.string "meta_title"
    t.text "meta_description"
    t.text "slug"
    t.text "short_description"
    t.index ["locale"], name: "index_product_translations_on_locale"
    t.index ["product_id"], name: "index_product_translations_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "record_type"
    t.uuid "record_id"
    t.bigint "availability_id", null: false
    t.bigint "brand_id"
    t.json "data"
    t.string "code", null: false
    t.string "sku"
    t.string "mpn"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.decimal "offer", precision: 10, scale: 2
    t.integer "quantity", default: 1, null: false
    t.boolean "subtract", default: false
    t.boolean "status", default: true
    t.integer "sort_order", default: 0
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "best_seller", default: false
    t.bigint "label_id"
    t.boolean "new_arrival", default: false
    t.string "collection"
    t.index ["availability_id"], name: "index_products_on_availability_id"
    t.index ["best_seller"], name: "index_products_on_best_seller"
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["code"], name: "index_products_on_code"
    t.index ["collection"], name: "index_products_on_collection"
    t.index ["deleted_at"], name: "index_products_on_deleted_at"
    t.index ["label_id"], name: "index_products_on_label_id"
    t.index ["new_arrival"], name: "index_products_on_new_arrival"
    t.index ["offer"], name: "index_products_on_offer"
    t.index ["price"], name: "index_products_on_price"
    t.index ["quantity"], name: "index_products_on_quantity"
    t.index ["sort_order"], name: "index_products_on_sort_order"
    t.index ["status"], name: "index_products_on_status"
  end

  create_table "project_translations", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.text "slug"
    t.index ["locale"], name: "index_project_translations_on_locale"
    t.index ["project_id"], name: "index_project_translations_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.boolean "status", default: true
    t.integer "sort_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sort_order"], name: "index_projects_on_sort_order"
    t.index ["status"], name: "index_projects_on_status"
  end

  create_table "regions", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "title"
    t.boolean "status", default: true
    t.integer "sort_order", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_regions_on_country_id"
    t.index ["deleted_at"], name: "index_regions_on_deleted_at"
    t.index ["sort_order"], name: "index_regions_on_sort_order"
    t.index ["status"], name: "index_regions_on_status"
  end

  create_table "settings", force: :cascade do |t|
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sliders", force: :cascade do |t|
    t.text "url"
    t.text "alt_title"
    t.boolean "status", default: true
    t.integer "sort_order", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sort_order"], name: "index_sliders_on_sort_order"
    t.index ["status"], name: "index_sliders_on_status"
  end

  create_table "solid_cache_entries", force: :cascade do |t|
    t.binary "key", null: false
    t.binary "value", null: false
    t.datetime "created_at", null: false
    t.bigint "key_hash", null: false
    t.integer "byte_size", null: false
    t.index ["byte_size"], name: "index_solid_cache_entries_on_byte_size"
    t.index ["key_hash", "byte_size"], name: "index_solid_cache_entries_on_key_hash_and_byte_size"
    t.index ["key_hash"], name: "index_solid_cache_entries_on_key_hash", unique: true
  end

  create_table "tab_translations", force: :cascade do |t|
    t.bigint "tab_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.index ["locale"], name: "index_tab_translations_on_locale"
    t.index ["tab_id"], name: "index_tab_translations_on_tab_id"
  end

  create_table "tabs", force: :cascade do |t|
    t.string "record_type"
    t.uuid "record_id"
    t.bigint "product_id", null: false
    t.boolean "status", default: true
    t.integer "sort_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_tabs_on_product_id"
    t.index ["sort_order"], name: "index_tabs_on_sort_order"
    t.index ["status"], name: "index_tabs_on_status"
  end

  create_table "type_translations", force: :cascade do |t|
    t.bigint "type_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["locale"], name: "index_type_translations_on_locale"
    t.index ["type_id"], name: "index_type_translations_on_type_id"
  end

  create_table "types", force: :cascade do |t|
    t.string "handle", null: false
    t.string "group", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group"], name: "index_types_on_group"
    t.index ["handle"], name: "index_types_on_handle"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "categories_posts", "categories"
  add_foreign_key "categories_posts", "posts"
  add_foreign_key "categories_products", "categories"
  add_foreign_key "categories_products", "products"
  add_foreign_key "items", "options"
  add_foreign_key "option_products_relations", "options_products"
  add_foreign_key "option_products_relations", "options_products", column: "parent_id"
  add_foreign_key "options_products", "options"
  add_foreign_key "options_products", "products"
  add_foreign_key "options_products_items", "items"
  add_foreign_key "options_products_items", "options_products"
  add_foreign_key "products", "availabilities"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "labels"
  add_foreign_key "regions", "countries"
  add_foreign_key "tabs", "products"
end
