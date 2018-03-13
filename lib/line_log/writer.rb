module LineLog
  class Writer
    def self.call(event, status, began_at, logger)
      binding.remote_pry
      data = LineLog::RequestDataExtractor.call(event, status, began_at)
      formatted_message = LineLog::Customizer.formatter.call(data)

      # Standard library logger doesn't support write but it supports << which actually
      # calls to write on the log device without formatting
      if logger.respond_to?(:write)
        logger.write(formatted_message)
      elsif logger.respond_to?(:info)
        logger.info(formatted_message)
      else
        logger << formatted_message
      end
    end
  end
end