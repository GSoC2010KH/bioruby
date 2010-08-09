#
# test/unit/bio/io/test_ebisoap.rb - Unit test for DDBJ XML.
#
# Copyright:: Copyright (C) 2010
# License::   The Ruby License
#
#  $Id:$
#

# loading helper routine for testing bioruby
require 'pathname'
load Pathname.new(File.join(File.dirname(__FILE__), ['..'] * 3,
                            'bioruby_test_helper.rb')).cleanpath.to_s

# libraries needed for the tests
require 'test/unit'
require 'bio/io/ebisoap'

module Bio
  class TestEBISOAP < Test::Unit::TestCase
    def test_constants
      constants =["BASE_URI", "Citation", "ClustalW", 
        "Dbfetch", "Emboss", "Fasta", "InterProScan", 
        "MPsrch", "MSD", "Muscle", "Ontology", "SERVER_URI", 
        "ScanPS", "TCoffee", "WUBlast"]
      assert_equal(constants, Bio::EBI::SOAP.constants.sort.collect{|x| x.to_s})
    end

    def test_base_uri
      assert_equal("http://www.ebi.ac.uk/Tools/webservices/wsdl/WSDbfetch.wsdl", Bio::EBI::SOAP::SERVER_URI)
    end

    def test_dbfetch_uri
      assert_equal("http://www.ebi.ac.uk/Tools/webservices/wsdl/WSDbfetch.wsdl",Bio::EBI::SOAP::Dbfetch::SERVER_URI)
    end
    def test_inteproscan_uri
      assert_equal("http://www.ebi.ac.uk/Tools/webservices/wsdl/WSInterProScan.wsdl",Bio::EBI::SOAP::InterProScan::SERVER_URI)
    end
    def test_emboss_uri
      assert_equal("http://www.ebi.ac.uk/Tools/webservices/wsdl/WSEmboss.wsdl",Bio::EBI::SOAP::Emboss::SERVER_URI)
    end
    def test_clustalw_uri
      assert_equal("http://www.ebi.ac.uk/Tools/webservices/wsdl/WSClustalW.wsdl",Bio::EBI::SOAP::ClustalW::SERVER_URI)
    end
    def test_tcoffee_uri
      assert_equal("http://www.ebi.ac.uk/Tools/webservices/wsdl/WSTCoffee.wsdl",Bio::EBI::SOAP::TCoffee::SERVER_URI)
    end

    def test_muscle_uri
      assert_equal("http://www.ebi.ac.uk/Tools/webservices/wsdl/WSMuscle.wsdl",Bio::EBI::SOAP::Muscle::SERVER_URI)
    end
    def test_fasta_uri
      assert_equal("http://www.ebi.ac.uk/Tools/webservices/wsdl/WSFasta.wsdl",Bio::EBI::SOAP::Fasta::SERVER_URI)
    end
    def test_wublast_uri
      assert_equal("http://www.ebi.ac.uk/Tools/webservices/wsdl/WSWUBlast.wsdl",Bio::EBI::SOAP::WUBlast::SERVER_URI)
    end
    def test_mpsrch_uri
      assert_equal("http://www.ebi.ac.uk/Tools/webservices/wsdl/WSMPsrch.wsdl",Bio::EBI::SOAP::MPsrch::SERVER_URI)
    end
    def test_scanps_uri
      assert_equal("http://www.ebi.ac.uk/msd-srv/docs/api/msd_soap_service.wsdl",Bio::EBI::SOAP::MSD::SERVER_URI)
    end
    def test_ontology_uri
      assert_equal("http://www.ebi.ac.uk/ontology-lookup/OntologyQuery.wsdl",Bio::EBI::SOAP::Ontology::SERVER_URI)
    end
    def test_citation
      assert_equal("http://www.ebi.ac.uk/citations/webservices/wsdl",Bio::EBI::SOAP::Citation::SERVER_URI)
    end
  end
end