require "spec_helper"

module Orion
  module RSpec
    describe Search do
      it "should have a path where to search in" do
        search.root_path.should == path  
      end

      describe "#find" do
        it_should_behave_like "any normal finder"

        it "should return an array" do
          found_files.should be_instance_of Array
        end

        it "should return an empty array if doesn't find files" do
          found_files = search.send(:find, "87asd8as89das35d4as7a?4sd.rb")
          found_files.should be_empty
        end

        it "should return a non empty array if it finds files" do
          found_files.should_not be_empty
        end

        it "should return an array of strings if it finds files" do
          found_files.each do |file|
            file.should be_instance_of String
          end
        end

        it "should return an array of valid files" do
          found_files.each do |file|
            file.should be_a_valid_file
          end
        end
      end
    end
  end
end