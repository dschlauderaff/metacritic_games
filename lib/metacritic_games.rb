require_relative "./metacritic_games/version"
require 'nokogiri'
require 'highline'
require_relative './cli'

module MetacriticGames::Concerns
end

require_relative './concerns/persistable'
require_relative './concerns/findable'
require_relative './concerns/nameable'
require_relative './platform'
require_relative './game'
