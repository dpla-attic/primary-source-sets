require 'spec_helper'

describe 'sample json-ld' do
  Dir["etc/*.json"].each do |json_file|
    describe "#{json_file}" do
      let(:input) { JSON.load(File.open(json_file)) }
      let(:graph) { RDF::Graph.new << JSON::LD::API.toRdf(input) }

      it 'is valid json' do
        expect { input }.not_to raise_error
      end

      it 'is valid json-ld' do
        expect(graph).to be_valid
      end
    end
  end
end
