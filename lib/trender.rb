# US - 23424977
class Trender
  WOEIDS = {
    us: 23424977
  }
  class << self
    # require 'trender'; Trender.create_us_trends
    def create_us_trends
      results = $twitter.trends(WOEIDS[:us]).to_h
      as_of = Time.parse(results[:as_of])
      location = results[:locations].first[:name]
      woeid = results[:locations].first[:woeid]
      results[:trends].each do |x|
        t = Trend.new
        t.as_of = as_of
        t.location = location
        t.woeid = woeid
        t.name = x[:name]
        t.query = x[:query]
        t.url = x[:url]
        t.save!
      end
    end
  end
end
