# LineLog

LineLog is built to help you have customs logs in sinatra(should support any rack application but it is not tested for that).

LineLog welcomes contribution that would make it better and also any constructive feedback.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'line_log'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install line_log

## Usage

  Initialize LineLog with a logger of your choosing.

```
  configure do
    #implement custom logging
    logger = Logger.new("#{RAILS_ROOT}/log/#{settings.environment}.log")
    use LineLog::Customizer, logger
  end

```

  To have your own custom data:

  Form a hash with your custom data and pass it to options.

```
  before do
    LineLog::Customizer.options = {
      user: '-',
      params: request.params,
      agent: request.env['HTTP_USER_AGENT'] || '',
      protocol: request.scheme
    }
  end
  
```

## Inner Workings

LineLog::Customizer exposes a class variable(options) that you can populate with a custom hash. That hash is added to the log.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/skillvendor/sinatra_custom_logger. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

