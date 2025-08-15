class AddAdmin < ActiveRecord::Migration[7.1]
  def change
    admin           = Admin.new
    admin.email     = "dimopoulos.ira@gmail.com"
    admin.password  = "ko10442@@"
    admin.save!
  end
end
