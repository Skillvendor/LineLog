module LineLog
  class Customizer
    mattr_accessor :options
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

      LineLog::Writer.call(event, @status, began_at, @logger)
    end
  end
end