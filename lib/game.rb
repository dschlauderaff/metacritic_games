class MetacriticGames::Game

  extend MetacriticGames::Concerns::Nameable::ClassMethods
  extend MetacriticGames::Concerns::Findable::ClassMethods
  extend MetacriticGames::Concerns::Persistable::ClassMethods
  include MetacriticGames::Concerns::Persistable::InstanceMethods

  attr_accessor :name, :developer, :genre, :metascore, :user_score, :game_summary, :critic_reviews, :user_reviews, :release_date

  attr_reader :platform

  @@all = []

  def self.all
    @@all
  end

  # def save
  #   self.class.all << self
  # end

  # def initialize(name)
  #   self.name = name
  #   self.genre = []

  # end

  def platform= (name)
    @platform = name
    platform.add_game(self) unless self.platform == nil
  end

  def genre= (name)
    self.genre = name
    genre.add_game(self) unless self.genre == nil
  end

  def developer= (name)
    self.developer = name
    developer.add_game(self) unless self.developer == nil
  end

  def self.create_games_by_platform(platform)
    game_array = MetacriticGames::Scraper.scrape_new_releases
    game_array.select! {|game| game.include? platform.name}
    game_array.collect! {|game| game.gsub("(#{platform.name})", "").strip}
    game_array.each do |game|
      game.tap do |new_game|
        game = self.find_or_create_by_name(game)
        game.platform = platform
      end
    end


  end

end
