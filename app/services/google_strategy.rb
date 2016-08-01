class GoogleStrategy

  attr_reader :businesses

  def initialize ops={}
    @api_request        = GooglePlacesAPIWrapper.for(ops)
    @businesses         = []
    @duplicates_count   = 0
  end

  def create_businesses!
    exit
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
