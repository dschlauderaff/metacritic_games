# CLI controller
class MetacriticGames::CLI

  attr_accessor :cli, :platform

  def call
    self.cli = HighLine.new

    list_platforms
  end

  def list_platforms
    MetacriticGames::Platform.create_platforms
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
    MetacriticGames::Game.create_games_by_platform(platform)
    cli.say "These are Metacritic's newest releases for #{platform.name}:"





    self.cli.choose do |menu|
      menu.index = :number
      menu.index_suffix = ")"
      menu.prompt = "Please choose the game you want more information on:"
      platform.games.each do |game|
        menu.choice :"#{game.name}" do cli.say "Game info" end
      end

      # menu.choice :game_1 do cli.say "Game 1 info" end
      # menu.choice :game_2 do cli.say "Game 2 info" end
      # menu.choice :game_3 do cli.say "Game 3 info" end
      # menu.choice :game_4 do cli.say "Game 4 info" end
      # menu.choice :game_5 do cli.say "Game 5 info" end
      menu.choice :"Return to platform list" do list_platforms end
      menu.choice :Exit do goodbye end
    end
  end

  def goodbye
    puts "See you next time!"
    exit
  end


end
