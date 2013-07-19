require "orion/orion_objects/hash"
require "orion/orion_support/i18n"

module Orion
  class Info
    def initialize(path)
      @path ||= path
    end

    def info(*methods)
      methods = Info.available_methods & methods
      if methods.empty?
        raise I18n.t("errors.get_info.no_correct_methods", methods: Info.available_methods.join(", "))
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

    def self.available_methods
      [:atime, :ctime, :mtime, :ftype, :size, :absolute_path, :basename, 
        :directory?, :dirname, :executable?, :exists?, :extname, :file?,
        :readable?, :socket?, :symlink?, :writable?, :zero?]      
    end
  end  
end
