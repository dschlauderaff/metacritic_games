class Developer

  extend Concerns::Findable::ClassMethods
  extend Concerns::Persistable::ClassMethods
  include Concerns::Persistable::InstanceMethods

  # extend Concerns::Findable
  # extend Concerns::Persistable::ClassMethods
  # extend Concerns::Nameable::ClassMethods
  # include Concerns::Persistable::InstanceMethods

end
