class MetacriticGames::Scraper

  def self.scrape_platform
    url = "http://www.metacritic.com/browse/games/release-date/new-releases/all/date"
    doc = Nokogiri::HTML(open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,  'User-Agent' => 'safari'))
    doc.css(".platform_item").collect do |platform|
      platform.text
    end
  end

  def self.scrape_new_releases
    url = "http://www.metacritic.com/browse/games/release-date/new-releases/all/date"
    doc = Nokogiri::HTML(open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,  'User-Agent' => 'safari'))
    doc.css(".product_wrap .product_title").collect do |game|
      game.text.strip
    end
  end
# Nokogiri::HTML(open(self.url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,  'User-Agent' => 'safari'))
end
