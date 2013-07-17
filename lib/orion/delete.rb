require 'orion/result'
include Orion::Result

module Orion
  module Delete
    def self.delete(files)
      just_delete(files)
    end

    def self.with_response(files)
      result(delete_files(files))
    end

    private

    def self.just_delete(files)
      if files.empty?
        nil
      else
        files.each do |file|
          File.delete(file)
        end
        true
      end
    end

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