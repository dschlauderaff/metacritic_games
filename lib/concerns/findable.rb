module MetacriticGames::Concerns::Findable

  module ClassMethods
    # Search class @@all array for object name
    def find_by_name(name)
      self.all.detect {|item| item.name == name}
    end

    # If find_by_name returns nil, create a new instance of the class with name argument
    def find_or_create_by_name(name)
      if self.find_by_name(name) == nil
        self.create(name)
      else
        self.find_by_name(name)
      end
    end
  end
end
