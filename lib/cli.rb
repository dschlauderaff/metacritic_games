# CLI controller
class MetacriticGames::CLI

  attr_accessor :cli, :platform, :url

  def call
    self.cli = HighLine.new
    self.url = "http://www.metacritic.com/browse/games/release-date/new-releases/all/date"
    list_platforms
  end

  def list_platforms
    platform_array = MetacriticGames::Scraper.scrape_platform(self.url)
    MetacriticGames::Platform.create_platforms(platform_array)
    @platform = MetacriticGames::Platform.all
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
    game_array = MetacriticGames::Scraper.scrape_new_releases
    # binding.pry
    url_array = MetacriticGames::Scraper.scrape_new_release_url
    binding.pry
    MetacriticGames::Game.create_games_by_platform(platform, game_array)
    cli.say "These are Metacritic's newest releases for #{platform.name}:"
    # binding.pry
    self.cli.choose do |menu|
      menu.index = :number
      menu.index_suffix = ")"
      menu.prompt = "Please choose the game you want more information on:"
    # binding.pry
      platform.games.each do |game|
        menu.choice :"#{game.name}" do cli.say "Game Details" end
      end
      menu.choice :"Return to platform list" do list_platforms end
      menu.choice :Exit do goodbye end
    end
  end

  def game_details(game)
  end

  def goodbye
    puts "See you next time!"
    exit
  end


end
