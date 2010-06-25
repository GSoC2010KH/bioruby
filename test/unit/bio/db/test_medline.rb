#
# test/unit/bio/*****.rb - Unit test for Bio::MEDLINE
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
require 'lib/bio/db/medline.rb'

module Bio
  class TestBioMEDLINE < Test::Unit::TestCase

    def setup
      filename = File.join(BioRubyTestDataPath, 'medline/16734914.medline')
      @obj = Bio::MEDLINE.new(File.read(filename))
    end

    def test_reference
      expected =  
        {:abstract=>
"BACKGROUND: Agile is an iterative approach to software development that relies on strong collaboration and automation to keep pace with dynamic environments. We have successfully used agile development approaches to create and maintain biomedical software, including software for bioinformatics. This paper reports on a qualitative study of our experiences using these methods. RESULTS: We have found that agile methods are well suited to the exploratory and iterative nature of scientific inquiry. They provide a robust framework for reproducing scientific results and for developing clinical support systems. The agile development approach also provides a model for collaboration between software engineers and researchers. We present our experience using agile methodologies in projects at six different biomedical software development organizations. The organizations include academic, commercial and government development teams, and included both bioinformatics and clinical support applications. We found that agile practices were a match for the needs of our biomedical projects and contributed to the success of our organizations. CONCLUSION: We found that the agile development approach was a good fit for our organizations, and that these practices should be applicable and valuable to other biomedical software development efforts. Although we found differences in how agile methods were used, we were also able to identify a set of core practices that were common to all of the groups, and that could be a focus for others seeking to adopt these methods.",
   :affiliations=>
  ["SRA International, 4300 Fair Lakes Court, Fairfax, VA 22033, USA.",
   "david_kane@sra.com"],
 :authors=>
  ["Kane, D. W.",
   "Hohman, M. M.",
   "Cerami, E. G.",
   "McCormick, M. W.",
   "Kuhlmann, K. F.",
   "Byrd, J. A."],
 :journal=>"BMC Bioinformatics",
 :mesh=>
  ["Algorithms",
   "Automation",
   "Computational Biology/*methods",
   "Computers",
   "Database Management Systems",
   "Databases, Genetic",
   "Diffusion of Innovation",
   "Hospital Information Systems",
   "Hospitals",
   "Humans",
   "Medical Informatics",
   "Multicenter Studies as Topic",
   "Programming Languages",
   "Software",
   "*Software Design",
   "Systems Integration"],
 :pages=>"273",
 :pubmed=>"16734914",
 :title=>
  "Agile methods in biomedical software development: a multi-site experience report.",
 :volume=>"7",
 :year=>"2006"}
      actual =
              {:abstract=>@obj.reference.abstract,
 :affiliations=>
@obj.reference.affiliations,
 :authors=> @obj.reference.authors,
 :journal=>@obj.reference.journal,
 :mesh=>@obj.reference.mesh,
 :pages=>@obj.reference.pages,
 :pubmed=>@obj.reference.pubmed,
 :title=>@obj.reference.title,
 :volume=>@obj.reference.volume,
 :year=>@obj.reference.year}

      assert_equal(expected, actual)
    end

    def test_pmid
      assert_equal("16734914", @obj.pmid)
    end

    def test_ui
      assert_equal("", @obj.ui)
    end

    def test_ta
      assert_equal("BMC Bioinformatics", @obj.ta)
    end

    def test_vi
      assert_equal("7", @obj.vi)
    end

    def test_ip
      assert_equal("", @obj.ip)
    end

    def test_pg
      assert_equal("273", @obj.pg)
      obj = Bio::MEDLINE.new("PG  - 273-272")
      assert_equal("273-272", obj.pg)
    end

    def test_pages
      assert_equal("273", @obj.pages)
    end

    def test_dp
      assert_equal("2006", @obj.dp)
    end

    def test_year
      assert_equal("2006", @obj.year)
    end

    def test_ti
      expected = "Agile methods in biomedical software development: a multi-site experience report."
      assert_equal(expected, @obj.ti)
    end

    def test_ab
      expected = "BACKGROUND: Agile is an iterative approach to software development that relies on strong collaboration and automation to keep pace with dynamic environments. We have successfully used agile development approaches to create and maintain biomedical software, including software for bioinformatics. This paper reports on a qualitative study of our experiences using these methods. RESULTS: We have found that agile methods are well suited to the exploratory and iterative nature of scientific inquiry. They provide a robust framework for reproducing scientific results and for developing clinical support systems. The agile development approach also provides a model for collaboration between software engineers and researchers. We present our experience using agile methodologies in projects at six different biomedical software development organizations. The organizations include academic, commercial and government development teams, and included both bioinformatics and clinical support applications. We found that agile practices were a match for the needs of our biomedical projects and contributed to the success of our organizations. CONCLUSION: We found that the agile development approach was a good fit for our organizations, and that these practices should be applicable and valuable to other biomedical software development efforts. Although we found differences in how agile methods were used, we were also able to identify a set of core practices that were common to all of the groups, and that could be a focus for others seeking to adopt these methods."
      assert_equal(expected, @obj.ab)
    end

    def test_au
      expected = "Kane DW\nHohman MM\nCerami EG\nMcCormick MW\nKuhlmann KF\nByrd JA"
      assert_equal(expected, @obj.au)
    end

    def test_authors
      expected = ["Kane, D. W.",
 "Hohman, M. M.",
 "Cerami, E. G.",
 "McCormick, M. W.",
 "Kuhlmann, K. F.",
 "Byrd, J. A."]
      assert_equal(expected, @obj.authors)
    end

    def test_so
      expected = "BMC Bioinformatics. 2006 May 30;7:273."
      assert_equal(expected, @obj.so)
    end

    def test_mh
      expected = ["Algorithms",
 "Automation",
 "Computational Biology/*methods",
 "Computers",
 "Database Management Systems",
 "Databases, Genetic",
 "Diffusion of Innovation",
 "Hospital Information Systems",
 "Hospitals",
 "Humans",
 "Medical Informatics",
 "Multicenter Studies as Topic",
 "Programming Languages",
 "Software",
 "*Software Design",
 "Systems Integration"]
      assert_equal(expected, @obj.mh)
    end

    def test_ad
      expected = ["SRA International, 4300 Fair Lakes Court, Fairfax, VA 22033, USA.",
 "david_kane@sra.com"]
      assert_equal(expected, @obj.ad)
    end

    def test_doi
      assert_equal("10.1186/1471-2105-7-273", @obj.doi)
    end

    def test_pii
      assert_equal("1471-2105-7-273", @obj.pii)
    end

    def test_pt
      expected = ["Journal Article",
 "Research Support, N.I.H., Extramural",
 "Research Support, Non-U.S. Gov't"]
      assert_equal(expected, @obj.pt)
    end

  end #class TestBioMEDLINE
end #module Bio

