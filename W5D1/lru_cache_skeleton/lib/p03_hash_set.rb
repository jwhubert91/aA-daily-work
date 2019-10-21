class HashSet
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless self.include?(key)
      self[key] << key
      self.count += 1
    end
  end
  
  def include?(key)
    @store.each do |bucket|
      return true if bucket.include?(key)
    end
    false
  end

  def remove(key)
    unless self.include?(key)
      self.each do |bucket|
        if bucket.include?(key)
          bucket.pop
          self.count -= 1
        end
      end
    end
  end

  private

  def [](key)
    @store[(key.hash % @store.length)]
  end

  def num_buckets
    @store.length
  end

  def resize!
  end
end
