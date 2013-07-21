require "orion/orion_support/i18n"
require "orion/version"
require "orion/search"
require "orion/delete"
require "orion/info"

module Orion
  def self.search(root_path, query_hash)
    method_call = Orion::Search.new(root_path).search(query_hash).to_orion
    block_given? ? yield(method_call) : method_call
  end

  def self.delete(root_path, query_hash)
    found_files = Orion::Search.new(root_path).search(query_hash)
    if block_given?
      yield Orion::Delete.with_response(found_files)
    else
      Orion::Delete.delete(found_files)
    end
  end
  
  def self.get_info(path, *methods)
    method_call = Orion::Info.new(path).info(*methods)
    block_given? ? yield(method_call) : method_call
  end
end
