require 'find'
require 'orion/result'
# require 'boyer_moore/boyer_moore'
include Orion::Result

module Orion
  class Search
    attr_accessor :root_path

    def initialize(root_path)
      @root_path ||= root_path
    end

    def search(query)
      find(query)
    end

    def with_response(query)
      result(find(query))
    end

    private

    def find(query)
      results = []
      Find.find(@root_path) do |path|
        unless FileTest.directory?(path)
          file = File.basename(path)
          results << path if file.include?(query)
        end
      end
      results
    end

  end

end