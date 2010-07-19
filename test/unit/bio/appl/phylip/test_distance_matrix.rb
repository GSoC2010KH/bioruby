#
# test/unit/bio/*****.rb - Unit test for Bio::Phylip::DistanceMatrix
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
require 'lib/bio/appl/phylip/distance_matrix.rb'

module Bio
  class TestBioPhylipDistanceMatrix < Test::Unit::TestCase

    def setup
      @filename = File.join(BioRubyTestDataPath, 'phylip/distance_matrix.txt')
      @obj = Bio::Phylip::DistanceMatrix.new(File.read(@filename))
    end

    def test_matrix
      expected =
Matrix[[0.0, 0.3039, 0.857544, 1.158927, 1.542899], [0.3039, 0.0, 0.339727, 0.913522, 0.619671], [0.857544, 0.339727, 0.0, 1.631729, 1.293713], [1.158927, 0.913522, 1.631729, 0.0, 0.165882], [1.542899, 0.619671, 1.293713, 0.165882, 0.0]]
      assert_equal(expected, @obj.matrix)
    end

    def test_otus
      assert_equal(5, @obj.otus)
    end

    def test_otu_names
      assert_equal(["Alpha", "Beta", "Gamma", "Delta", "Epsilon"], @obj.otu_names)
    end

    def test_original_matrix
      expected = 
Matrix[["0.000000", "0.303900", "0.857544", "1.158927", "1.542899"], ["0.303900", "0.000000", "0.339727", "0.913522", "0.619671"], ["0.857544", "0.339727", "0.000000", "1.631729", "1.293713"], ["1.158927", "0.913522", "1.631729", "0.000000", "0.165882"], ["1.542899", "0.619671", "1.293713", "0.165882", "0.000000"]]
      assert_equal(expected, @obj.original_matrix)
    end


    def test_generate
      expected =
        "    5\nOTU0        0.000000  0.303900  0.857544  1.158927  1.542899\nOTU1        0.303900  0.000000  0.339727  0.913522  0.619671\nOTU2        0.857544  0.339727  0.000000  1.631729  1.293713\nOTU3        1.158927  0.913522  1.631729  0.000000  0.165882\nOTU4        1.542899  0.619671  1.293713  0.165882  0.000000\n"
      assert_equal(expected, Bio::Phylip::DistanceMatrix.generate(@obj.matrix))
    end


  end #class TestBioPhylipDistanceMatrix
end #module Bio


