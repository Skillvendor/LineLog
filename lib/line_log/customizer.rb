module LineLog
  class Customizer
    mattr_accessor :options
    mattr_accessor :formatter

    def initialize(app, logger=nil, formatter=LineLog::Formatters::KeyValue.new)
      @app = app
      @logger = logger
      set_formatter(formatter)
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

    private

    def set_formatter(formatter)
      LineLog::Customizer.formatter = formatter
    end 
  end
end