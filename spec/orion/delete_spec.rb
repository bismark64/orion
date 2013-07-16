require "spec_helper"

module Orion
  module RSpec
    describe Delete do
      describe "#delete_files" do
        let(:deleted) { Orion::Delete.send(:delete_files, found_files(".txt")) }

        # The files array comes from the Orion::Search class
        it_should_behave_like "any normal finder"

        it "should return nil if the files array is empty" do
          deleted = Orion::Delete.send(:delete_files, found_files("87asd8as89das35d4as7a?4sd.rb"))
          deleted.should be_nil
        end

        it "should return an array if the files are found" do
          create_files
          deleted.should be_instance_of Array
        end

        it "should return an array with the deleted files" do
          create_files
          deleted = Orion::Delete.send(:delete_files, found_files("remove"))
          deleted.each do |deleted_file|
            deleted_file.should be_instance_of String
            deleted_file.should_not be_a_valid_file
          end
        end
      end
    end
  end
end