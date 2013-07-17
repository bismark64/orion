require "orion/version"
require "orion/search"
require "orion/delete"

module Orion
  def self.search(root_path, query)
    Orion::Search.new(root_path).with_response(query)
  end

  def self.delete(root_path, query)
    found_files = Orion::Search.new(root_path).search(query)
    if block_given?
      yield Orion::Delete.with_response(found_files)
    else
      Orion::Delete.delete(found_files)
    end
  end
end
