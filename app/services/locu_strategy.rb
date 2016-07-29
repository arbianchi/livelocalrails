class LocuStrategy

  attr_reader :businesses

  def initialize ops={}
    @api_request    = LocuAPIWrapper.for(ops)
    @businesses     = []
  end

  def create_businesses!
    @api_request.process!
    @api_request.results.each do |result|
      @businesses.push Business.create(result)
    end
  end
end
