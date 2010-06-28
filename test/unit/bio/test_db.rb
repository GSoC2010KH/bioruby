#
# test/unit/bio/test_db.rb - Unit test for Bio::DB
#
# Copyright::  Copyright (C) 2005 Mitsuteru Nakao <n@bioruby.org>
# License::    The Ruby License
#
#  $Id:$
#

# loading helper routine for testing bioruby
require 'pathname'
load Pathname.new(File.join(File.dirname(__FILE__), ['..'] * 2,
                            'bioruby_test_helper.rb')).cleanpath.to_s

# libraries needed for the tests
require 'test/unit'
require 'bio/db'

module Bio
  class TestDB < Test::Unit::TestCase
    def setup
      
      @obj = Bio::DB.new
      @obj.instance_eval { @orig = {"TAG" => "TAG value1\n    value2"} }
    end

    def test_open
      assert(Bio::DB.respond_to?(:open))
    end
 
    def test_entry_id
      assert_raises(NotImplementedError) { @obj.entry_id }
    end

    def test_tags
      assert_equal(["TAG"], @obj.tags)
    end
    
    def test_exists
      assert_equal(true, @obj.exists?("TAG"))
    end

    def test_get
      assert_equal("TAG value1\n    value2", @obj.get("TAG"))
    end

    def test_fetch
      assert(@obj.fetch("TAG"))
      assert(@obj.fetch("TAG", 1))
    end

    def test_line_fetch
      obj2 = Bio::DB.new
      obj2.instance_eval { @orig = {"TAG" => "TAG value1\n    value2\n     value3-\n     value4"}; @data = {};@tagsize=4
                                      def test(tag = "TAG")
                                        lines_fetch(tag)
                                       end
                                    }
      assert_equal(["value1", "value2 value3-value4"],obj2.test("TAG"))
    end

    def test_field_fetch
      obj3 = Bio::DB.new
      obj3.instance_eval{@orig = {"TAG" => "TAG value1\n    value2\n"}; @data = {};@tagsize=4
                                      def test(tag = "TAG")
                                        field_fetch(tag)
                                       end
                                    }
       assert_equal("value1 value2",obj3.test("TAG"))
    end

end


  class TestNCBIDB < Test::Unit::TestCase
    def setup
      entry =<<END
LOCUS     locus
END
      @obj = Bio::NCBIDB.new(entry, 10)
    end

    def test_fetch
      assert_equal('locus', @obj.fetch("LOCUS"))
    end

    def test_p_toptag2array
    end

    def test_p_subtag2array
    end

    def test_p_entry2hash

    end

    def test_subtag2array
    entry =
"LOCUS     locus\n  SUBTA     subtag"
      obj2 = Bio::NCBIDB.new(entry,10)
      obj2.instance_eval{
        def test
          subtag2array(@orig["LOCUS"])
        end
      }
      assert_equal(["LOCUS     locus\n", "  SUBTA     subtag"], obj2.test)
    end

  end

#  class TestKEGGDB < Test::Unit::TestCase
#  end
  
  class TestEMBLDB < Test::Unit::TestCase
    def setup
      @entry =<<END
ID id
XX
CC cc1
CC cc2
END
      @obj = Bio::EMBLDB.new(@entry, 2)
    end

    def test_fetch
      assert_equal('id', @obj.fetch("ID"))
      assert_equal('cc1 cc2', @obj.fetch("CC"))
    end

    def test_p_entry2hash
    end
  end
end
