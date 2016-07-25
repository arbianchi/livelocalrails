def process_line line
  line.sub(/\n/,"").split(",")
end

class YelpCSVScraper

  EXPECTED_FILE_HEADER="business_name,city,state_abbrev"

  class YelpCSVScraperError < StandardError
  end

  def self.scrape_csv(txt_file)
    businesses = []
    past_first_line = false

    File.read(Rails.root.join txt_file).each_line do |line|

      unless past_first_line
        if process_line(line) != process_line(EXPECTED_FILE_HEADER)
          raise YelpCSVScraperError, "Your file requires a proper header row with #{EXPECTED_FILE_HEADER}"
        end
        past_first_line = true
        next
      end

      businesses << process_line(line)

    end

    businesses.each do |business|
      b = YelpGemWrapper.find_business(
        location: business[1] + ", " + business[2],
        term: business[0]
      )
    end
    return businesses
  end

end
