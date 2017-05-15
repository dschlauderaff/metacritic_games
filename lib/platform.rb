class MetacriticGames::Platform

  extend MetacriticGames::Concerns::Nameable::ClassMethods
  extend MetacriticGames::Concerns::Findable::ClassMethods
  extend MetacriticGames::Concerns::Persistable::ClassMethods
  include MetacriticGames::Concerns::Persistable::InstanceMethods

  attr_accessor :name, :games, :developers

  @@all = []

  def self.all
    @@all
  end

  def initialize
    self.games = []
  end

  def self.create_platforms(platform_array)
    # platform_array = MetacriticGames::Scraper.scrape_platform
    platform_array.each do |platform|
      self.find_or_create_by_name(platform)
    end
    self.all
  end

  def add_game(game)
    game.platform = self if game.platform == nil
    self.games << game unless self.games.include?(game) == true
  end

  def genres
    self.games.collect {|game| game.genre}.uniq
  end

end
