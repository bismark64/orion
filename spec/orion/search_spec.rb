require "spec_helper"

module Orion
  module RSpec
    describe Search do
      it "should have a path where to search in" do
        search.root_path.should == path  
      end

      describe "#search" do
        it_should_behave_like "any normal finder" do
          let(:search_method) { invalid_search.search(name_hash)}
        end

        it "should raise error if you don't provide any conditions" do
          expect{
            found_files({})
          }.to raise_error(I18n.t("errors.search.not_conditions_provided"))
        end

        it "should raise an error if it is given invalid conditions" do
          expect{
            found_files(has_files?: true, video?: false, name: ".mp4")
            }.to raise_error(NoMethodError)
        end
                
        context "search in directory" do
          it "should return an array" do
            found_files.should be_instance_of Array
          end

          it "should return an empty array if doesn't find files" do
            found_files(name_hash rare_query).should be_empty
            found_files(executable?: true, size: "< 58", directory?: false).should be_empty
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

          it "should allow to find files based on multiple conditions" do
            found_files(name: ".rb", size: "< 9000", ftype: "file", directory?: false).each do |file|
              file.should be_a_valid_file
              file.should be_include(".rb")
              File.size(file).should < 9000
              File.ftype(file).should == "file"
              File.directory?(file).should be_false
            end

            found_files(size: ">= 589").each do |file|
              file.should be_a_valid_file
              File.size(file).should >= 589
            end

            found_files(directory?: true, name: "spec", ctime: '> Time.now - 2.weeks').each do |file|
              p file
              file.should be_a_valid_file
              File.ftype(file).should == "directory"
              file.should be_include("spec")
              File.ctime(file).should > Time.now - 2.weeks
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