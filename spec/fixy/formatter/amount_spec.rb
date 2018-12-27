
require 'spec_helper'

describe Fixy::Formatter::Amount do
  let(:proxy) do
    Class.new do
      include Fixy::Formatter::Amount
    end.new
  end

  describe '#format_amount' do
    subject { proxy.format_amount(input, length) }

    let(:length) { 10 }

    [
      # [nil,     3,  '000'],
      # ['',      3,  '000'],
      [0,       3,  '000'],
      [0.99,    3,  '099'],
      [12.99,   4,  '1299'],
      [-12.99,  4,  '1299'],
      [12.99,   10, '0000001299'],
      [-12.99,  10, '0000001299'],
      [125.99,  5,  '12599'],
      [12.992,  4,  '1299'],
      [12.999,  4,  '1300'],
      [-12.992, 4,  '1299'],
      [-12.999, 4,  '1300'],
    ].each do |given_input, given_length, expected_value|
      context "when input=#{given_input} and length=#{given_length}" do
        let(:input) { given_input }
        let(:length) { given_length }

        it { is_expected.to eq(expected_value) }
      end
    end

    context 'with insufficient length' do
      let(:input) { 125.99 }
      let(:length) { 4 }

      it { expect { subject }.to raise_error(ArgumentError, /Insufficient length/) }
    end
  end
end
