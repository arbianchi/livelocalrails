class NearbyBusinesses

  def self.for(ops={})
    zip_code    = ops[:zip_code]
    page        = ops[:page] ||= 1
    term        = ops[:term] ||= 'food'
    @results = Business.where(zip_code: zip_code).page(ops[:page])

    # yelp is good, yelp is fast

    # @results += BusinessFinder.new.run(
    #   location: zip_code,
    #   term: term,
    #   strategies: [YelpStrategy]
    # )

    # go search for some results in background

    #BusinessFinderWorker.perform_async(ops)
    #@results += BusinessFinder.new.run(
    #  location: zip_code,
    #  term: term,
    #  strategies: [GoogleStrategy]
    #)
    #return @results

#    unless @results.present?
#      @results = BusinessFinder.new.run(location: zip_code, term: term)
#    end
    return @results
  end
end
