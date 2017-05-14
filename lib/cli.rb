# CLI controller
class MetacriticGames::CLI

  attr_accessor :cli

  def call
    self.cli = HighLine.new

    list_platforms
  end

  def list_platforms

    self.cli.choose do |menu|
      menu.index = :number
      menu.index_suffix = ")"
      menu.prompt = "Please choose the platform you want new release info for:"
      menu.choice :PS4 do cli.say("List of new releases on PS4") end
      menu.choice :"XBOX ONE" do cli.say("List of new releases on XBOX ONE") end
      menu.choice :SWITCH do cli.say("List of new releases on SWITCH") end
      menu.choice :PC do cli.say("List of new releases on PC") end
      menu.choice :"WII U" do cli.say("List of new releases on WII U") end
      menu.choice :"3DS" do cli.say("List of new releases on 3DS") end
      menu.choice :"PS VITA" do cli.say("List of new releases on PS VITA") end
      menu.choice :IOS do cli.say("List of new releases on IOS") end
      menu.choice :Exit do goodbye end

    end
  end

  def goodbye
    puts "See you next time!"
    exit
  end


end
