# Faraday::Rashify

This is a Faraday middleware which turns Hashes into `Hashie::Mash::Rash` objects, using the [`rash_alt`](https://github.com/shishi/rash_alt) gem.

This very specific middleware has been extracted from the [`faraday_middleware`](https://github.com/lostisland/faraday_middleware) project.

Original code created by @mislav with contributions by @shishi.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'faraday-rashify'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install faraday-rashify

## Usage

This is a [Faraday middleware](https://lostisland.github.io/faraday/middleware/), and you need to mount it after parsing middlewares, such as `:json`.

Example:

```ruby
Faraday.new(options) do |conn|
  conn.request :json

  conn.response :rashify
  conn.response :json, content_type: /\bjson$/
  conn.response :logger, logger, bodies: true

  conn.adapter Faraday.default_adapter
end
```

That is, this middleware only acts on Ruby Hashes and Arrays and makes the Hashes in there into `Hashie::Mash::Rash` objects.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lostisland/faraday-rashify. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/lostisland/faraday-rashify/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Faraday::Rashify project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/lostisland/faraday-rashify/blob/main/CODE_OF_CONDUCT.md).
