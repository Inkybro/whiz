require 'spec_helper'

describe Whiz do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end

  describe 'class methods' do
    describe '::environment' do
      it 'exposes WHIZ_ENV as a symbol' do
        expect(described_class.environment).to eq(:test)
      end
    end

    describe '::config' do
      it 'returns the ConfigYaml object' do
        expect(described_class.config).to be_a(Whiz::ConfigFile)
      end
    end

    describe '::boot!' do
      pending 'hard to test for now'
    end
  end
end
