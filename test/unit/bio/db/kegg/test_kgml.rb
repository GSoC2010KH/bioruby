#
# test/unit/bio/*****.rb - Unit test for Bio::KEGG::KGML
#
# Copyright::  Copyright (C) 2009 Naohisa Goto <ng@bioruby.org>
# License::    The Ruby License
#

# loading helper routine for testing bioruby
require 'pathname'
load Pathname.new(File.join(File.dirname(__FILE__), ['..'] * 4,
                            'bioruby_test_helper.rb')).cleanpath.to_s

# libraries needed for the tests
require 'test/unit'
require 'rexml/document'
require 'lib/bio/db/kegg/kgml.rb'

module Bio
  class TestBioKEGGKGML < Test::Unit::TestCase

    def setup
      filename = File.join(BioRubyTestDataPath, 'KEGG/ec00010.xml')
      @obj = Bio::KEGG::KGML.new(File.read(filename))
    end

    def test_name
      assert_equal("path:ec00010", @obj.name)
    end

    def test_org
      assert_equal("ec", @obj.org)
    end

    def test_number
      assert_equal("00010", @obj.number)
    end

    def test_title
      assert_equal("Glycolysis / Gluconeogenesis", @obj.title)
    end

    def test_image
      assert_equal("http://www.genome.jp/kegg/pathway/ec/ec00010.png", @obj.image)
    end

    def test_link
      assert_equal("http://www.genome.jp/kegg-bin/show_pathway?ec00010", @obj.link)
    end

    def test_entries
      @obj.entries.each { |ent| assert_instance_of(Bio::KEGG::KGML::Entry, ent) }
    end

    def test_relations
      @obj.relations.each { |ent| assert_instance_of(Bio::KEGG::KGML::Relation, ent) }
    end

    def test_reactions
      @obj.reactions.each { |ent| assert_instance_of(Bio::KEGG::KGML::Reaction, ent) }
    end

  end #class TestBioKEGGKGML
end #module Bio

