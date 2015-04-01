require 'test_helper'

module Vedeu

  describe Clear do

    let(:described) { Vedeu::Clear }
    let(:instance)  { described.new(interface) }
    let(:interface) { Vedeu::Interface.new({ name: 'xenon', visible: visible }) }
    let(:geometry)  { Vedeu::Geometry.new({ x: 1, y: 1, xn: 3, yn: 3 })}
    let(:visible)   { true }

    before { interface.stubs(:geometry).returns(geometry) }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Clear) }
      it { instance.instance_variable_get('@interface').must_equal(interface) }
    end

    describe 'alias methods' do
      it { described.must_respond_to(:render) }
    end

    describe '.clear' do
      subject { described.clear(interface) }

      context 'when the interface is visible' do

      end

      context 'when the interface is not visible' do
        let(:visible) { false }

        it { subject.must_be_instance_of(Array) }

        it { subject.must_equal([]) }
      end
    end

    describe '#clear' do
      subject { instance.clear }

      it { subject.must_be_instance_of(Array) }
      it { subject.flatten.size.must_equal(9) }
    end

    describe '#write' do
      subject { instance.write }
    end

  end # Clear

end # Vedeu
