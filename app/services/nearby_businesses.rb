class NearbyBusinesses

  def self.for(ops={})
    zip_code = ops[:zip_code]
    term = ops[:term] ||= 'food'
    @results = Business.where(zip_code: zip_code)

    unless @results.present?
      @results = BusinessFinder.new.run(location: zip_code, term: term)
    end
    return @results
  end
end
