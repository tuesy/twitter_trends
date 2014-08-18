require 'trender'
require 'raker'
namespace :trends do
  desc 'twitter trends for the US'
  task :us => :environment do
    Raker.p 'starting', Trender
    Trender.create_us_trends
    Raker.p 'finished', Trender
  end
end
