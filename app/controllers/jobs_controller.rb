require 'trender'
class JobsController < ApplicationController
  # curl "http://trendy:trends@localhost:3000/jobs/us"
  def us
    Trender.create_us_trends
    render nothing: true
  end
end
