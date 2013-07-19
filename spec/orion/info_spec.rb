require "spec_helper"

module Orion
  module RSpec
    describe Info do
      let(:invalid_info) { Orion::Info.new(path).info(:zero?, :pipe?) }
      let(:valid_info) { Orion::Info.new(path).info(:ctime, :size) }
      let(:one_info) { Orion::Info.new(path).info(:ctime) }

      describe "#info" do
        it "should raise an error if it isn't given any available methods as param" do
          expect{
            invalid_info
          }.to raise_error("The available methods for Orion.get_info are: atime, ctime, mtime, ftype, size")
        end

        it "should return the file value if just one method is provided" do
          one_info.should be_instance_of File.ctime(path).class
        end

        it "should return a OpenStruct object if it's provided with more than one method" do
          valid_info.should be_instance_of OpenStruct
          valid_info.instance_variable_get(:@table).keys.should be_eql([:ctime, :size])
          valid_info.instance_variable_get(:@table).values.should be_eql([File.ctime(path), File.size(path)])
        end
      end
    end
  end
end