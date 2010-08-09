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
require 'bio/io/ncbisoap'

module Bio
  class TestNCBISOAP < Test::Unit::TestCase

    def test_server_uri
      assert_equal("http://www.ncbi.nlm.nih.gov/entrez/eutils/soap/eutils.wsdl", Bio::NCBI::SOAP::SERVER_URI)
    end

    def test_eutils_server_uri
      assert_equal("http://www.ncbi.nlm.nih.gov/entrez/eutils/soap/eutils.wsdl", Bio::NCBI::SOAP::EUtils::SERVER_URI)
    end

    def test_eutilslite_server_uri
      assert_equal("http://www.ncbi.nlm.nih.gov/entrez/eutils/soap/eutils_lite.wsdl", Bio::NCBI::SOAP::EUtilsLite::SERVER_URI)
    end

    def test_efetch_server_uri
      assert_equal("http://www.ncbi.nlm.nih.gov/entrez/eutils/soap/efetch.wsdl", Bio::NCBI::SOAP::EFetch::SERVER_URI)
    end
    
    def test_efetchlite_server_uri
      assert_equal("http://www.ncbi.nlm.nih.gov/entrez/eutils/soap/efetch_lit.wsdl", Bio::NCBI::SOAP::EFetchLite::SERVER_URI)
    end
  end
end