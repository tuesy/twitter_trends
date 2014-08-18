class HomeController < ApplicationController
  def index
    @trends = Trend.where(as_of: 1.week.ago..Time.zone.now).order('as_of DESC')
    @counts = {}
    @trends.each do |x|
      if @counts.has_key?(x.name)
        @counts[x.name] += 1
      else
        @counts[x.name] = 1
      end
    end
  end
  def http_basic?
    false
  end
end
