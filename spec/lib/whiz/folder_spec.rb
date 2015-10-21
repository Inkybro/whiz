require 'spec_helper'

module Whiz
  RSpec.describe Folder do
    @@whiz_path = "#{ENV['HOME']}/.whiz_test"
    @@config_file = "#{@@whiz_path}/whiz.yaml"

    after(:all) do
      File.delete(@@config_file) if File.exists?(@@config_file)
      Dir.rmdir(@@whiz_path) if Dir.exists?(@@whiz_path)
    end

    let!(:whiz_path) { @@whiz_path }
    let!(:config_file) { @@config_file }

    describe 'class methods' do
      describe '::whiz_path' do
        it 'returns the .whiz folder path' do
          expect(described_class.whiz_path).to eq(whiz_path)
        end
      end

      describe 'verify_whiz_path!' do
        before do
          File.delete(config_file) if File.exists?(config_file)
          Dir.rmdir(whiz_path) if Dir.exists?(whiz_path)
          described_class.verify_whiz_path!
        end

        it 'ensures the .whiz folder exists' do
          expect(Dir.exists?(whiz_path)).to eq(true)
        end
      end
    end
  end
end