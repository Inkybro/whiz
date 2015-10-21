require 'spec_helper'

module Whiz
  RSpec.describe Folder do
    after(:all) do
      teardown_dot_whiz!
    end

    describe 'class methods' do
      describe '::dot_whiz_path' do
        it 'returns the .whiz folder path' do
          expect(described_class.dot_whiz_path).to eq(dot_whiz_path)
        end
      end

      describe 'verify_dot_whiz_path!' do
        before do
          described_class.verify_dot_whiz!
        end

        it 'ensures the .whiz folder exists' do
          expect(Dir.exists?(dot_whiz_path)).to eq(true)
        end
      end
    end
  end
end