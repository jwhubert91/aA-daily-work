class Integer
  # Integer#hash already implemented for you
end

class Array

  def hash
    return 0.hash if self.empty?
    hash_sum = 0
    self.each_with_index do |ele,idx|
      hash_sum += (ele.hash + idx.hash)
    end
    hash_sum
  end

end

class String

  def hash
    array_of_chars = self.split("")
    array_of_chars.map!.with_index do |ele,idx|
      (ele.ord.hash + idx.hash)
    end
    array_of_chars.join("").to_i
  end

end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    
  end
end
