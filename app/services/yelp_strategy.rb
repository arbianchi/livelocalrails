class YelpStrategy

  attr_reader :raw_results, :results, :businesses

  def initialize ops={}
    @api_request        = YelpGemWrapper.for(ops)
    @businesses         = []
    @duplicates_count   = 0
  end

  def create_businesses!
    @api_request.process!
    @api_request.results.each do |result|
      b = Business.new(result)
      begin
        b.save!
        @businesses.push b
      rescue ActiveRecord::RecordInvalid => e
        @duplicates_count += 1

        Rails.logger.debug(
          e.message +
          " (#{@duplicates_count} total errors) this one for business:\n" +
          b.to_json
        )

      end
    end
  end
end
