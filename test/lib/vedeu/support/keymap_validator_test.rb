require 'test_helper'

module Vedeu

  describe KeymapValidator do

    let(:described) { KeymapValidator.new(storage, key, interface) }
    let(:storage)   {
      {
        'dubnium' => {
          'a' => proc { :do_something }
        },
        '_global_keymap_' => {
          'g' => proc { :do_something }
        }
      }
    }
    let(:key)       { 'a' }
    let(:interface) { 'dubnium' }

    describe '.check' do
      context 'when already in use as a system key' do
        it { proc {
          KeymapValidator.check(storage, :shift_tab, interface)
        }.must_raise(KeyInUse) }
      end

      context 'when already in use as a global key' do
        it { proc {
          KeymapValidator.check(storage, 'g', interface)
        }.must_raise(KeyInUse) }
      end

      context 'when already in use by the interface' do
        it { proc {
          KeymapValidator.check(storage, 'a', interface)
        }.must_raise(KeyInUse) }
      end

      context 'when already in use' do
        it { proc { KeymapValidator.check(storage, 'a', '') }.must_raise(KeyInUse) }
      end

      it 'returns true when valid as a global key' do
        KeymapValidator.check(storage, 'h', '').must_equal(true)
      end

      it 'returns true when valid as an interface key' do
        KeymapValidator.check(storage, 'b', 'dubnium').must_equal(true)
      end
    end

    describe '#initialize' do
      it { return_type_for(described, KeymapValidator) }
      it { assigns(described, '@storage', storage) }
      it { assigns(described, '@key', key) }
      it { assigns(described, '@interface', interface) }
    end

  end # KeymapValidator

end # Vedeu
