require 'io/access_lazy/version'

# a class of the Ruby core library
class IO; end

# AccessLazy class
class IO::AccessLazy
  # @param [IO] io
  # @param [Hash] options
  def initialize (io, options={})
    set_io! (io)
    set_option! (options)
  end

  attr_reader :io
  attr_reader :seek_method

  # @param [Fixnum,Range] index
  # @param [Boolean] cache
  def [] (index, cache=nil)
    case index
    when Fixnum
      io_init! unless cache
      seek(index)
    when Range
      unless check_range(index)
        raise ArgumentError, 'require IO object or String'
      end
      io_init!
      index.map{|i| self[i, true] }
    end
  end

  # @param [Fixnum] index
  # @return [String]
  def seek (index)
    @point.upto(index){ |i|
      tmp = io.gets
      @point += 1
      return tmp if index == i
    }
  end

  # @param [IO] io
  def set_io! (io)
    case io
    when IO
      @io = io
    when String
      @io = StringIO.new(io)
    else
      raise ArgumentError, 'index is invalid range'
    end
  end

  # @param [Hash] options
  def set_option! (options)
    # Set IO seek method
    @seek_method = options[:seek_method] || :gets
  end

  # @note Side-Effect!
  def cache_init!
    @cache = []
    return true
  end

  # @note Side-Effect!
  def io_init!
    @point = io.rewind
    return true
  end

  # @param [Range] range
  # @return [Boolean]
  # @note This is a alias method.
  # @see AccessLazy.check_range
  def check_range (range); self.class.check_range(range); end

  # @param [Range] range
  # @return [Boolean]
  def self.check_range (range)
    lower = range.begin
    upper = range.end
    (lower >= 0) && ((lower <= upper) && (upper >= 0) || (upper == -1))
  end
end
