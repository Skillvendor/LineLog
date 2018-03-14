module LineLog
  class Writer
    def self.call(message_builder=LineLog::MessageBuilder.new, logger)
      formatted_message = message_builder.call
      
      # Standard library logger doesn't support write but it supports << which actually
      # calls to write on the log device without formatting
      if logger.respond_to?(:write)
        logger.write(formatted_message)
      else
        logger.info(formatted_message)
      end
    end
  end
end