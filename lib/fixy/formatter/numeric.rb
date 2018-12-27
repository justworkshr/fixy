module Fixy
  module Formatter
    module Numeric
      #
      # Numeric Formatter
      #
      # May contain any digit from 0 through 9,
      # and is right-justified and zero-filled.
      #

      def format_numeric(input, length)
        input = input.to_s

        raise ArgumentError, "Invalid Input (only digits are accepted) (input: #{input})" unless input =~ /^\d*$/
        raise ArgumentError, "Insufficient length for provided input (input: #{input}, length: #{length}, required length: #{input.length})" if input.length > length

        input.rjust(length, '0')
      end
    end
  end
end
