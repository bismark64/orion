require 'rspec'
require 'orion'
require "support/string"
require "orion/orion_support/i18n"

module SpecHelper
  def create_files(extension)
    File.new("#{File.dirname(__FILE__)}/remove#{extension}", "w")
    File.new("#{File.dirname(__FILE__)}/removeit#{extension}", "w")
    File.new("#{File.dirname(__FILE__)}/removeme#{extension}", "w")
    File.new("#{File.dirname(__FILE__)}/removemetoo#{extension}", "w")
  end

  def path
    File.dirname(__FILE__)
  end

  def search
    Orion::Search.new(path)
  end

  def file_path
    File.path(__FILE__)
  end

  def search_in_file
    Orion::Search.new(file_path)
  end

  def invalid_path
    "#{File.dirname(__FILE__)}/invalid"
  end

  def invalid_search
    Orion::Search.new(invalid_path)
  end

  def rare_query
    "87asd8as89das35d4as7a?4sd.rb"
  end

  def found_files(query=".rb")
    search.send(:find, query)
  end

  def files_in_file(query=".rb")
    search_in_file.send(:find, query)
  end

  def orion_search(query=".rb")
    Orion.search(path, query)
  end

  def orion_delete(query=".txt")
    Orion.delete(path, query)
  end
end

shared_examples_for "any normal finder" do
  it "should give an error when the path is incorrect" do
    expect{
      search_method
    }.to raise_error(Errno::ENOENT)
  end
end


RSpec.configure do |config|
  config.include(SpecHelper)
end