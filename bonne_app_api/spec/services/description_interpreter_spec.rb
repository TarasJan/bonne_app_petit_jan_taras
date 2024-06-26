# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DescriptionInterpreter do
  describe '#call' do
    let(:description) { '5 cups of sugar' }

    describe 'Interpreting with_all parameters' do
      subject(:interpreter_result) do
        described_class.new(description).with_all.call
      end

      it 'interprets amount as 5' do
        expect(interpreter_result[:amount]).to eq(5.0)
      end

      it 'interprets unit as cup' do
        expect(interpreter_result[:unit]).to eq('cups')
      end

      it 'interprets product name as sugar' do
        expect(interpreter_result[:name]).to eq('sugar')
      end
    end

    describe 'interpreting amounts' do
      subject(:interpreter_result) do
        described_class.new(description).with_amount.call
      end

      context '¼ cup Buffalo wing sauce' do
        let(:description) { '¼ cup Buffalo wing sauce' }

        it 'interprets amount as 0.25' do
          expect(interpreter_result[:amount]).to eq(0.25)
        end
      end

      context '1 ½ pounds cubed beef stew meat' do
        let(:description) { '1 ½ pounds cubed beef stew meat' }

        it 'interprets amount as 1.5' do
          expect(interpreter_result[:amount]).to eq(1.5)
        end
      end

      context '3 ½ teaspoons baking powder' do
        let(:description) { '3 ½ teaspoons baking powder' }

        it 'interprets product as Buffalo wing sauce' do
          expect(interpreter_result[:amount]).to eq(3.5)
        end
      end

      context '1 egg' do
        let(:description) { '1 egg' }

        it 'returns 1 as amount' do
          expect(interpreter_result[:amount]).to eq(1.0)
        end
      end
    end

    describe 'interpreting units' do
      subject(:interpreter_result) do
        described_class.new(description).with_unit.call
      end

      context '1 ½ pounds cubed beef stew meat' do
        let(:description) { '1 ½ pounds cubed beef stew meat' }

        it 'interprets unit as pound' do
          expect(interpreter_result[:unit]).to eq('pounds')
        end
      end

      context '¼ cup Buffalo wing sauce' do
        let(:description) { '¼ cup Buffalo wing sauce' }

        it 'interprets unit as cup' do
          expect(interpreter_result[:unit]).to eq('cup')
        end
      end

      context '1 egg' do
        let(:description) { '1 egg' }

        it 'returns empty string as unit' do
          expect(interpreter_result[:unit]).to eq('')
        end
      end

      context '3 ½ teaspoons baking powder' do
        let(:description) { '3 ½ teaspoons baking powder' }

        it 'interprets unit as teaspoons' do
          expect(interpreter_result[:unit]).to eq('teaspoons')
        end
      end
    end

    describe 'interpreting product name' do
      subject(:interpreter_result) do
        described_class.new(description).with_product_name.call
      end

      context '¼ cup coconut oil, melted and cooled' do
        let(:description) { '¼ cup coconut oil, melted and cooled' }

        it 'detects the product name as coconut oil' do
          expect(interpreter_result[:name]).to eq('coconut oil')
        end
      end

      context '1 ½ pounds cubed beef stew meat' do
        let(:description) { '1 ½ pounds cubed beef stew meat' }

        it 'interprets product as cubed beef stew meat' do
          expect(interpreter_result[:name]).to eq('cubed beef stew meat')
        end
      end

      context '¼ cup Buffalo wing sauce' do
        let(:description) { '¼ cup Buffalo wing sauce' }

        it 'interprets product as Buffalo wing sauce' do
          expect(interpreter_result[:name]).to eq('Buffalo wing sauce')
        end
      end

      context '3 ½ teaspoons baking powder' do
        let(:description) { '3 ½ teaspoons baking powder' }

        it 'interprets product as Buffalo wing sauce' do
          expect(interpreter_result[:name]).to eq('baking powder')
        end
      end

      context '1 egg' do
        let(:description) { '1 egg' }

        it 'returns product_name as egg' do
          expect(interpreter_result[:name]).to eq('egg')
        end
      end
    end
  end
end
