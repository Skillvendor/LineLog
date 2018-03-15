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
  By default the logger will output the method, path, format, ip, status and duration of the request:

```
  I, [2018-03-15T10:52:52.344791 #188]  INFO -- : method='GET' path='/favicon.ico' format='image/webp,image/apng,image/*,*/*;q=0.8' ip='127.0.0.0' status=404 duration=2.36
```
  
  This can be overwritten by custom data.


  To have your own custom data:

  Form a hash with your custom data and pass it to data. The hash will be transformed into a string of key=value pairs separated by a space in the order they were given.

  E.g: Before every action in sinatra add custom data to our request.

```
  before do
    LineLog::Customizer.data = {
      user: '-',
      params: request.params,
      agent: request.env['HTTP_USER_AGENT'] || '',
      protocol: request.scheme,
      requester: 'John Smith'
    }
  end
  
```

  The output of this would be:
```
  I, [2018-03-15T10:52:52.344791 #188]  INFO -- : method='GET' path='/favicon.ico' format='image/webp,image/apng,image/*,*/*;q=0.8' ip='127.0.0.0' status=404 duration=0.00 user='-' params={} agent='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.86 Safari/537.36' protocol='http' requester='John Smith'
```

## Inner Workings

  LineLog::Customizer exposes a class variable(data) that you can populate with a custom hash. That hash is added to the log by calling the info method of the logger with a string that is formed from the hash given plus the default params explained above.

## Contributing

  Bug reports and pull requests are welcome on GitHub at https://github.com/skillvendor/LineLog. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

  The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

