module YelpScraper

  DESTINATION_FILE = Rails.root.join "db/businesses_store.json"

  def self.scrape_to_csv(txt_file)
    d = DESTINATION_FILE.open("a+")

    businesses = []
    File.read(Rails.root.join txt_file).each_line do |line|
      line = [line.chop, "Durham", "NC"]  # hackery for now
      #line = line.split(",")
      args = {term: line[0], location: line[1] + "," + line[2]}
      businesses << args
    end
    businesses.each do |business|
      b = YelpGemWrapper.FindBusiness(location: "Durham", term: business)
      if b.present?
        o = YelpGemWrapper.package_business(b)
        d << o.to_json
      end
    end
    d.close
  end

end
