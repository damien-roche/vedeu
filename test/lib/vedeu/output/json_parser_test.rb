require 'test_helper'
require 'vedeu/output/json_parser'

module Vedeu
  describe JSONParser do
    describe '.parse' do
      it 'returns a hash when the JSON is valid' do
        JSONParser.parse("{\"some\": \"JSON\"}")
          .must_be_instance_of(Hash)
      end

      it 'returns an empty hash when the JSON is invalid' do
        JSONParser.parse('{ invalid JSON }').must_be_instance_of(Hash)
      end
    end
  end
end