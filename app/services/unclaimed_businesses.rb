class UnclaimedBusinesses

  def self.for ops={}
    @businesses = Business.where(owner_id: nil)
    unless @results.present?
      @results = BusinessFinder.new.run(location: ops[:location], term: ops[:term])
    end
    return @results
  end

end
