require "spec_helper"

module Orion
  module RSpec
    describe Orion do
      let(:orion_invalid_search) { Orion.search(invalid_path, ".rb") }
      let(:orion_invalid_delete) { Orion.delete(invalid_path, ".rb") }

      describe "#search" do
        it_should_behave_like "any normal finder" do
          let(:search_method) { orion_invalid_search }
        end

        it "should return a hash with trivial values if it couldn't find files" do
          response = orion_search(rare_query)
          response[:success].should be_false
          response[:count].should be_zero
          response[:files].should be_empty
        end

        it "should return a valuable hash if could find files" do
          response = orion_search
          response[:success].should be_true
          response[:count].should_not be_zero
          response[:files].should_not be_empty

          response[:files].each do |file|
            file.should be_instance_of String
            file.should be_a_valid_file
          end
        end
      end

      describe "#delete" do
        it_should_behave_like "any normal finder" do
          let(:search_method) { orion_invalid_delete }
        end

        context "not given a block" do
          it "should return nil if doesn't find files" do
            create_files(".txt")
            orion_delete(rare_query).should be_nil
          end

          it "should return true if find files" do
            create_files(".txt")
            orion_delete.should be_true
          end
        end

        context "given a block" do
          it "should return a response object" do
            create_files(".txt")
            Orion.delete(path, ".txt") do |response|
              response.should_not be_nil
            end
          end

          it "should return nil if doesn't find files" do
            Orion.delete(path, rare_query) do |response|
              response[:success].should be_false
              response[:count].should be_nil 
              response[:files].should be_nil 
            end
          end

          it "should return valid values if find files" do
            create_files(".txt")
            Orion.delete(path, ".txt") do |response|
              response[:success].should be_true
              response[:count].should_not be_zero 
              response[:files].should_not be_empty 
            end
          end
        end
      end
    end
  end
end