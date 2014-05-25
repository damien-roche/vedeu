require_relative '../../../test_helper'

module Vedeu
  describe Directive do
    let(:described_class)    { Directive }
    let(:described_instance) { described_class.new(directive) }
    let(:directive)          {}

    it { described_instance.must_be_instance_of(Directive) }

    describe '.enact' do
      let(:subject) { described_class.enact(directive) }

      context 'when the directive is invalid' do
        it 'raises an exception' do
          proc { subject }.must_raise(InvalidDirective)
        end
      end

      context 'when the directive is valid' do
        context 'when the directive is a collection' do
          context 'and the first element is a number' do
            let(:directive) { [0, 0] }

            it { subject.must_be_instance_of(String) }
          end

          context 'and the first element is a symbol' do
            let(:directive) { [:default, :default] }

            it { subject.must_be_instance_of(String) }
          end
        end

        context 'when the directive is individual' do
          let(:directive) { :normal }

          it { subject.must_be_instance_of(String) }
        end
      end
    end
  end
end
