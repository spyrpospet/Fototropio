class AddDefaultAccountToAdmin < ActiveRecord::Migration[7.1]
  def change

    if Admin.all.empty?
      admin           = Admin.new
      admin.email     = "petridhs.spyros@gmail.com"
      admin.password  = "Ko10442@@"
      admin.save!
    end
  end
end
