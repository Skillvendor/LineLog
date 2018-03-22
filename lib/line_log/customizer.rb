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
      @app.call(event).tap do |request_data|
        request_status = request_data.first # status is on the first position, it is an array
        message = LineLog::MessageBuilder.new(event, request_status, began_at).call
        LineLog::Writer.call(message, @logger)
      end
    end
  end
end