#
# test/unit/bio/*****.rb - Unit test for Bio::GO
#
# Copyright::  Copyright (C) 2009 Naohisa Goto <ng@bioruby.org>
# License::    The Ruby License
#

# loading helper routine for testing bioruby
require 'pathname'
load Pathname.new(File.join(File.dirname(__FILE__), ['..'] * 3,
                            'bioruby_test_helper.rb')).cleanpath.to_s

# libraries needed for the tests
require 'test/unit'
require 'bio/db/go'

module Bio
  class TestBioGOOntology < Test::Unit::TestCase

    def setup
      filename = File.join(BioRubyTestDataPath, 'go/part_of_component.ontology')
      @obj = Bio::GO::Ontology.new(File.read(filename))
    end

    def test_dag_edit_format_parser
      filename = File.join(BioRubyTestDataPath, 'go/part_of_component.ontology')
      obj = Bio::GO::Ontology.new(File.read(filename))
      assert_equal(Bio::GO::Ontology,obj.class)
    end
    def test_goid2term
      assert_equal('cellular_component', @obj.goid2term('0005575'))
      assert_equal('cellular_component', @obj.goid2term('0008372'))
    end
  end

end
