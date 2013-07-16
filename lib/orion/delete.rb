require 'orion/result'
include Orion::Result

module Orion
  module Delete
    def self.delete(files)
      result(delete_files(files))
    end

    private

    def self.delete_files(files)
      if files.empty?
        nil
      else
        deleted_files = files.inject([]) do |deleted_files, file|
          deleted_files << file if File.delete(file) 
        end
      end
    end
  end
end