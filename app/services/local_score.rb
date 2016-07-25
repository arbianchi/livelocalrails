module LocalScore

  def self.prepare businesses
    @processed_businesses = []
    businesses.each do |biz|
     @processed_businesses.push(self.add_score( biz ))
    end
    @processed_businesses
  end

  def self.add_score record
    record.attributes.merge('local_score' => self.local_score( record ))
  end

  private

  def self.local_score record
     {"true" => record.recommendations.where(value: "true").count,
      "false" => record.recommendations.where(value: "false").count}
  end
end
