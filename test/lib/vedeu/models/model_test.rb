require 'test_helper'

module Vedeu

  describe Model do
    let(:model_instance) { ModelTestClass.new(attributes) }
    let(:attributes) {
      {
        name: 'hydrogen'
      }
    }

    describe '#deputy' do
      subject { model_instance.deputy }

      it 'returns the DSL instance' do
        subject.must_be_instance_of(DSL::ModelTestClass)
      end
    end

    describe '#store' do
      subject { model_instance.store }

      it 'returns the model' do
        subject.must_be_instance_of(ModelTestClass)
      end
    end

  end # Model

end # Vedeu