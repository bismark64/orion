module Orion
  module Result
    def result(array)
      if array.nil?
        {success: false, count: nil, files: nil}
      elsif array.empty?
        {success: false, count: 0, files: []}
      else
        {success: true ,count: array.size, files: array}
      end
    end    
  end
end