STRATEGIES = [YelpStrategy, LocuStrategy, GoogleStrategy]

class BusinessFinder

  def initialize
    @results =      []
  end

  def run ops={}
    strategies = ops[:strategies]
    strategies.each do |strategy|
      next unless Object.const_defined?(strategy.to_s)
      o = strategy.new(ops)
      o.create_businesses!
      @results += o.businesses
#     binding.pry
#     break if @results.count >= 20
   end

#    binding.pry
    #22.times do
    #  @results.push(FactoryGirl.create :business)
    #end
    @results.compact!        # TODO: place this closer to the source
    return @results
  end

#  def page_results
#    binding.pry
#  end
end
