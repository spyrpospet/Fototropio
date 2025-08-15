class AddNewAdmin < ActiveRecord::Migration[7.1]
  def change
    admin           = Admin.new
    admin.email     = "mailleptidianastasia@gmail.com"
    admin.password  = "ko10442@@"
    admin.save!
  end
end
