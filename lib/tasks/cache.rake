# Custom rake task to clear Rails cache
# Usage:
#   bin/rails cache:clear
#   rake cache:clear

namespace :cache do
  desc "Clear the application cache (equivalent to Rails.cache.clear)"
  task clear: :environment do
    Rails.cache.clear
    puts "Cache cleared."
  end
end
