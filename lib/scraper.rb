class MetacriticGames::Scraper

  def self.doc= (name)
    @@doc = name
  end

  def self.doc
    @@doc
  end

  #scrapes page for platforms and sets the class url variable to avoid scraping the index page a second time, returns the platform array to CLI
  def self.scrape_platform(url)
    self.doc = Nokogiri::HTML(open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,  'User-Agent' => 'safari'))
    self.doc.css(".platform_item").collect do |platform|
      MetacriticGames::CLI.progressbar.increment
      platform.text
    end
  end

  #returns the array of game information hashes from the index page
  def self.scrape_new_releases
    self.doc.css(".product_wrap .product_title").collect do |game|
      MetacriticGames::CLI.progressbar.increment
      if game.text.include? ?(
        game_hash = {
          :name => self.get_title_text(game),
          :platform => self.get_title_platform(game),
          :url => self.get_title_url(game)
        }
      end
    end
  end

  # method to clean up text scrape
  def self.get_title_text(game)
      game.text.gsub(/\(([^)]+)\)/, "").strip
  end

  # method to clean up text scrape for platform
  def self.get_title_platform(game)
    game.text.slice(/\(([^)]+)\)/).delete"()"
  end

  # method to convert relative url on index page to absolute url
  def self.get_title_url(game)
    absolute = "http://www.metacritic.com"
    absolute + game.css("a").attribute("href").value
  end

  # scrape individual page and return scores and genre listings
  def self.scrape_game(url)
    doc = Nokogiri::HTML(open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,  'User-Agent' => 'safari'))
    genre_array = doc.css("li.summary_detail.product_genre").css("span.data").collect do |genre|
      MetacriticGames::CLI.progressbar.increment
      genre.text
    end
    details_hash = {
      :metascore => {
        :platform => doc.css("div.metascore_w.xlarge").text
      },
      :user_score => {
        :platform => doc.css(".metascore_anchor .user").text
      },
      :genre => genre_array
    }
  end
end
