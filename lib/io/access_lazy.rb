require 'io/access_lazy/version'

class IO
  class AccessLazy
    ERROR_INDEX_IS_INVALID_RANGE = 'index is invalid range'

    # @param [IO] io
    def initialize (io, opt={})
      case io
      when IO
        @io = io
      when String
        @io = StringIO.new(io)
      else
        raise ArgumentError 'require IO Object'
      end
      @offset = 0
    end

    # @param [Fixnum] index
    def [] (index, cache=nil)
      case index
      when Fixnum
      when Range
        if check_range(index)
        else
          raise ArgumentError, ERROR_INDEX_IS_INVALID_RANGE
        end
      end
    end

    # @param [Range] range
    # @return [Boolean]
    def check_range (range); self.class.check_range(range); end

    # @param [Range] range
    # @return [Boolean]
    def self.check_range (range)
      lower = range.begin
      upper = range.end
      (lower >= 0) && ((lower <= upper) && (upper >= 0) || (upper == -1))
    end
  end
end
