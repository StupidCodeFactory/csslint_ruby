require 'spec_helper'

describe CsslintRuby do


  describe "When no linting errors are returned" do

    let(:source) { File.open('spec/fixtures/source.css') }

    it 'is valid' do
      expect(CsslintRuby.run(source)).to be_valid
    end

  end

  describe "When linting errors are returned" do

    let(:source) { File.open('spec/fixtures/errors.css') }
    let(:result) { CsslintRuby.run(source, {}) }

    it 'is not valid' do
      expect(result).not_to be_valid
    end

    describe '#errors' do
      it 'have an expected structure' do
        expect(result.errors.first).to include('type', 'line', 'col', 'message', 'evidence', 'rule')
      end

      it 'have rule description on' do
        expect(result.errors.first['rule']).to include('id', 'name', 'desc', 'browsers')
      end
    end
  end

  describe "When passing options" do
    let(:options) { {errors: ['known-properties']} }
    let(:source)  { File.open('spec/fixtures/errors_with_options.css') }

    it 'passes the options to CSSLint correctly' do
      result = CsslintRuby.run(source, options)
      expect(result).not_to be_valid
      expect(result.errors.first).to include(
        'type' => 'error',
        'rule' => {
          'id'      => 'known-properties',
          'name'    => 'Require use of known properties',
          'desc'    => 'Properties should be known (listed in CSS3 specification) or be a vendor-prefixed property.',
          'browsers'=>'All'
        })
    end
  end
end
