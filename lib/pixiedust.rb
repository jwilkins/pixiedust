if RUBY_VERSION && RUBY_VERSION =~ /^1.8/
  require 'digest'
end
begin
  require 'openssl'
rescue LoadError
  require 'OpenSSL' # OS X
end

class PixieDust
  VERSION = '0.0.11'
end

class UrlDust
  def UrlDust.normalize(s)
    # lowercase
    ns = s.downcase
    # remove spaces
    ns = ns.gsub(/\s/, '')
    # 0 -> o
    ns = ns.gsub(/0/, 'o')
    # 'dot' -> .
    ns = ns.gsub(/dot/, '.')
    ns
  end

  def UrlDust.url_like?(s)
    res = UrlDust.normalize(s) =~ /([\w]+.)+[(net|org|com)]/
    return true if res
    res
  end
end

class Object
  # from Chris Wanstrath http://ozmm.org/posts/try.html
  # @person ? @person.name : nil vs  @person.try(:name)
  def try(method)
    send method if respond_to? method
  end
end

class HashDust
  def HashDust.md5_file(filename)
    digest = Digest::MD5.new
    File.open(filename, "rb") { |f|
      digest.update f.read(32768) until f.eof
    }
    return digest.hexdigest
  end
end

class RandomDust
  # XXX: Do something to make sure that OpenSSL is using a real RNG
  def between(min, max)
    RandomDust.between(min, max)
  end

  def RandomDust.bits_needed(val)
    return val.to_s(2).length
  end

  def RandomDust.ubytes_needed(val)
    bits = bits_needed(val)
    bytes = bits/8
    if bits%8 > 0
      bytes += 1
    end
    return bytes
  end

  def RandomDust.between(min, max)
    if min == max then raise "min == max in RandomDust.between"; end
    if min > max then raise "min > max in RandomDust.between"; end

    value = 0
    attempts = 0
    range = max - min
    byte_count = RandomDust.ubytes_needed(range)
    uint32s = byte_count / 4
    bytes = byte_count % 4

    case bytes
    when 3
      unp = 'SC'
    when 2
      unp = 'S'
    when 1
      unp = 'C'
    else
      unp = ''
    end

    while true
      attempts += 1
      rand = OpenSSL::Random.random_bytes(byte_count) # XXX: grab extra to save time

      # handle single byte values specially
      # 255 & 0b0111_1111 # mask the highest bit
      if byte_count == 1
        value = rand.unpack('C').first

        bits = bits_needed(range)
        value = value & (2**bits - 1)
      elsif byte_count == 2
        value = rand.unpack('S').first

        bits = bits_needed(range)
        value = value & (2**bits - 1)
      else
        parts = rand.unpack(unp + "L"*(uint32s))
        value = parts.shift
        if bytes == 3
          p = parts.shift
          value += p << 16
        end
        parts.length.upto(uint32s - 1) { |x|
          value += parts[x] << 32 * x
        }
      end

      value += min

      unless value < min || value > max
        #open('pixiedust-attempts.txt', "a+") { |f| f << "#{attempts} needed (#{min}-#{max} range\n" }
        return value
      end
    end
  end
end

class DateDust
  def DateDust.now_stru
    str = sprintf("%d%02d%02d%02d%02d%02d%06d", Time.now.year, Time.now.month,
                  Time.now.day, Time.now.hour, Time.now.min, Time.now.sec, Time.now.usec)
  end

  def DateDust.now_str
    str = sprintf("%d%02d%02d%02d%02d%02d", Time.now.year, Time.now.month,
                  Time.now.day, Time.now.hour, Time.now.min, Time.now.sec)
  end
end

class NumberDust
  def NumberDust.nearest(val)
    factor = val.abs.to_s.length - 2
    case factor
    when -1..2
      return val
    else
      mult = (10 ** factor)
      return mult * (val/ mult)
    end
  end
end

class Integer
  def pd_nearest
    NumberDust.nearest(self)
  end
end

unless defined?(ActiveRecord)
  require 'activerecord'
end
class << ActiveRecord::Base
  def each(limit=1000, first=0)
    if first == 0
      rows = [find(:first, :limit => limit)]
    else
      rows = find(:all, :conditions => ["id > ?", first], :limit => limit)
    end
    while rows.any?
      rows.each { |record| yield record }
      rows = find(:all, :conditions => ["id > ?", rows.last.id], :limit => limit)
    end
    self
  end
end
