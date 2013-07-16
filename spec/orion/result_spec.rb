require "spec_helper"

module Orion
  module RSpec
    describe Result do
      describe "#result" do
        let(:result_nil) { Orion::Result.result(nil) }
        let(:result_empty) { Orion::Result.result([]) }
        let(:util_result) { Orion::Result.result(found_files) }

        it "should return a hash" do
          result_nil.should be_instance_of Hash
        end

        it "should return a hash with nil values if the array is nil" do
          result_nil[:success].should be_false
          result_nil[:count].should be_nil
          result_nil[:files].should be_nil
        end

        it "should return a hash with nil values if the array is empty" do
          result_empty[:success].should be_false
          result_empty[:count].should be_nil
          result_empty[:files].should be_nil
        end

        it "should return a util hash if the array is not empty or nil" do
          util_result[:success].should be_true
          util_result[:count].should == found_files.size
          util_result[:files].should == found_files
        end
      end
    end
  end
end