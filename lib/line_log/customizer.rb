module LineLog
  class Customizer
    class << self; attr_accessor :formatter, :data end

    def initialize(app, logger=nil, formatter=LineLog::Formatters::KeyValue.new)
      @app = app
      @logger = logger
      self.class.formatter = formatter
    end

    # making it thread safe. Visit https://github.com/cerner/gc_stats/issues/3 for more info about this
    def call(event)
      dup._call(event)
    end

    def _call(event)
      began_at = Time.now
      @status, @headers, @response = @app.call(event).tap {
        message = LineLog::MessageBuilder.new(event, @status, began_at).call
        LineLog::Writer.call(message, @logger)
      }
    end
  end
end