class MetacriticGames::Game

  extend MetacriticGames::Concerns::Nameable::ClassMethods
  extend MetacriticGames::Concerns::Findable::ClassMethods
  extend MetacriticGames::Concerns::Persistable::ClassMethods
  include MetacriticGames::Concerns::Persistable::InstanceMethods

  attr_accessor :name, :developer, :platform, :genre, :metascore, :user_score, :game_summary, :critic_reviews, :user_reviews, :release_date

  @@all = []

  def self.all
    @@all
  end

  # def save
  #   self.class.all << self
  # end

  def initialize(name)
    self.name = name
    self.genre = []

  end

  def platform= (name)
    self.platform = name
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


end
