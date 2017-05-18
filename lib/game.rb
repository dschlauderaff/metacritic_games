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

  def initialize
    self.platform = []
    self.url = {}
    self.genre = []
    self.metascore = {}
    self.user_score = {}
  end

  def add_platform(platform)
    platform.add_game(self) unless platform.games.include?(self)
    self.platform << platform unless self.platform.include?(platform)
  end

  def add_genre(genre)
    genre.add_game(self) unless genre.games.include?(self)
    self.genre << genre unless self.genre.include?(genre)
  end

# creates the game object based on the array passed in from the controller. once the game is created, it scrapes it calls the scraper to scrape it's platform-specific page, then assigns the values and creates genre objects based off scrape data
  def self.create_games(game_array)
    game_array.each do |game|
      MetacriticGames::CLI.progressbar.increment
      if game[:platform] == "XONE"               #metacritic naming for the xboxone does not follow standard pattern
        platform = MetacriticGames::Platform.all.find {|platform| platform.name == "Xbox One"}

        game.tap do |new_game|
          new_game = self.find_or_create_by_name(game[:name])
          new_game.add_platform(platform)
          new_game.url[:"#{game[:platform]}"] = game[:url]
          MetacriticGames::Scraper.scrape_game(new_game.url[:XONE]).each do |key,value|
            if value.is_a? Array
              value.each do |genre|
                new_genre = MetacriticGames::Genre.create_genre(genre)
                new_game.add_genre(new_genre)
              end
            elsif value.fetch(:platform) == "tbd"
              value[:platform] = "currently unavailable"
              new_game.send(("#{key}="), value)
            elsif value.fetch(:platform) == ""
              value[:platform] = "currently unavailable"
              new_game.send(("#{key}="), value)
            else
              new_game.send(("#{key}="), value)
            end
          end
          score_by_platform(new_game, platform)
        end
      elsif game[:platform] == "WIIU"               #metacritic naming for the wii u does not follow standard pattern
        platform = MetacriticGames::Platform.all.find {|platform| platform.name == "Wii U"}

        game.tap do |new_game|
          new_game = self.find_or_create_by_name(game[:name])
          new_game.add_platform(platform)
          new_game.url[:"#{game[:platform]}"] = game[:url]
          MetacriticGames::Scraper.scrape_game(new_game.url[:WIIU]).each do |key,value|
            if value.is_a? Array
              value.each do |genre|
                new_genre = MetacriticGames::Genre.create_genre(genre)
                new_game.add_genre(new_genre)
              end
            elsif value.fetch(:platform) == "tbd"
              value[:platform] = "currently unavailable"
              new_game.send(("#{key}="), value)
            elsif value.fetch(:platform) == ""
              value[:platform] = "currently unavailable"
              new_game.send(("#{key}="), value)
            else
              new_game.send(("#{key}="), value)
            end
          end
          score_by_platform(new_game, platform)
        end
      elsif game[:platform] == "VITA"               #metacritic naming for the ps vita does not follow standard pattern
        platform = MetacriticGames::Platform.all.find {|platform| platform.name == "PS Vita"}

        game.tap do |new_game|
          new_game = self.find_or_create_by_name(game[:name])
          new_game.add_platform(platform)
          new_game.url[:"#{game[:platform]}"] = game[:url]
          MetacriticGames::Scraper.scrape_game(new_game.url[:VITA]).each do |key,value|
            if value.is_a? Array
              value.each do |genre|
                new_genre = MetacriticGames::Genre.create_genre(genre)
                new_game.add_genre(new_genre)
              end
            elsif value.fetch(:platform) == "tbd"
              value[:platform] = "currently unavailable"
              new_game.send(("#{key}="), value)
            elsif value.fetch(:platform) == ""
              value[:platform] = "currently unavailable"
              new_game.send(("#{key}="), value)
            else
              new_game.send(("#{key}="), value)
            end
          end
          score_by_platform(new_game, platform)
        end
      else
        platform = MetacriticGames::Platform.all.find {|platform| platform.name == game[:platform]}

        game.tap do |new_game|
          new_game = self.find_or_create_by_name(game[:name])
          new_game.add_platform(platform)
          new_game.url[:"#{game[:platform]}"] = game[:url]
          MetacriticGames::Scraper.scrape_game(new_game.url[:"#{platform.name}"]).each do |key,value|
            if value.is_a? Array
              value.each do |genre|
                new_genre = MetacriticGames::Genre.create_genre(genre)
                new_game.add_genre(new_genre)
              end
            elsif value.fetch(:platform) == "tbd"
              value[:platform] = "currently unavailable"
              new_game.send(("#{key}="), value)
            elsif value.fetch(:platform) == ""
              value[:platform] = "currently unavailable"
              new_game.send(("#{key}="), value)
            else
              new_game.send(("#{key}="), value)
            end
          end
          score_by_platform(new_game, platform)
        end
      end
    end
  end

# changes the key of the metacritic and user scores from the generic ":platform" to a unique platform.name key required for multiplatform releases
  def self.score_by_platform(game, platform)
    game.metascore[platform.name.to_sym] = game.metascore.delete(:platform)
    game.user_score[platform.name.to_sym] = game.user_score.delete(:platform)
  end
end
