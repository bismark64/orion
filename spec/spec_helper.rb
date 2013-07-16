require 'rspec'
require 'orion'
require "support/string"

module SpecHelper
  def path
    File.dirname(__FILE__)
  end

  def search
    Orion::Search.new(path)
  end

  def invalid_path
    "#{File.dirname(__FILE__)}/invalid"
  end

  def invalid_search
    Orion::Search.new(invalid_path)
  end

  def found_files(query=".rb")
    search.send(:find, query)
  end

  def create_files
    File.new("#{File.dirname(__FILE__)}/remove.txt", "w")
    File.new("#{File.dirname(__FILE__)}/removeit.txt", "w")
    File.new("#{File.dirname(__FILE__)}/removeme.txt", "w")
    File.new("#{File.dirname(__FILE__)}/removemetoo.txt", "w")
  end
end

shared_examples_for "any normal finder" do
  it "should give an error when the path is incorrect" do
    expect{
      invalid_search.send(:find, ".rb")
    }.to raise_error(Errno::ENOENT)
  end
end

RSpec.configure do |config|
  config.include(SpecHelper)
end