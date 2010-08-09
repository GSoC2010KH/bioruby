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


end
end