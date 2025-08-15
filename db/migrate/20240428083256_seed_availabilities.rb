class SeedAvailabilities < ActiveRecord::Migration[7.1]
  def change
    availability            = Availability.new
    availability.handle     = "available"
    availability.can_buy    = true
    availability.title_el   = "Διαθέσιμο"
    availability.save!

    availability            = Availability.new
    availability.handle     = "not_available"
    availability.can_buy    = false
    availability.title_el   = "Μη διαθέσιμο"
    availability.save!
  end
end
