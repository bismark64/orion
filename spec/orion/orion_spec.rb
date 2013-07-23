require "spec_helper"

module Orion
  module RSpec
    describe Orion do
      let(:orion_invalid_search) { Orion.search(invalid_path, name_hash) }
      let(:orion_invalid_delete) { Orion.delete(invalid_path, name_hash) }
      let(:orion_invalid_info) { Orion.get_info(invalid_path, :size) }

      describe "#get_info" do

        shared_examples_for "any normal informant" do
          it "should raise an error if it isn't given any available methods as param" do
            expect{
              invalid_orion_get_info
            }.to raise_error(I18n.t("errors.get_info.no_correct_methods", methods: Info.available_methods.join(", ")))
          end
        end

        it_should_behave_like "any normal finder" do
          let(:search_method) { orion_invalid_info }
        end

        context "without a block" do
          it_should_behave_like "any normal informant" do
            let(:invalid_orion_get_info) do
              Orion.get_info(path, :files?)
            end
          end

          it "should return the request value if just one method is provided" do
            Orion.get_info(path, :ftype).should == File.ftype(path)
          end

          it "should accept variable params" do
            info = Orion.get_info(path, :ftype, :ctime, :size)
            info.should be_instance_of OpenStruct
            info.ftype.should == File.ftype(path)
            info.ctime.should == File.ctime(path)
            info.size.should == File.size(path)
          end
        end

        context "with a block" do
          it_should_behave_like "any normal informant" do
            let(:invalid_orion_get_info) do
              Orion.get_info(path, :files?) do |result|
                result.files?.should == File.files?(path)
              end
            end
          end

          it "should accept just one param" do
            Orion.get_info(path, :size) do |result|
              result.class.should == File.size(path).class
              result.should == File.size(path)
            end 
          end

          it "should accept variable params" do
            Orion.get_info(path, :size, :atime, :mtime, :ctime) do |result|
              result.size.should == File.size(path)
              result.atime.should == File.atime(path)
              result.mtime.should == File.mtime(path)
            end
          end
        end
      end

      describe "#search" do
        it_should_behave_like "any normal finder" do
          let(:search_method) { orion_invalid_search }
        end

        it "should return an object with trivial values if it couldn't find files" do
          response = orion_search(name_hash rare_query)
          response.success.should be_false
          response.count.should be_zero
          response.files.should be_empty
        end

        it "should return a valuable object if could find files" do
          response = orion_search(size: "> 58")
          response.success.should be_true
          response.count.should_not be_zero
          response.files.should_not be_empty

          response.files.each do |file|
            file.should be_instance_of String
            file.should be_a_valid_file
            File.size(file).should > 58
          end
        end
      end

      describe "#delete" do
        it_should_behave_like "any normal finder" do
          let(:search_method) { orion_invalid_delete }
        end

        context "without a block" do
          it "should return nil if doesn't find files" do
            create_files(".txt")
            orion_delete(name_hash(rare_query)).should be_nil
          end

          it "should return true if find files" do
            create_files(".txt")
            orion_delete.should be_true
          end
        end

        context "with a block" do
          it "should return a response object" do
            create_files(".txt")
            Orion.delete(path, name_hash(".txt")) do |response|
              response.should_not be_nil
            end
          end

          it "should return nil if doesn't find files" do
            Orion.delete(path, name_hash(rare_query)) do |response|
              response.success.should be_false
              response.count.should be_nil 
              response.files.should be_nil 
            end
          end

          it "should return valid values if find files" do
            create_files(".txt")
            Orion.delete(path, name_hash(".txt")) do |response|
              response.success.should be_true
              response.count.should_not be_zero 
              response.files.should_not be_empty 
            end
          end
        end
      end
    end
  end
end