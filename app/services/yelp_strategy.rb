class YelpStrategy

  attr_reader :raw_results, :results, :businesses

  def initialize ops={}
    @api_request = YelpGemWrapper.for(ops)
    @businesses = []
  end

  def create_businesses!
    @api_request.process!
    @api_request.results.each do |result|
      @businesses.push Business.create(result)
    end
  end
end
