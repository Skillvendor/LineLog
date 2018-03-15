module LineLog
  class Writer
    def self.call(message, logger)
      logger.info(message)
    end
  end
end