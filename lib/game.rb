class MetacriticGames::Game

  extend MetacriticGames::Concerns::Nameable::ClassMethods
  extend MetacriticGames::Concerns::Findable::ClassMethods
  extend MetacriticGames::Concerns::Persistable::ClassMethods
  include MetacriticGames::Concerns::Persistable::InstanceMethods

  attr_accessor :name, :genre, :metascore, :user_score, :platform, :url

  @@all = []

  def self.all
    @@all
  end

  # def save
  #   self.class.all << self
  # end

  def initialize
    self.platform = []
    self.url = {}
    self.genre = []
    self.metascore = {}
    self.user_score = {}
  end

  def add_platform(platform)
    # binding.pry
    platform.add_game(self) unless platform.games.include?(self)
    self.platform << platform unless self.platform.include?(platform)
  end

  # def genre= (name)
  #   @genre = name
  #   genre.add_game(self) unless self.genre == nil
  # end

  def developer= (name)
    self.developer = name
    developer.add_game(self) unless self.developer == nil
  end

  def self.create_games(game_array)
    # binding.pry
    game_array.each do |game|
      # binding.pry
      if game[:platform] == "XONE"               #metacritic naming for the xboxone does not follow standard pattern
        platform = MetacriticGames::Platform.all.find {|platform| platform.name == "Xbox One"}

        game.tap do |new_game|
          new_game = self.find_or_create_by_name(game[:name])
          # binding.pry
          new_game.add_platform(platform)
          new_game.url[:"#{game[:platform]}"] = game[:url]
        end
      elsif game[:platform] == "WIIU"               #metacritic naming for the wii u does not follow standard pattern
        platform = MetacriticGames::Platform.all.find {|platform| platform.name == "Wii U"}

        game.tap do |new_game|
          new_game = self.find_or_create_by_name(game[:name])
          # binding.pry
          new_game.add_platform(platform)
          new_game.url[:"#{game[:platform]}"] = game[:url]
        end
      elsif game[:platform] == "VITA"               #metacritic naming for the ps vita does not follow standard pattern
        platform = MetacriticGames::Platform.all.find {|platform| platform.name == "PS Vita"}

        game.tap do |new_game|
          new_game = self.find_or_create_by_name(game[:name])
          # binding.pry
          new_game.add_platform(platform)
          new_game.url[:"#{game[:platform]}"] = game[:url]
        end
      else
        platform = MetacriticGames::Platform.all.find {|platform| platform.name == game[:platform]}

        game.tap do |new_game|
          new_game = self.find_or_create_by_name(game[:name])
          # binding.pry
          new_game.add_platform(platform)
          new_game.url[:"#{game[:platform]}"] = game[:url]
        end
      end
    end
  end
end
