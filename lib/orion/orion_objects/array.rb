require 'ostruct'

class Array
  def to_orion
    self.empty? ? OpenStruct.new(success: false, count: 0, files: self) : OpenStruct.new(success: true, count: self.size, files: self)
  end
end
