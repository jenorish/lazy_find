# LazyFind

## Description
   
    Simplified the first,last,take methods in ActiveRecord.
    So instead of using where and first, you can directly use first.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lazy_find'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lazy_find

## Usage

  Simplified the first,last,take methods in ActiveRecord.

        Find the first record (or first N records if a parameter is supplied).

   Old Syntax:

        Person.where(:email => "jenorish@gmail").first

   New Syntax:

        Person.first(:email => "jenorish@gmail")

        # returns the first three objects fetched by SELECT * FROM people WHERE email= 'jenorish@gmail.com'  ORDER BY people.id LIMIT 3
 

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jenorish/lazy_find. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LazyFind project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jenorish/lazy_find/blob/master/CODE_OF_CONDUCT.md).
