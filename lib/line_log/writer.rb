module LineLog
  class Writer
    def self.call(message, logger)
      if logger.respond_to?(:write)
        logger.write(message)
      else
        logger.info(message)
      end
    end
  end
end