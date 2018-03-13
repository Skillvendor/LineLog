module LineLog
  module Formatters
    class KeyValue
      def call(data)
        data.keys
          .map { |key| format(key, data[key]) }
          .join(' ')
      end

      protected

      def format(key, value)
        "#{key}=#{parse_value(key, value)}"
      end

      def parse_value(key, value)
        # Exactly preserve the previous output
        # Parsing this can be ambigious if the error messages contains
        # a single quote
        return "'#{value}'" if key == :error
        return Kernel.format('%.2f', value) if value.is_a? Float

        value
      end
    end
  end
end