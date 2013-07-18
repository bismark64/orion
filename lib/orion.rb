require "orion/version"
require "orion/search"
require "orion/delete"
require "orion/info"

module Orion
  def self.search(root_path, query)
    if block_given?
      yield Orion::Search.new(root_path).with_response(query)
    else
      Orion::Search.new(root_path).with_response(query)
    end
  end

  def self.delete(root_path, query)
    found_files = Orion::Search.new(root_path).search(query)
    if block_given?
      yield Orion::Delete.with_response(found_files)
    else
      Orion::Delete.delete(found_files)
    end
  end

  def self.get_info(path, *methods)
    if block_given?
      yield Orion::Info.new(path).info(*methods)
    else
      Orion::Info.new(path).info(*methods)
    end
  end
end
