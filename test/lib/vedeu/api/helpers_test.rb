require 'test_helper'

module Vedeu

  module API

    describe Helpers do

      describe '#background' do
        it { return_type_for(HelpersTestClass.new.background('#00ff00'), Hash) }

        it 'returns the value assigned' do
          HelpersTestClass.new.background('#00ff00').must_equal({ background: '#00ff00' })
        end

        context 'when the value was not defined' do
          it { proc { HelpersTestClass.new.background('') }.must_raise(InvalidSyntax) }
        end
      end

      describe '#foreground' do
        it { return_type_for(HelpersTestClass.new.foreground('#00ff00'), Hash) }

        it 'returns the value assigned' do
          HelpersTestClass.new.foreground('#00ff00').must_equal({ foreground: '#00ff00' })
        end

        context 'when the value was not defined' do
          it { proc { HelpersTestClass.new.foreground('') }.must_raise(InvalidSyntax) }
        end
      end

      describe '#colour' do
        context 'when the foreground or background attribute is missing' do
          it { proc { HelpersTestClass.new.colour({}) }.must_raise(InvalidSyntax) }
        end

        it 'sets the attribute when a :foreground is given' do
          HelpersTestClass.new.colour({ foreground: '#ff0000' })
            .must_equal({ foreground: '#ff0000' })
        end

        it 'sets the attribute when a :background is given' do
          HelpersTestClass.new.colour({ background: '#ff0000' })
            .must_equal({ background: '#ff0000' })
        end
      end

      describe '#style' do
        it 'return an empty collection with no arguments' do
          HelpersTestClass.new.style.must_equal([])
        end

        it 'return a collection containing the style' do
          HelpersTestClass.new.style('normal').must_equal(['normal'])
        end

        it 'return a collection containing the styles' do
          HelpersTestClass.new.style(['bold', 'underline'])
            .must_equal(['bold', 'underline'])
        end

        it 'returns Stream attributes with an empty block' do
          HelpersTestClass.new.style do
            #...
          end.must_equal(
            [{ colour: {}, style: [], text: '', width: nil, align: :left, parent: nil, }]
          )
        end

        it 'returns Stream attributes with a block' do
          HelpersTestClass.new.style do
            style 'italic'
          end.must_equal(
            [
              {
                colour: {},
                style: ['italic'],
                text: '',
                width: nil,
                align: :left,
                parent: nil,
              }
            ]
          )
        end

        it 'returns Stream attributes with a block' do
          HelpersTestClass.new.style do
            style ['italic', 'blink']
          end.must_equal(
            [
              {
                colour: {},
                style: ['italic', 'blink'],
                text: '',
                width: nil,
                align: :left,
                parent: nil,
              }
            ]
          )
        end
      end

    end # Helpers

  end # API

end # Vedeu
