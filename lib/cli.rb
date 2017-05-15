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
      menu.choice :PS4 do list_games(@platform[0]) end
      menu.choice :"Xbox One" do list_games(@platform[1]) end
      menu.choice :Switch do list_games(@platform[2]) end
      menu.choice :PC do list_games(@platform[3]) end
      menu.choice :"Wii U" do list_games(@platform[4]) end
      menu.choice :"3DS" do list_games(@platform[5]) end
      menu.choice :"PS Vita" do list_games(@platform[6]) end
      menu.choice :IOS do list_games(@platform[7]) end
      menu.choice :List do list_platforms end
      menu.choice :Exit do goodbye end

    end
  end

  def list_games(platform)
    cli.say "These are Metacritic's newest releases for #{platform.name}:"
    self.cli.choose do |menu|
      menu.index = :number
      menu.index_suffix = ")"
      menu.prompt = "Please choose the game you want more information on:"
      menu.choice :game_1 do cli.say "Game 1 info" end
      menu.choice :game_2 do cli.say "Game 2 info" end
      menu.choice :game_3 do cli.say "Game 3 info" end
      menu.choice :game_4 do cli.say "Game 4 info" end
      menu.choice :game_5 do cli.say "Game 5 info" end
      menu.choice :"Return to platform list" do list_platforms end
      menu.choice :Exit do goodbye end
    end
  end

  def goodbye
    puts "See you next time!"
    exit
  end


end
