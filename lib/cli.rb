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
    cli.say "#{game.name} has a metacritic score of #{game.metascore[platform.name.to_sym]} and a current user score of: #{game.user_score[platform.name.to_sym]}."
    # if game game.user_score.has_value?("")
    #   cli.say "The user score for this game is currently unavaialble"
    # else
    #   cli.say "The user score for this game is #{game.user_score[platform.name.to_sym]}"
    # end
    cli.say "It is classified to the following genres:"
    game.genre.each {|genre| cli.say "#{genre.name}"}


    starship_troopers
    cli.say "#{game.url[platform.name.to_sym]}"



    binding.pry
    self.cli.choose do |menu|
      menu.index = :number
      menu.index_suffix = ")"
      menu.prompt = "Which menu would you like to return to:"
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
  end


end
