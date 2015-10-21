require 'spec_helper'

module Whiz
  RSpec.describe Tome do

    before { setup_dot_whiz! }
    after { teardown_dot_whiz! }

    let!(:config) { Whiz.config }
    let!(:tomes_path) { "#{dot_whiz_path}/tomes" }

    describe 'class methods' do
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

      describe '::create' do
        context 'tome exists' do
          before do
            FileUtils.mkdir_p("#{tomes_path}/my_tome")
          end

          it 'returns nil' do
            expect(described_class.create('my_tome')).to be_nil
          end
        end

        context 'tome does not exist' do
          it 'creates and returns the tome' do
            expect(described_class.create('my_tome')).to be_a(Whiz::Tome)
          end
        end
      end

      describe '::find' do
        context 'tome does not exist' do
          it 'returns nil' do
            expect(described_class.find('my_tome')).to be_nil
          end
        end

        context 'tome exists' do
          before do
            FileUtils.mkdir_p("#{tomes_path}/my_tome")
          end

          it 'loads and returns the tome' do
            expect(described_class.find('my_tome')).to be_a(Whiz::Tome)
          end
        end
      end

      describe '::find_or_create' do
        context 'tome does not exist' do
          it 'creates a new tome' do
            expect(described_class.find_or_create('my_tome')).to be_a(Whiz::Tome)
          end
        end

        context 'tome exists' do
          before do
            FileUtils.mkdir_p("#{tomes_path}/my_tome")
          end

          it 'loads the tome' do
            expect(described_class.find_or_create('my_tome')).to be_a(Whiz::Tome)
          end
        end
      end
    end

    describe 'instance methods' do
      describe '#save' do
        let!(:tome) { Whiz::Tome.new(:the_tome) }

        context 'unsaved tome' do
          before do
            tome.save
          end

          it 'creates the tome' do
            expect(Dir.exists?("#{tomes_path}/the_tome")).to eq(true)
          end
        end

        context 'saved tome' do
          it 'returns the tome' do
            expect(tome.save).to be_a(Whiz::Tome)
          end
        end
      end

      describe '#saved?' do
        let(:saved_tome) { Whiz::Tome.find_or_create(:saved_tome) }
        let(:unsaved_tome) { Whiz::Tome.new(:unsaved_tome) }

        context 'saved tome' do
          it 'returns true' do
            expect(saved_tome.saved?).to eq(true)
          end
        end

        context 'unsaved tome' do
          it 'returns false' do
            expect(unsaved_tome.saved?).to eq(false)
          end
        end
      end
    end
  end
end