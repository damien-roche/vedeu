# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe Sentence do

    let(:described) { Vedeu::Sentence }
    let(:elements)  { ['Hydrogen'] }
    let(:label)     { 'elements' }

    describe '.construct' do
      subject { described.construct(elements, label) }

      context 'when there is one element' do
        let(:elements) { ['Hydrogen'] }

        it 'returns the element as a string' do
          subject.must_equal('Hydrogen')
        end
      end

      context 'when there are two elements' do
        let(:elements) { %w(Hydrogen Helium) }

        it "returns the elements joined with 'and'" do
          subject.must_equal('Hydrogen and Helium')
        end
      end

      context 'when there are more than two elements' do
        let(:elements) { %w(Hydrogen Helium Lithium) }

        it 'returns the elements as a sentence list' do
          subject.must_equal('Hydrogen, Helium and Lithium')
        end
      end

      context 'when there are no elements' do
        let(:elements) { [] }

        it 'returns a polite message' do
          subject.must_equal('No elements have been assigned.')
        end
      end
    end

  end # Sentence

end # Vedeu
