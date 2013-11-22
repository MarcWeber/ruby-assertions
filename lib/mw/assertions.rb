# encoding: UTF-8

class NilClass
  def assert_nil; self; end
  def assert_not_nil; raise "non nil value expected"; end
end

class Symbol
  def assert_sym; self; end
end

class BasicObject
  def assert_nil; raise "nil expected"; end
  def assert_not_nil; self; end
  def assert_sym; raise "symbol expected, but got #{self}"; end
  def assert_instance_of(clazz); raise "instance of #{clazz} expected" unless self.instance_of? clazz; self; end
  def assert_condition(&blk)
    raise "condition failed" unless blk.call(self)
  end
end

class Hash
  def assert_has_key(k)
    raise "key #{k} expected" unless self.include? k
    self
  end
end

class Array
  def duplicates
    seen = Set.new
    dups = Set.new
    self.each do |v|
      if seen.include? v
        dups << v
      end
      seen << v
    end
    dups
  end

  def assert_no_duplicates(msg = "duplicate elements ELEMENTS found")
    dups = self.duplicates
    raise msg.gsub('ELEMENTS', dups.inspect) unless dups.empty?
  end
end
