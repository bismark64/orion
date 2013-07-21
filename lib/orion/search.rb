require 'orion/orion_support/find/find'
require "orion/orion_objects/array"
require "orion/orion_objects/nil"

module Orion
  class Search
    attr_accessor :root_path

    def initialize(root_path)
      @root_path ||= File.expand_path(root_path)
    end

    def search(query)
      Find.find(@root_path, query)
    end
  end
end