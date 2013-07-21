require 'ostruct'

class Hash
  def to_orion
    OpenStruct.new(self)
  end

  def self.diff(hash1, hash2)
    Hash[*((hash1.size > hash2.size) ? hash1.to_a - hash2.to_a : hash2.to_a - hash1.to_a).flatten] 
  end
end