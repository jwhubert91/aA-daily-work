require "Set"
require "byebug"

class MaxIntSet
  attr_reader :max, :store

  def initialize(max)
    @max = max
    @store = Array.new(@max,false)
  end

  def insert(num)
    if (num > @max) || (num < 0 )
      raise "Out of bounds"
    end
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_accessor :store
  
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    idx = num % num_buckets
    @store[idx]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :num_buckets, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    unless self.include?(num)
      resize! if (count == num_buckets)
      @store[count] << num 
      self.count += 1
    end
  end

  def remove(num)
    self.store.each do |bucket|
      if bucket[0] == num
        bucket.pop
        self.count -= 1
      end
    end
  end

  def include?(num)
    @store.each do |bucket|
      return true if bucket.include?(num)
    end
    false
  end

  private

  def [](num)
    # @store[]
  end

  def num_buckets
    @store.length
  end

  def resize!
    num_buckets.times do
      self.store << Array.new
    end
    num_buckets = self.store.length
  end

end
