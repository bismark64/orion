module Orion
  module Result
    def result(array)
      array.nil? || array.empty? ? {success: false, count: nil, files: nil} : {success: true ,count: array.size, files: array}
    end    
  end
end