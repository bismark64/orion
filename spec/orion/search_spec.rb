require "spec_helper"

module Orion
  module RSpec
    describe Search do
      it "should have a path where to search in" do
        search.root_path.should == path  
      end

      describe "#find" do
        it_should_behave_like "any normal finder" do
          let(:search_method) { invalid_search.search(name_hash)}
        end

        context "search in directory" do
          it "should return an array" do
            found_files.should be_instance_of Array
          end

          it "should return an empty array if doesn't find files" do
            found_files(name_hash rare_query).should be_empty
          end        

          it "should not return nil if doesn't find files" do
            found_files(name_hash rare_query).should_not be_nil
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

        context "search in file" do
          it "should return a file if the path is a file and the query includes the file name" do
            files_in_file.should be_one
            files_in_file.first.should == file_path
          end

          it "should return an empty array if doesn't find files" do
            files_in_file(name_hash rare_query).should be_empty
          end        

          it "should not return nil if doesn't find files" do
            files_in_file(name_hash rare_query).should_not be_nil
          end
        end
      end
    end
  end
end