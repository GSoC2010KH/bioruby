#
# = test/unit/bio/io/test_hinv.rb - H-invDB web service (REST) client module
#
# Copyright::  Copyright (C) 2010
# License::    The Ruby License
#
# $Id:$
#


# loading helper routine for testing bioruby
require 'pathname'
load Pathname.new(File.join(File.dirname(__FILE__), ['..'] * 3,
                            'bioruby_test_helper.rb')).cleanpath.to_s

# libraries needed for the tests
require 'test/unit'
require 'bio/io/hinv'

module Bio
  class Hinv

    class TestAcc2hit < Test::Unit::TestCase
      def test_result
        res= <<-EOS
        <?xml version='1.0' encoding='UTF-8'?>
        <H-Inv>
        <H-INVITATIONAL-ID>HIT000053961</H-INVITATIONAL-ID>
        </H-Inv>
    EOS
    serv = Bio::Hinv::Acc2hit.new
    serv.instance_eval{ @xml = REXML::Document.new(res) }
    actual = serv.result
    assert_equal("HIT000053961", actual)
   end
  end
      class TestHit2acc < Test::Unit::TestCase
      def test_result
        res =<<-EOS
       <?xml version='1.0' encoding='UTF-8'?>
       <H-Inv>
        <ACCESSION-NO>AK097327</ACCESSION-NO>
       </H-Inv>
     EOS
     serv = Bio::Hinv::Hit2acc.new
     serv.instance_eval{ @xml = REXML::Document.new(res) }
     actual = serv.result
     assert_equal("AK097327", actual)
      end
    end

    class TestHitCnt < Test::Unit::TestCase
      def test_result
        res= <<-EOS
      <?xml version='1.0' encoding='UTF-8'?>
      <H-Inv>
        <TRANSCRIPT_CNT>187156</TRANSCRIPT_CNT>
      </H-Inv>
     EOS
    serv = Bio::Hinv::HitCnt.new
    serv.instance_eval{ @xml = REXML::Document.new(res) }
    actual = serv.result
    assert_equal(187156, actual)
   end
  end

  class TestHitDefinition < Test::Unit::TestCase
    
    def setup
       res= <<-EOS
       <?xml version='1.0' encoding='UTF-8'?>
       <H-Inv>
        <HIT_FUNCTION>
         <H-INVITATIONAL-ID>HIT000000001</H-INVITATIONAL-ID>
         <DATA-SOURCE_DEFINITION>Rho guanine nucleotide exchange factor 10.</DATA-SOURCE_DEFINITION>
         <CDNA_REP-H-INVITATIONAL>Representative transcript</CDNA_REP-H-INVITATIONAL>
         <CDNA_SPLICING-ISOFORM_CURATION></CDNA_SPLICING-ISOFORM_CURATION>
         <DATA-SOURCE_DB-REFERENCE_PROTEIN-MOTIF-ID>NP_055444</DATA-SOURCE_DB-REFERENCE_PROTEIN-MOTIF-ID>
         <DATA-SOURCE_IDENTITY>100.0</DATA-SOURCE_IDENTITY>
         <DATA-SOURCE_COVERAGE>100.0</DATA-SOURCE_COVERAGE>
         <DATA-SOURCE_HOMOLOGOUS_SPECIES>Homo sapiens</DATA-SOURCE_HOMOLOGOUS_SPECIES>
         <DATA-SOURCE_SIMILARITY-CATEGORY>Identical to known human protein(Category I).</DATA-SOURCE_SIMILARITY-CATEGORY>
        </HIT_FUNCTION>
       </H-Inv>
    EOS
    @serv = Bio::Hinv::HitDefinition.new
    @serv.instance_eval{ @xml = REXML::Document.new(res) }
    end
    def test_result
      actual = @serv.result
      assert_equal("Rho guanine nucleotide exchange factor 10.", actual)
    end

    def test_cdna_rep_h_invitational
      actual = @serv.cdna_rep_h_invitational
      assert_equal("Representative transcript", actual)
    end

    def test_cdna_splicing_isoform_curation
      actual = @serv.cdna_splicing_isoform_curation
      assert_equal(nil, actual)
    end

    def test_data_source_db_reference_protein_motif_id
      actual = @serv.data_source_db_reference_protein_motif_id
      assert_equal("NP_055444", actual)
    end

    def test_data_source_identity
      actual = @serv.data_source_identity
      assert_equal(100.0, actual)
    end

    def test_data_source_coverage
      actual = @serv.data_source_coverage
      assert_equal(100.0, actual)
    end

    def test_data_source_homologous_species
      actual = @serv.data_source_coverage
      assert_equal(100.0, actual)
    end

    def test_data_source_similarity_category
      actual = @serv.data_source_similarity_category
      assert_equal("Identical to known human protein(Category I).", actual)
    end
  end


  class TestHitPubmedId < Test::Unit::TestCase
      def test_result
        res= <<-EOS
       <?xml version='1.0' encoding='UTF-8'?>
       <H-Inv>
        <CDNA_DB-REFERENCE_PUBMED>7624364</CDNA_DB-REFERENCE_PUBMED>
        <CDNA_DB-REFERENCE_PUBMED>11279095</CDNA_DB-REFERENCE_PUBMED>
        <CDNA_DB-REFERENCE_PUBMED>15489334</CDNA_DB-REFERENCE_PUBMED>
       </H-Inv>
     EOS
    serv = Bio::Hinv::HitPubmedId.new
    serv.instance_eval{ @xml = REXML::Document.new(res) }
    actual = serv.result
    assert_equal([7624364, 11279095, 15489334], actual)
   end
  end

  class TestHitXML < Test::Unit::TestCase
      def test_result
        res= <<-EOS
       <?xml version="1.0" standalone="yes" ?>
       <H-Inv>
        <cDNAXML>
        <CLUSTER-ID>HIX0021591</CLUSTER-ID>
        <CLUSTER-ID-VERSION>HIX0021591.11</CLUSTER-ID-VERSION>
        <H-INVITATIONAL-ID>HIT000000001</H-INVITATIONAL-ID>
          </PROBE-MAPPING>
         </EXPRESSION>
        </cDNAXML>
       </H-Inv>
     EOS
        expected = <<-EOS
       <?xml version="1.0" standalone="yes" ?>
       <H-Inv>
        <cDNAXML>
        <CLUSTER-ID>HIX0021591</CLUSTER-ID>
        <CLUSTER-ID-VERSION>HIX0021591.11</CLUSTER-ID-VERSION>
        <H-INVITATIONAL-ID>HIT000000001</H-INVITATIONAL-ID>
          </PROBE-MAPPING>
         </EXPRESSION>
        </cDNAXML>
       </H-Inv>
     EOS
    serv = Bio::Hinv::HitXML.new
    serv.instance_eval{ @result = res  }
    actual = serv.result
    assert_equal(expected, actual)
   end
  end

  class TestHix2hit < Test::Unit::TestCase
      def test_result
        res= <<-EOS
       <?xml version='1.0' encoding='UTF-8'?>
       <H-Inv>
        <H-INVITATIONAL-ID>HIT000012846</H-INVITATIONAL-ID>
        <H-INVITATIONAL-ID>HIT000022124</H-INVITATIONAL-ID>
        <H-INVITATIONAL-ID>HIT000007722</H-INVITATIONAL-ID>
        <H-INVITATIONAL-ID>HIT000262478</H-INVITATIONAL-ID>
       </H-Inv>
     EOS
    serv = Bio::Hinv::Hix2hit.new
    serv.instance_eval{ @xml = REXML::Document.new(res) }
    actual = serv.result
    assert_equal(["HIT000012846", "HIT000022124", "HIT000007722", "HIT000262478" ], actual)
   end
  end

  class TestHixCnt < Test::Unit::TestCase
      def test_result
        res= <<-EOS
       <?xml version='1.0' encoding='UTF-8'?>
       <H-Inv>
        <LOCUS_CNT>36073</LOCUS_CNT>
       </H-Inv>
     EOS
    serv = Bio::Hinv::HixCnt.new
    serv.instance_eval{ @xml = REXML::Document.new(res) }
    actual = serv.result
    assert_equal(36073, actual)
   end
  end

  class TestHixCnt < Test::Unit::TestCase
      def test_result
        res= <<-EOS
       <?xml version='1.0' encoding='UTF-8'?>
       <H-Inv>
        <LOCUS_CNT>36073</LOCUS_CNT>
       </H-Inv>
     EOS
    serv = Bio::Hinv::HixCnt.new
    serv.instance_eval{ @xml = REXML::Document.new(res) }
    actual = serv.result
    assert_equal(36073, actual)
   end
  end

  class TestHixRepresent < Test::Unit::TestCase
      def setup
        res= <<-EOS
       <?xml version='1.0' encoding='UTF-8'?>
       <H-Inv>
        <LOCUS>
         <CLUSTER-ID>HIX0000001</CLUSTER-ID>
         <REP-H-INVITATIONAL-ID>HIT000022181</REP-H-INVITATIONAL-ID>
         <REP-ACCESSION-NO>AK097327</REP-ACCESSION-NO>
        </LOCUS>
       </H-Inv>
     EOS
        @serv = Bio::Hinv::HixRepresent.new
        @serv.instance_eval{ @xml = REXML::Document.new(res) }
      end
      def test_result
        actual = @serv.result
        assert_equal("HIT000022181", actual)
      end
      def test_rep_accession_no
        actual = @serv.rep_accession_no
        assert_equal("AK097327", actual)
      end
  end

  class TestKeywordSearch < Test::Unit::TestCase
      def setup
        res= <<-EOS
       <?xml version='1.0' encoding='UTF-8'?>
       <HINVDB_SEARCH>
        <QUERY>HIT00002218*</QUERY>
        <SIZE>8</SIZE>
        <START>1</START>
        <END>8</END>
        <H-INVITATIONAL-ID>HIT000022180</H-INVITATIONAL-ID>
        <H-INVITATIONAL-ID>HIT000022181</H-INVITATIONAL-ID>
        <H-INVITATIONAL-ID>HIT000022183</H-INVITATIONAL-ID>
        <H-INVITATIONAL-ID>HIT000022184</H-INVITATIONAL-ID>
        <H-INVITATIONAL-ID>HIT000022185</H-INVITATIONAL-ID>
        <H-INVITATIONAL-ID>HIT000022186</H-INVITATIONAL-ID>
        <H-INVITATIONAL-ID>HIT000022188</H-INVITATIONAL-ID>
        <H-INVITATIONAL-ID>HIT000022189</H-INVITATIONAL-ID>
       </HINVDB_SEARCH>
     EOS
        @serv = Bio::Hinv::KeywordSearch.new
        @serv.instance_eval{ @xml = REXML::Document.new(res) }
      end
      def test_result
        actual = @serv.result
        assert_equal(["HIT000022180", "HIT000022181", "HIT000022183", "HIT000022184", "HIT000022185", "HIT000022186", "HIT000022188", "HIT000022189"], actual)
      end

      def test_size
        actual = @serv.size
        assert_equal(8, actual)
      end

      def test_start
        actual = @serv.start
        assert_equal(1, actual)
      end

      def test_end
        actual = @serv.end
        assert_equal(8, actual)
      end
  end


end
end