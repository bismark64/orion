require "orion/version"
require "orion/search"
require "orion/delete"

module Orion
  def self.search(root_path, query)
    Orion::Search.new(root_path).search(query)
  end

  def self.delete(root_path, query)
    found_files = Orion::Search.new(root_path).search(query)
    Orion::Delete.delete(found_files[:files])
  end
end
