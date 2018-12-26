require 'spec_helper'

describe Fixy::Formatter::SignedAmount do
  let(:proxy) do
    Class.new do
      include Fixy::Formatter::SignedAmount
    end.new
  end

  describe '#format_signed_amount' do
    subject { proxy.format_signed_amount(input, length) }

    let(:length) { 10 }

    [
      # [nil,     6,  '00000+'],
      # ['',      6,  '00000+'],
      [0,       6,  '00000+'],
      [0.99,    4,  '099+'],
      [12.99,   5,  '1299+'],
      [-12.99,  5,  '1299-'],
      [12.99,   11, '0000001299+'],
      [-12.99,  11, '0000001299-'],
      [125.99,  6,  '12599+'],
      [12.992,  5,  '1299+'],
      [12.999,  5,  '1300+'],
      [-12.992, 5,  '1299-'],
      [-12.999, 5,  '1300-'],
    ].each do |given_input, given_length, expected_value|
      context "when input=#{given_input} and length=#{given_length}" do
        let(:input) { given_input }
        let(:length) { given_length }

        it { is_expected.to eq(expected_value) }
      end
    end

    context 'with insufficient length' do
      let(:input) { 125.99 }
      let(:length) { 5 }

      it { expect { subject }.to raise_error(ArgumentError, /Insufficient length/) }
    end
  end
end
