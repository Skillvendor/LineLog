module LineLog
  class MessageBuilder
    def initialize(event, status, began_at)
      @event = event
      @status = status
      @began_at = began_at
    end

    def call
      data = LineLog::RequestDataExtractor.call(@event, @status, @began_at)
      formatted_message = LineLog::Customizer.formatter.call(data)

      formatted_message
    end
  end
end