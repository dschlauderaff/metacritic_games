# CLI controller
class MetacriticGames::CLI

  attr_accessor :cli

  def call
    self.cli = HighLine.new

    list_platforms
  end

  def list_platforms
    @platforms = MetacriticGames::Platform.all
    binding.pry
    self.cli.choose do |menu|
      menu.index = :number
      menu.index_suffix = ")"
      menu.prompt = "Please choose the platform you want new release info for:"
      menu.choice :PS4 do list_games("PS4") end
      menu.choice :"Xbox One" do list_games("Xbox One") end
      menu.choice :Switch do list_games("Switch") end
      menu.choice :PC do list_games("PC") end
      menu.choice :"Wii U" do list_games("Wii U") end
      menu.choice :"3DS" do list_games("3DS") end
      menu.choice :"PS Vita" do list_games("PS Vita") end
      menu.choice :IOS do list_games("IOS") end
      menu.choice :List do list_platforms end
      menu.choice :Exit do goodbye end

    end
  end

  def list_games(platform)
    cli.say "These are Metacritic's newest releases for #{platform}:"
    self.cli.choose do |menu|
      menu.index = :number
      menu.index_suffix = ")"
      menu.prompt = "Please choose the game you want more information on:"
      menu.choice :game_1 do cli.say "Game 1 info" end
      menu.choice :game_2 do cli.say "Game 2 info" end
      menu.choice :game_3 do cli.say "Game 3 info" end
      menu.choice :game_4 do cli.say "Game 4 info" end
      menu.choice :game_5 do cli.say "Game 5 info" end
      menu.choice :List do list_games(platform) end
      menu.choice :Exit do goodbye end
    end
  end

  def goodbye
    puts "See you next time!"
    exit
  end


end
