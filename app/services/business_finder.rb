STRATEGIES = [GoogleStrategy, YelpStrategy, LocuStrategy]

class BusinessFinder

  def initialize
    @results =      []
  end

  def run ops={}
   STRATEGIES.each do |strategy|
     o = strategy.new(ops)
     o.create_businesses!
     @results += o.businesses
     binding.pry
     # break_if @results.count > 100
   end

    binding.pry
    #22.times do
    #  @results.push(FactoryGirl.create :business)
    #end
    return @results
  end

  def page_results
    binding.pry
  end
end
