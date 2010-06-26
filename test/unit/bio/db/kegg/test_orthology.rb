#
# test/unit/bio/db/kegg/test_orthology.rb - Unit test for Bio::KEGG::ORTHOLOGY
#
# Copyright::  Copyright (C) 2009 Kozo Nishida <kozo-ni@is.naist.jp>
# License::    The Ruby License

# loading helper routine for testing bioruby
require 'pathname'
load Pathname.new(File.join(File.dirname(__FILE__), ['..'] * 4,
                            'bioruby_test_helper.rb')).cleanpath.to_s

# libraries needed for the tests
require 'test/unit'
require 'bio/db/kegg/orthology'

module Bio
  class TestKeggOrthology < Test::Unit::TestCase

    def setup
      testdata_kegg = Pathname.new(File.join(BioRubyTestDataPath, 'KEGG')).cleanpath.to_s
      entry = File.read(File.join(testdata_kegg, "K02338.orthology"))
      @obj = Bio::KEGG::ORTHOLOGY.new(entry)
    end

    def test_entry_id
      assert_equal('K02338', @obj.entry_id)
    end

    def test_name
      assert_equal("DPO3B, dnaN", @obj.name)
    end

    def test_names
      assert_equal(["DPO3B", "dnaN"], @obj.names)
    end

    def test_definition
      assert_equal("DNA polymerase III subunit beta [EC:2.7.7.7]", @obj.definition)
    end

    def test_dblinks_as_hash
      assert_equal({"COG"=>["COG0592"], "RN"=>["R00375", "R00376", "R00377", "R00378"], "GO"=>["0003887"]}, @obj.dblinks_as_hash)
    end

    def test_genes_as_hash
      assert_equal(["BSU00020"], @obj.genes_as_hash["bsu"])
    end

    def test_keggclass
      assert_equal("Metabolism; Nucleotide Metabolism; Purine metabolism [PATH:ko00230] Metabolism; Nucleotide Metabolism; Pyrimidine metabolism [PATH:ko00240] Genetic Information Processing; Replication and Repair; DNA replication [PATH:ko03030] Genetic Information Processing; Replication and Repair; Mismatch repair [PATH:ko03430] Genetic Information Processing; Replication and Repair; Homologous recombination [PATH:ko03440] Protein Families; Genetic Information Processing; DNA replication proteins [BR:ko03032] Protein Families; Genetic Information Processing; DNA repair and recombination proteins [BR:ko03400]", @obj.keggclass)
    end
    def test_keggclasses
      expected =
        ["Metabolism; Nucleotide Metabolism; Purine metabolism",
         "Metabolism; Nucleotide Metabolism; Pyrimidine metabolism",
         "Genetic Information Processing; Replication and Repair; DNA replication",
         "Genetic Information Processing; Replication and Repair; Mismatch repair",
         "Genetic Information Processing; Replication and Repair; Homologous recombination",
         "Protein Families; Genetic Information Processing; DNA replication proteins",
         "Protein Families; Genetic Information Processing; DNA repair and recombination proteins"]
      assert_equal(expected, @obj.keggclasses)
    end
    def test_pathways
      assert_equal(["ko00230", "ko00240", "ko03030", "ko03430", "ko03440"],@obj.pathways)
    end
  end
end
