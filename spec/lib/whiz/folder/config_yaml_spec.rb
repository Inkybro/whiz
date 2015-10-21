require 'spec_helper'

module Whiz
  module Folder
    describe ConfigYaml do
      @@whiz_path = "#{ENV['HOME']}/.whiz_test"
      @@config_file = "#{@@whiz_path}/whiz.yaml"

      after(:all) do
        File.delete(@@config_file) if File.exists?(@@config_file)
        Dir.rmdir(@@whiz_path) if Dir.exists?(@@whiz_path)
      end

      let!(:whiz_path) { @@whiz_path }
      let!(:config_file) { @@config_file }
      let!(:default_config_data) do
        {
          current_tome: nil
        }
      end

      describe 'class methods' do
        describe '::default_options' do
          it 'should return the default options' do
            expect(Whiz::Folder::ConfigYaml.default_options).to eq(default_config_data)
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

        describe '::load!' do
          it 'returns an instance of ConfigYaml' do
            expect(Whiz::Folder::ConfigYaml.load!).to be_a(Whiz::Folder::ConfigYaml)
          end
        end
      end

      describe 'instance methods' do
        let!(:config) { Whiz::Folder::ConfigYaml.load! }

        describe '#filename' do
          it 'exposes the config filename' do
            expect(config.filename).to eq(config_file)
          end
        end

        describe '#data' do
          it 'exposes the config data' do
            expect(config.data).to eq(default_config_data)
          end
        end

        describe '#[]=' do
          it 'sets a config value by symbol key' do
            config[:symbol_key] = 321
            expect(config.data[:symbol_key]).to eq(321)
          end

          it 'sets a config value by string key' do
            config['string_key'] = 789
            expect(config.data[:string_key]).to eq(789)
          end
        end

        describe '#[]' do
          before do
            config[:test_value] = 123
          end

          it 'fetches a config value by symbol key' do
            expect(config[:test_value]).to eq(123)
          end

          it 'fetches a config value by string key' do
            expect(config['test_value']).to eq(123)
          end
        end

        describe '#save' do
          let(:config_yaml) { YAML::load_file(config_file) }

          before do
            config[:current_tome] = 'my_tome'
            config.save
          end

          it 'saves the configuration to whiz.yaml' do
            expect(config_yaml[:current_tome]).to eq('my_tome')
          end
        end
      end
    end
  end
end
