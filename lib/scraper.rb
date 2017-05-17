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
    # binding.pry
    self.doc.css(".product_wrap .product_title").collect do |game|
      # binding.pry
      if game.text.include? ?(
        game_hash = {
          :name => self.get_title_text(game),
          :platform => self.get_title_platform(game),
          :url => self.get_title_url(game)
        }
      end
    end
  end
  # name_array = game_array.select {|game| game.include? "XONE"}
  # name_array.collect! {|game| game.gsub("(XONE)", "").strip}
  # /\(([^)]+)\)/
  # def self.scrape_new_release_url
  #   # binding.pry
  #   self.doc.css(".product_wrap .product_title").collect do |url|
  #     url.css("a").attribute("href").value
  #   end
# game.css("a").attribute("href").value



  def self.get_title_text(game)
    # game.tap do |new_game|
      game.text.gsub(/\(([^)]+)\)/, "").strip
    # end
  end

  def self.get_title_platform(game)
    game.text.slice(/\(([^)]+)\)/).delete"()"
  end

  def self.get_title_url(game)
    absolute = "www.metacritic.com/game"
    absolute + game.css("a").attribute("href").value
  end


# Nokogiri::HTML(open(self.url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,  'User-Agent' => 'safari'))
end
