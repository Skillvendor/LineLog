module LineLog
  class RequestDataExtractor
    def self.call(event, status, began_at)
      extract_data_from_request(event, status, began_at)
    end

    private

    def self.extract_data_from_request(event, status, began_at)
      data = default_data(event, status, began_at)
      data.merge!(custom_data)
    end

    def self.default_data(event, status, began_at)
      {
        method: event['REQUEST_METHOD'],
        path: extract_path(event),
        format: event['HTTP_ACCEPT'],
        ip: event['HTTP_X_REAL_IP'],
        status: status,
        duration: (Time.now - began_at).round(2)
      }
    end

    def self.extract_path(event)
      path = event['REQUEST_PATH']
      index = path.index('?')
      index ? path[0, index] : path
    end
    
    def self.custom_data
      LineLog::Customizer.data || {}
    end
  end
end