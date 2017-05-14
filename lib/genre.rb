class MetacriticGames::Genre

  extend Concerns::Nameable::ClassMethods
  extend Concerns::Findable::ClassMethods
  extend Concerns::Persistable::ClassMethods
  include Concerns::Persistable::InstanceMethods

  @@all = []

  def self.all
    @@all
  end


end
