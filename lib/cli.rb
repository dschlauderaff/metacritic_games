# CLI controller
class MetacriticGames::CLI

  attr_accessor :cli, :platform, :url

  def call
    self.cli = HighLine.new
    self.url = "http://www.metacritic.com/browse/games/release-date/new-releases/all/date"
    platform_array = MetacriticGames::Scraper.scrape_platform(self.url)
    game_array = MetacriticGames::Scraper.scrape_new_releases
    game_array.reject! {|game| game == nil}
    # binding.pry
    MetacriticGames::Platform.create_platforms(platform_array)
    MetacriticGames::Game.create_games(game_array)
    @platform = MetacriticGames::Platform.all
    # binding.pry
    # MetacriticGames::Game.all.each do |game|
    #
    # MetacriticGames::Scraper.scrape_game(game.url[:"#{platform.name}"])
    # MetacriticGames::Game.assign_details(game_array)
    list_platforms
  end

  def list_platforms
    # binding.pry
    self.cli.choose do |menu|
      menu.index = :number
      menu.index_suffix = ")"
      menu.prompt = "Please choose the platform you want new release info for:"
      self.platform.each do |platform|
        menu.choice :"#{platform.name}" do list_games(platform) end
      end
      menu.choice :List do list_platforms end
      menu.choice :Exit do goodbye end

    end
  end

  def list_games(platform)
    # binding.pry
    cli.say "These are Metacritic's newest releases for #{platform.name}:"
    # binding.pry
    self.cli.choose do |menu|
      menu.index = :number
      menu.index_suffix = ")"
      menu.prompt = "Please choose the game you want more information on:"
    # binding.pry
      platform.games.each do |game|
        menu.choice :"#{game.name}" do game_details(game, platform) end
      end
      menu.choice :"Return to platform list" do list_platforms end
      menu.choice :Exit do goodbye end
    end
  end

  def game_details(game, platform)
  end

  def goodbye
    puts "See you next time!"
    exit
  end


end
