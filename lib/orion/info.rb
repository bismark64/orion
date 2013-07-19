require "orion/orion_objects/hash"

module Orion
  class Info
    def initialize(path)
      @path ||= path
    end

    def info(*methods)
      methods = available_methods & methods
      if methods.empty?
        raise "The available methods for Orion.get_info are: #{available_methods.join(", ")}"
      else
        methods.one? ? single_method(methods.first) : find_info_from(methods).to_orion
      end
    end

    private

    def find_info_from(methods)
      Hash[methods.map { |method| [method, File.send(method, @path)] }]
    end

    def single_method(method)
      File.send(method, @path)   
    end    

    def available_methods
      [:atime, :ctime, :mtime, :ftype, :size]      
    end
  end  
end
