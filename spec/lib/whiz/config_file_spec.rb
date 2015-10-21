require 'spec_helper'

module Whiz
  describe ConfigFile do
    after(:all) do
      teardown_dot_whiz!
    end

    let!(:config_file) { "#{dot_whiz_path}/whiz.yaml" }
    let!(:default_config_data) do
      {
        current_tome: nil
      }
    end

    describe 'class methods' do
      describe '::default_options' do
        it 'should return the default options' do
          expect(described_class.default_options).to eq(default_config_data)
        end
      end

      describe '::load!' do
        it 'returns an instance of ConfigFile' do
          expect(described_class.load!).to be_a(described_class)
        end
      end
    end

    describe 'instance methods' do
      let!(:config) { described_class.load! }

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
