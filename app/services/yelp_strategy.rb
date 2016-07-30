class YelpStrategy

  attr_reader :raw_results, :results, :businesses

  def initialize ops={}
    @api_request = YelpGemWrapper.for(ops)
    @businesses = []
  end

  def create_businesses!
    @api_request.process!
    @api_request.results.each do |result|
      binding.pry       # businesses with same yelp id are being created, validations not working; why?
      b = Business.new(result)
      begin
        if b.save!
          @businesses.push b
        end
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.debug(e, b)
      end
    end
  end
end
