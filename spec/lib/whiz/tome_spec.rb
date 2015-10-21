require 'spec_helper'

module Whiz
  RSpec.describe Tome do

    before { setup_dot_whiz! }
    after { teardown_dot_whiz! }

    let!(:config) { Whiz.config }
    let!(:tomes_path) { "#{dot_whiz_path}/tomes" }

    describe 'class methods' do
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
            expect(described_class.create('my_tome')).to be_a(described_class)
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
            expect(described_class.find('my_tome')).to be_a(described_class)
          end
        end
      end

      describe '::find_or_create' do
        context 'tome does not exist' do
          it 'creates a new tome' do
            expect(described_class.find_or_create('my_tome')).to be_a(described_class)
          end
        end

        context 'tome exists' do
          before do
            FileUtils.mkdir_p("#{tomes_path}/my_tome")
          end

          it 'loads the tome' do
            expect(described_class.find_or_create('my_tome')).to be_a(described_class)
          end
        end
      end

      describe '::current=' do
        before do
          Whiz.config[:current_tome] = nil
          Whiz.config.save
          described_class.current = :le_tome
        end

        it 'sets the current tome' do
          expect(Whiz.config[:current_tome]).to eq(:le_tome)
        end
      end

      describe '::current' do
        context 'a current tome is not set' do
          before do
            described_class.current = nil
          end

          it 'returns nil' do
            expect(described_class.current).to be_nil
          end
        end

        context 'a current tome is set' do
          before do
            described_class.current = :a_tome
          end

          it 'returns the tome' do
            expect(described_class.current).to be_a(described_class)
          end
        end
      end

      describe '::all' do
        let!(:tome_one) { described_class.create(:tome_one) }
        let!(:tome_two) { described_class.create(:tome_two) }

        it 'returns all the tomes' do
          expect(described_class.all.count).to eq(2)
        end
      end
    end

    describe 'instance methods' do
      describe '#save' do
        let!(:tome) { described_class.new(:the_tome) }

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
            expect(tome.save).to be_a(described_class)
          end
        end
      end

      context '#destroy' do
        let!(:tome) { described_class.new(:le_tome) }

        context 'unsaved tome' do
          it 'returns false' do
            expect(tome.destroy).to eq(false)
          end
        end

        context 'saved tome' do
          before do
            tome.save
          end

          it 'returns true' do
            expect(tome.destroy).to eq(true)
          end
        end

        context 'saved tome set as current' do
          before do
            tome.save
            described_class.current = :le_tome
            tome.destroy
          end

          it 'sets the current_tome to nil' do
            expect(Whiz.config[:current_tome]).to be_nil
          end
        end
      end

      describe '#saved?' do
        let(:saved_tome) { described_class.find_or_create(:saved_tome) }
        let(:unsaved_tome) { described_class.new(:unsaved_tome) }

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

      describe '#pages' do
        let(:tome) { Whiz::Tome.find_or_create(:my_tome) }
        let(:tome_path) { "#{dot_whiz_path}/tomes/#{tome.name}" }

        context 'saved tome' do
          before do
            Whiz::Tome.current = tome.name
            File.open("#{tome_path}/my_page", 'w')
          end

          it 'returns the pages' do
            expect(tome.pages.count).to eq(1)
          end
        end

        context 'unsaved tome' do
          it 'returns an empty array' do
            expect(tome.pages.count).to eq(0)
          end
        end
      end
    end
  end
end