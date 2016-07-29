STRATEGIES = [GoogleStrategy, YelpStrategy]

class BusinessFinder

  def initialize
    @results =      []
  end

  def run ops={}
    STRATEGIES.each do |strategy|
      o = strategy.new(ops)
      o.create_businesses!
      @results += o.businesses
      # break_if @results.count > 100
    end
    return @results
  end
end
