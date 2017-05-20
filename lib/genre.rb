class MetacriticGames::Genre

  extend MetacriticGames::Concerns::Nameable::ClassMethods
  extend MetacriticGames::Concerns::Findable::ClassMethods
  extend MetacriticGames::Concerns::Persistable::ClassMethods
  include MetacriticGames::Concerns::Persistable::InstanceMethods

  attr_accessor :name, :games

  @@all = []

  def initialize
    self.games = []
  end

  def self.all
    @@all
  end

  def self.create_genre(genre)
    MetacriticGames::CLI.progressbar.increment
    self.find_or_create_by_name(genre)
  end

  def add_game(game)
    game.genre << self unless game.genre.include? self
    self.games << game unless self.games.include?(game)
  end
end
