require 'spec_helper'

describe Fixy::Formatter::Numeric do
  let(:proxy) do
    Class.new do
      include Fixy::Formatter::Numeric
    end.new
  end

  describe '#format_numeric' do
    subject(:format_numeric) { proxy.format_numeric(input, length) }

    let(:length) { 10 }

    [
      [nil,   6, '000000'],
      ['',    6, '000000'],
      [0,     6, '000000'],
      [123,   6, '000123'],
      [123,   3, '123'],
      [100,   6, '000100'],
      ['010', 6, '000010'],
    ].each do |given_input, given_length, expected_value|
      context "when input=#{given_input} and length=#{given_length}" do
        let(:input) { given_input }
        let(:length) { given_length }

        it { is_expected.to eq(expected_value) }
      end
    end

    context 'with insufficient length' do
      let(:input) { 1024 }
      let(:length) { 3 }

      it { expect { subject }.to raise_error(ArgumentError, /Insufficient length/) }
    end

    context 'when non-numeric' do
      let(:input) { '12-34' }

      it { expect { format_numeric }.to raise_error(ArgumentError, /only digits/) }
    end

    context 'when negative' do
      let(:input) { -34 }

      it { expect { format_numeric }.to raise_error(ArgumentError, /only digits/) }
    end

    context 'when decimal' do
      let(:input) { 12.34 }

      it { expect { format_numeric }.to raise_error(ArgumentError, /only digits/) }
    end
  end
end
