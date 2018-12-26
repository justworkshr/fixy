require 'spec_helper'

describe Fixy::Formatter::Alphanumeric do
  let(:proxy) do
    Class.new do
      include Fixy::Formatter::Alphanumeric

      self::LINE_ENDING_CRLF = "\r\n"
      def line_ending; end
    end.new
  end

  describe '#format_alphanumeric' do
    subject { proxy.format_alphanumeric(input, length) }

    let(:length) { 10 }

    [
      ['',         6, '      '],
      ['Sarah',    3, 'Sar'],
      ['Sarah',   10, 'Sarah     '],
      [123.52,    10, '123.52    '],
      ['El Niño', 10, 'El Niño  '], # NOTE: There are 9 characters in the expected output, for a total of 10 bytes
    ].each do |given_input, given_length, expected_value|
      context "when input=#{given_input} and length=#{given_length}" do
        let(:input) { given_input }
        let(:length) { given_length }

        it { is_expected.to eq(expected_value) }
      end
    end
  end
end
