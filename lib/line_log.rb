require 'line_log/version'
require 'line_log/writer'
require 'line_log/request_data_extractor'
require 'line_log/formatters/key_value'


class LineLog
  mattr_accessor :custom_options
  mattr_accessor :formatter


  def initialize(app, logger=nil, formatter=nil)
    @app = app
    @logger = logger
    @formatter = formatter
  end

  # making it thread safe. Visit https://github.com/cerner/gc_stats/issues/3 for more info about this
  def call(event)
    dup._call(event)
  end

  def _call(event)
    began_at = Time.now
    @status, @headers, @response = @app.call(event)

    binding.remote_pry
    Writer.log(event, @status, began_at, @logger)
  end
end
