module LineLog
  class Customizer
    class << self; attr_accessor :formatter end
    class << self; attr_accessor :options end

    def initialize(app, logger=nil, formatter=LineLog::Formatters::KeyValue.new)
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

      LineLog::Writer.call(event, @status, began_at, @logger)
    end
  end
end