require "spec_helper"

module Orion
  module RSpec
    describe Delete do
      let(:just_delete) { Orion::Delete.send(:just_delete, found_files(name_hash ".txt")) }
      let(:delete_files) { Orion::Delete.send(:delete_files, found_files(name_hash ".txt")) }

      shared_examples_for "a normal deleter" do
        it "should return nil if the files array is empty" do
          deleted = Orion::Delete.send(method, found_files(name_hash rare_query))
          deleted.should be_nil
        end
      end

      describe "#just_delete" do
        # The files array comes from the Orion::Search class
        it_should_behave_like "any normal finder" do
          let(:search_method) { invalid_search.search(name_hash) }
        end

        it_should_behave_like "a normal deleter" do
          let(:method) { :just_delete }
        end

        it "should return true if could delete the files" do
          create_files(".txt")
          just_delete.should be_true
        end

        it "should delete the files it found" do
          create_files(".txt")
          just_delete
          found_files(name_hash ".txt").should be_empty
        end
      end

      describe "#delete_files"  do
        it_should_behave_like "any normal finder" do
          let(:search_method) { invalid_search.search(name_hash) }
        end

        it_should_behave_like "a normal deleter" do
          let(:method) { :delete_files }
        end

        it "should return an array if the files are found" do
          create_files(".txt")
          delete_files.should be_instance_of Array
        end

        it "should return an array with the deleted files" do
          create_files(".txt")
          deleted = Orion::Delete.send(:delete_files, found_files(name_hash "remove"))
          deleted.each do |deleted_file|
            deleted_file.should be_instance_of String
            deleted_file.should_not be_a_valid_file
          end
        end
      end

    end
  end
end