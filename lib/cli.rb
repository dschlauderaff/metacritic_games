# CLI controller
class MetacriticGames::CLI



  attr_accessor :cli, :platform, :url, :genre

  def self.progressbar
    @@progressbar
  end

# call gets everything running. sets the url for scraping main page, initializes highline for menus and progressbar for loading animation, creates platforms and games, then calls the first menu list
  def call
    self.cli = HighLine.new
    self.url = "http://www.metacritic.com/browse/games/release-date/new-releases/all/date"
    @@progressbar = ProgressBar.create(:starting_at => 20, :total => nil)
    MetacriticGames::Platform.create_platforms(build_platform_array)
    MetacriticGames::Game.create_games(build_game_array)
    @platform = MetacriticGames::Platform.all
    @genre = MetacriticGames::Genre.all
    list_platforms
  end

# scrapes and returns the platforms listed on the new release page
  def build_platform_array
    MetacriticGames::Scraper.scrape_platform(self.url)
  end

# scrapes the games listed on the new release page
  def build_game_array
    MetacriticGames::Scraper.scrape_new_releases.reject {|game| game == nil}
  end


  def list_platforms
    puts "\nPlatforms".bold.underline
    self.cli.choose do |menu|
      menu.index = :number
      menu.index_suffix = ")"
      menu.prompt = "Please choose the platform you want new release info for:"
      self.platform.each do |platform|
        menu.choice :"#{platform.name}" do list_games(platform) end
      end
      menu.choice :"List Platforms" do list_platforms end
      menu.choice :Exit do goodbye end

    end
  end

#lists games based on the platform passed in and creates the menu option for further game details
  def list_games(platform)
    cli.say "Metacritic's newest releases for #{platform.name}:"
    self.cli.choose do |menu|
      menu.index = :number
      menu.index_suffix = ")"
      menu.prompt = "Please choose the game you want more information on:"
      platform.games.each do |game|
        menu.choice :"#{game.name}" do game_details(game, platform) end
      end
      menu.choice :"Return to platform list" do list_platforms end
      menu.choice :Exit do goodbye end
    end
  end

#gives greater detail on a particular game and a link to access more
  def game_details(game, platform)
    cli.say "#{game.name} has a metacritic score of #{game.metascore[platform.name.to_sym]} and a current user score of: #{game.user_score[platform.name.to_sym]}."
    cli.say "It is classified to the following genres:"
    game.genre.each {|genre| cli.say "#{genre.name}"}
    sleep 1
    starship_troopers
    game_url(game, platform)
    self.cli.choose do |menu|
      menu.index = :number
      menu.index_suffix = ")"
      menu.prompt = "Which menu would you like to return to?"
      menu.choice :"Return to games list" do list_games(platform) end
      menu.choice :"Return to platform list" do list_platforms end
      menu.choice :Exit do goodbye end
    end
  end

  def goodbye
    puts "See you next time!"
    exit
  end

  def starship_troopers
    msg = "Would you like to know more?".bold

    5.times do
      print "\r#{msg}"
      sleep 0.5
      print "\r#{ ' ' * msg.size}"
      sleep 0.5
    end
    puts "\nClick the link for more details".bold
  end

# since games can have multiple platforms, logic to select the correct link for the specifi
  def game_url(game, platform)
    if platform.name == "Xbox One"
      puts "#{game.url[:XONE]}".colorize(:blue)
    elsif platform.name == "Wii U"
      puts "#{game.url[:WIIU]}".colorize(:blue)
    elsif platform.name == "PS Vita"
      puts "#{game.url[:VITA]}".colorize(:blue)
    else
      puts "#{game.url[platform.name.to_sym]}".colorize(:blue)
    end
  end
end
