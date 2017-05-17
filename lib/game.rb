class MetacriticGames::Game

  extend MetacriticGames::Concerns::Nameable::ClassMethods
  extend MetacriticGames::Concerns::Findable::ClassMethods
  extend MetacriticGames::Concerns::Persistable::ClassMethods
  include MetacriticGames::Concerns::Persistable::InstanceMethods

  attr_accessor :name, :developer, :genre, :metascore, :user_score, :game_summary, :critic_reviews, :user_reviews, :release_date, :platform, :url

  @@all = []

  def self.all
    @@all
  end

  # def save
  #   self.class.all << self
  # end

  def initialize
    self.platform = []
    # self.genre = []
  end

  def add_platform(platform)
    platform.add_game(self) unless platform.games.include?(self)
    self.platform << platform unless self.platform.include?(platform)
  end

  def genre= (name)
    @genre = name
    genre.add_game(self) unless self.genre == nil
  end

  def developer= (name)
    self.developer = name
    developer.add_game(self) unless self.developer == nil
  end

  def self.create_games_by_platform(game_array, url_array)
    MetacriticGames::Platform.all.each do |platform|
      if platform.name == "Xbox One"               #metacritic naming for the xboxone does not follow standard pattern
        name_array = game_array.select {|game| game.include? "XONE"}
        name_array.collect! {|game| game.gsub("(XONE)", "").strip}
        name_array.each do |game|
          game.tap do |new_game|
            game = self.find_or_create_by_name(game)
            game.add_platform(platform)
            # binding.pry
            # game.add_game_url(url_array)
          end
        end
      else
        # binding.pry
        name_array = game_array.select {|game| game.include? platform.name}
        name_array.collect! {|game| game.gsub("(#{platform.name})", "").strip}
        name_array.each do |game|
          game.tap do |new_game|
            game = self.find_or_create_by_name(game)
            game.add_platform(platform)
            # game.add_game_url(url_array)
          end
        end
      end
    end
  end

  def add_game_url(url_array)
    binding.pry

  end

end
