class MetacriticGames::Platform

  # extend MetacriticGames::Concerns::Nameable::ClassMethods
  # extend MetacriticGames::Concerns::Findable::ClassMethods
  # extend MetacriticGames::Concerns::Persistable::ClassMethods
  # include MetacriticGames::Concerns::Persistable::InstanceMethods

  attr_accessor :name, :games, :developers

  @@all = []

  def self.all
    @@all
  end

  ps4 = Platform.new
  ps4.name = "PS4"
  ps4.games = []
  ps4.developers = []


end
