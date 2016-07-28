class GoogleStrategy

  attr_reader :raw_results, :results, :businesses

  def initialize ops={}
    @client         = GooglePlacesAPI.new
    @api_request    = @client.text_search(ops)
    @businesses = []
  end

  def create_businesses!
    @api_request.results.each do |result|
      @businesses.push Business.create(result)
    end
  end
end
