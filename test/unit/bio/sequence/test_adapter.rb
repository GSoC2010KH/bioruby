require 'pathname'
load Pathname.new(File.join(File.dirname(__FILE__), ['..'] * 3,
                            'bioruby_test_helper.rb')).cleanpath.to_s

# libraries needed for the tests
require 'test/unit'
require 'bio/sequence/adapter'

module Bio; class Sequence

  #an adapter class to connect FakeSequence and FakeSequenceSourceData
  module FakeSequenceAdapter
    extend Bio::Sequence::Adapter
    def_biosequence_adapter :hoge
  end

  #a class for the interface to access
  class FakeSequence
    include Bio::Sequence::FakeSequenceAdapter
    def initialize
      @source_data = FakeSequenceSourceData.new
    end
  end
  
  # a clss for the data soruce 
  class FakeSequenceSourceData
    def hoge
      "test"
    end
  end

  #a unit test class for Bio::Sequence::Adapter.
  class TestAdapter < Test::Unit::TestCase
    def test_hoge
      obj = Bio::Sequence::FakeSequence.new
      assert_equal("test", obj.hoge) 
    end
  end

end;end

