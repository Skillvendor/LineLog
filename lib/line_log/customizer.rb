module LineLog
  class Customizer
    attr_accessor :options
    attr_accessor :formatter

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

    def self.options=(options)
      @options = options 
    end

    def self.options
      @options
    end

    def self.formatter=(formatter)
      @formatter = formatter
    end

    def self.formatter
      @formatter
    end
  end
end