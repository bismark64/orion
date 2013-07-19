require 'ostruct'

class NilClass
  def to_orion
    OpenStruct.new(success: false, count: nil, files: nil)
  end
end