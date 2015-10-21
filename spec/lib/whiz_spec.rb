require 'spec_helper'

describe Whiz do
  after(:all) { teardown_dot_whiz! }

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

    describe '::tome' do
      before do
        setup_dot_whiz!
        Whiz.config[:current_tome] = :my_tome
        Whiz.config.save
      end

      it 'returns the current tome' do
        expect(Whiz.tome).to be_a(Whiz::Tome)
      end
    end

    describe '::tomes' do
      before do
        setup_dot_whiz!
      end

      let!(:tome_one) { Whiz::Tome.create(:tome_one) }
      let!(:tome_two) { Whiz::Tome.create(:tome_two) }

      it 'returns all tomes' do
        expect(Whiz.tomes.count).to eq(2)
      end
    end

    describe '::boot!' do
      pending 'hard to test for now'
    end
  end
end
