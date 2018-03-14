module LineLog
  class Writer
    def self.call(message_builder=LineLog::MessageBuilder.new, logger)
      formatted_message = message_builder.call
      
      if logger.respond_to?(:write)
        logger.write(formatted_message)
      else
        logger.info(formatted_message)
      end
    end
  end
end