class MetacriticGames::Scraper

  def self.doc= (name)
    @@doc = name
  end

  def self.doc
    @@doc
  end

  def self.scrape_platform(url)
    # url = "http://www.metacritic.com/browse/games/release-date/new-releases/all/date"
    self.doc = Nokogiri::HTML(open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,  'User-Agent' => 'safari'))
    self.doc.css(".platform_item").collect do |platform|
      platform.text
    end
  end

  def self.scrape_new_releases
    # url = "http://www.metacritic.com/browse/games/release-date/new-releases/all/date"
    # doc = Nokogiri::HTML(open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,  'User-Agent' => 'safari'))
    self.doc.css(".product_wrap .product_title").collect do |game|
      game.text.strip
    end
  end

  def self.scrape_new_release_url
    binding.pry
    self.doc.css(".product_wrap a").attribute("href").value



  end
# Nokogiri::HTML(open(self.url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,  'User-Agent' => 'safari'))
end
