require 'spec_helper'

module Whiz
  RSpec.describe Page do

    before { setup_dot_whiz! }
    after { teardown_dot_whiz! }

    let!(:tomes_path) { "#{dot_whiz_path}/tomes" }

    describe 'initialize' do 
      context 'without a current tome set' do
        before do
          Whiz::Tome.current = nil
        end

        it 'fails' do
          expect do
            described_class.new(:my_page)
          end.to raise_error(Whiz::Page::Error)
        end
      end

      context 'with a current tome set' do
        before do
          Whiz::Tome.current = :le_tome
        end

        it 'succeeds' do
          expect(described_class.new(:my_page)).to be_a(described_class)
        end
      end
    end

    describe 'class methods' do
      describe '::exists?' do
        let(:tome_path) { "#{tomes_path}/le_tome" }

        context 'page exists' do
          before do
            FileUtils.mkdir_p(tome_path)
            File.open("#{tome_path}/le_page", 'w')
          end

          it 'returns true' do
            expect(described_class.exists?(:le_page)).to eq(true)
          end
        end

        context 'page does not exist' do
          it 'returns false' do
            expect(described_class.exists?(:le_page)).to eq(false)
          end
        end
      end
    end

    describe 'instance methods' do
      describe '#edit' do
        pending 'mock it'
      end

      describe '#destroy' do
        let(:tome_path) { "#{tomes_path}/le_tome" }
        let(:subject) { described_class.new(:le_page) }

        context 'page is saved' do
          before do
            FileUtils.mkdir_p(tome_path)
            File.open("#{tome_path}/le_page", 'w')
          end

          it 'returns true' do
            expect(subject.destroy).to eq(true)
          end
        end

        context 'page is not saved' do
          it 'returns false' do
            expect(subject.destroy).to eq(false)
          end
        end
      end

      describe '#saved?' do
        let(:tome_path) { "#{tomes_path}/le_tome" }
        let(:subject) { described_class.new(:le_page) }

        context 'page exists' do
          before do
            FileUtils.mkdir_p(tome_path)
            File.open("#{tome_path}/le_page", 'w')
          end

          it 'returns true' do
            expect(subject.saved?).to eq(true)
          end
        end

        context 'page does not exist' do
          it 'returns false' do
            expect(subject.saved?).to eq(false)
          end
        end
      end
    end
  end
end