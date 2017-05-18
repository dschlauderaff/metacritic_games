# MetacriticGames

This gem scrapes the new release page of metacritic games and returns the newest releases listed by console. Each
game can be selected to find out metacritic score, user score, game genre, and a link to the metacritic review page.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'metacritic_games'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install metacritic_games

## Usage

Run 'bin/metacritic-games', then allow the cli to scrape and create the data for use. Once the platform menu loads, you can choose a platform to
see new games, and then select a game for more information, or return to the platform menu.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dschlauderaff/metacritic_games.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
