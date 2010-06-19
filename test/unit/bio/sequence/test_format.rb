require 'pathname'
load Pathname.new(File.join(File.dirname(__FILE__), ['..'] * 3,
                            'bioruby_test_helper.rb')).cleanpath.to_s

# libraries needed for the tests
require 'test/unit'
require 'bio/sequence/format'

module Bio; class Sequence; module Format

  module Formatter
  #a simple subclass of Bio::Sequence::Format::FormatterBase implemented output methods.
  class FackFormat < Bio::Sequence::Format::FormatterBase

    def output
      @sequence
    end 
  end #class FackFormat

  end; end #Format::Formatter
  
  #a unit test for Bio::Sequence::Format::FormatterBase
  class TestFormatterBase < Test::Unit::TestCase
    def test_output
      assert_equal("test", Bio::Sequence::Format::Formatter::FackFormat.output("test")) #since Bio::Sequence::Format::Formatter::FackFormat is implemented output method.
      assert_raise(NotImplementedError){ Bio::Sequence::Format::FormatterBase.output("test") } #since output method of Bio::Sequence::Format::FormatterBase is the abstruct method.
    end
  end

end; end #Bio::Sequence

