# CLI controller
class MetacriticGames::CLI

  attr_accessor :cli

  def call
    self.cli = HighLine.new

    list_platforms
    binding.pry
    menu
  end

  def list_platforms

    self.cli.choose do |menu|
      menu.index = :letter
      menu.index_suffix = ")"
      menu.prompt = "Please choose the platform you want new release info for:"
      menu.choice :PS4 do cli.say("You chose PS4") end
    end

# # here doc
#     puts <<-DOC
#       1. PS4
#       2. XBOX ONE
#       3. SWITCH
#       4. PC
#       5. WII U
#       6. 3DS
#       7. PS VITA
#       8. IOS
#       DOC
  end

  def menu
    puts "Enter the number for the platform you want to see new releases:"
  end
end
