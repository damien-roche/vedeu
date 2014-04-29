require_relative '../../../test_helper'

module Vedeu
  module Colours
    describe Style do
      let(:klass)      { Style }
      let(:pair_name)  { :american_pride }
      let(:foreground) { :red }
      let(:background) { :white }

      before do
        Colours::Wrapper.stubs(:define_pair).returns(nil)
        Colours::Palette.stubs(:exists?).returns(exists)
      end

      describe '#define' do
        subject { klass.define(pair_name, foreground, background) }

        context 'when the colour is defined' do
          let(:exists) { true }

          it 'returns the colour pair ID' do
            # test value flips between 3072 and 2816
            # subject.must_equal(3072)
            skip
          end
        end

        context 'when the colour is not defined' do
          let(:exists) { false }

          it 'raises an exception' do
            proc { subject }.must_raise(Colours::UndefinedColour)
          end
        end
      end
    end
  end
end
