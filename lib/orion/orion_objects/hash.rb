require 'ostruct'

class Hash
  def to_orion
    OpenStruct.new(self)
  end
end