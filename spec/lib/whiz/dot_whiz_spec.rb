require 'spec_helper'

module Whiz
  RSpec.describe DotWhiz do
    after(:all) do
      teardown_dot_whiz!
    end

    let!(:tomes_path) { "#{dot_whiz_path}/tomes" }

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

      describe '::config_file' do
        it 'returns the config yaml file path' do
          expect(described_class.config_file).to eq(config_file)
        end
      end

      describe '::verify_config!' do
        context 'when the config file exists' do
          let(:config_file_contents) { File.read(config_file) }

          before do
            File.open(config_file, 'w') do |f|
              f.print 'testing 123'
            end
            described_class.verify_config!
          end

          it 'does nothing' do
            expect(config_file_contents).to eq('testing 123')
          end
        end

        context 'when the config does not exist' do
          before do
            File.delete(config_file) if File.exists?(config_file)
            described_class.verify_config!
          end

          it 'creates the config file' do
            expect(File.exists?(config_file)).to eq(true)
          end
        end
      end

      describe '::tomes_path' do
        it 'returns the tomes path' do
          expect(described_class.tomes_path).to eq(tomes_path)
        end
      end

      describe '::verify_tomes!' do
        before do
          described_class.verify_tomes!
        end

        it 'ensures that the tomes path exists' do
          expect(Dir.exists?(tomes_path)).to eq(true)
        end
      end
    end
  end
end