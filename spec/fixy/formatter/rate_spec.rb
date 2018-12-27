require 'spec_helper'

describe Fixy::Formatter::Rate do
  let(:proxy) do
    Class.new do
      include Fixy::Formatter::Rate
    end.new
  end

  describe '#format_rate' do
    subject { proxy.format_rate(input, length) }

    let(:length) { 10 }

    [
      # [nil,       4, '0000'],
      # ['',        4, '0000'],
      [0,         4, '0000'],
      [0.002,     4, '0020'],
      [0.008,     4, '0080'],
      [0.1453,    4, '1453'],
      [0.0453219, 4, '0453'],
      [0.0453212, 4, '0453'],
      [0.002,     6, '002000'],
      [0.008,     6, '008000'],
      [0.1453,    6, '145300'],
      [0.0453219, 6, '045322'],
      [0.0453212, 6, '045321'],
      [0.002,     8, '00200000'],
      [0.008,     8, '00800000'],
      [0.1453,    8, '14530000'],
      [0.0453219, 8, '04532190'],
      [0.0453212, 8, '04532120'],
    ].each do |given_input, given_length, expected_value|
      context "when input=#{given_input} and length=#{given_length}" do
        let(:input) { given_input }
        let(:length) { given_length }

        it { is_expected.to eq(expected_value) }
      end
    end

    context 'with negative input' do
      let(:input) { -0.1 }

      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end
end
