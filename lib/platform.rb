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

  # def save
  #   self.class.all << self
  # end

  def self.create_platforms
    ps4 = self.new
    ps4.name = "PS4"
    ps4.games = ["test 1", "test 2", "test 3"]
    ps4.developers = []
    ps4.save

    xbox = self.new
    xbox.name = "Xbox One"
    xbox.games = []
    xbox.developers = []
    xbox.save

    switch = self.new
    switch.name = "Switch"
    switch.games = []
    switch.developers = []
    switch.save

    pc = self.new
    pc.name = "PC"
    pc.games = []
    pc.developers = []
    pc.save

    wii = self.new
    wii.name = "Wii U"
    wii.games = []
    wii.developers = []
    wii.save

    ds = self.new
    ds.name = "3DS"
    ds.games = []
    ds.developers = []
    ds.save

    ps_vita = self.new
    ps_vita.name = "PS Vita"
    ps_vita.games = []
    ps_vita.developers = []
    ps_vita.save

    ios = self.new
    ios.name = "IOS"
    ios.games = []
    ios.developers = []
    ios.save

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
