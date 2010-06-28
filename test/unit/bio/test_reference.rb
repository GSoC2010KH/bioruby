#
# = test/unit/bio/test_reference.rb - Unit test for Bio::Reference
#
# Copyright::  Copyright (C) 2006 
#              Mitsuteru C. Nakao <n@bioruby.org>
# License::    The Ruby License
#
# $Id:$
#

# loading helper routine for testing bioruby
require 'pathname'
load Pathname.new(File.join(File.dirname(__FILE__), ['..'] * 2,
                            'bioruby_test_helper.rb')).cleanpath.to_s

# libraries needed for the tests
require 'test/unit'
require 'bio/reference'
require 'bio/compat/references'


module Bio
  class TestReference < Test::Unit::TestCase
    
    def setup
      hash = {'authors' => [ "Hoge, J.P.", "Fuga, F.B." ], 'title' => "Title of the study.",
              'journal' => "Theor. J. Hoge", 'volume' => 12, 'issue' => 3, 'pages' => "123-145",
              'year' => 2001, 'pubmed' => 12345678, 'medline' => 98765432, 'abstract' => "Hoge fuga. hoge fuga.",
              'url' => "http://example.com", 'mesh' => ['Hoge'], 'affiliations' => ['Tokyo']}
      @obj = Bio::Reference.new(hash)
    end

    def test_authors
      ary = [ "Hoge, J.P.", "Fuga, F.B." ]
      assert_equal(ary, @obj.authors)
    end

    def test_journal
      str = 'Theor. J. Hoge'
      assert_equal(str, @obj.journal)      
    end
    
    def test_volume
      str = 12
      assert_equal(str, @obj.volume)      
    end

    def test_issue
      str = 3
      assert_equal(str, @obj.issue)      
    end

    def test_pages
      str = '123-145'
      assert_equal(str, @obj.pages)
    end

    def test_year
      str = 2001
      assert_equal(str, @obj.year)
    end
    
    def test_pubmed
      str = 12345678
      assert_equal(str, @obj.pubmed)
    end

    def test_abstract
      str = 'Hoge fuga. hoge fuga.'
      assert_equal(str, @obj.abstract)
    end

    def test_url
      str = 'http://example.com'
      assert_equal(str, @obj.url)
    end

    def test_mesh
      str = ['Hoge']
      assert_equal(str, @obj.mesh)
    end

    def test_affiliations
      str = ['Tokyo']
      assert_equal(str, @obj.affiliations)
    end

    def test_format_general
      str = 'Hoge, J.P., Fuga, F.B. (2001). "Title of the study." Theor. J. Hoge 12:123-145.'
      assert_equal(str, @obj.format)
      assert_equal(str, @obj.format('general'))
      assert_equal(str, @obj.general)
    end

    def test_format_endnote
      str = "%0 Journal Article\n%A Hoge, J.P.\n%A Fuga, F.B.\n%D 2001\n%T Title of the study.\n%J Theor. J. Hoge\n%V 12\n%N 3\n%P 123-145\n%M 12345678\n%U http://example.com\n%X Hoge fuga. hoge fuga.\n%K Hoge\n%+ Tokyo"
      assert_equal(str, @obj.format('endnote'))
      assert_equal(str, @obj.endnote)
    end

    def test_format_bibitem
      str = "\\bibitem{PMID:12345678}\nHoge, J.P., Fuga, F.B.\nTitle of the study.,\n{\\em Theor. J. Hoge}, 12(3):123--145, 2001."
      assert_equal(str, @obj.format('bibitem'))
      assert_equal(str, @obj.bibitem)
    end

    def test_format_bibtex
      str =<<__END__
@article{PMID:12345678,
  author       = {Hoge, J.P. and Fuga, F.B.},
  title        = {Title of the study.},
  journal      = {Theor. J. Hoge},
  year         = {2001},
  volume       = {12},
  number       = {3},
  pages        = {123--145},
  url          = {http://example.com},
}
__END__
      assert_equal(str, @obj.format('bibtex'))
      assert_equal(str, @obj.bibtex)

      #the case where a reference doesn't have the url.
      @obj.instance_eval{
        @url = nil
      }
      str =<<__END__
@article{PMID:12345678,
  author       = {Hoge, J.P. and Fuga, F.B.},
  title        = {Title of the study.},
  journal      = {Theor. J. Hoge},
  year         = {2001},
  volume       = {12},
  number       = {3},
  pages        = {123--145},
  url          = {http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Citation&list_uids=12345678},
}
__END__
      assert_equal(str, @obj.bibtex)

    end

    def test_format_bibtex_with_arguments
      str =<<__END__
@inproceedings{YourArticle,
  author       = {Hoge, J.P. and Fuga, F.B.},
  title        = {Title of the study.},
  year         = {2001},
  volume       = {12},
  number       = {3},
  pages        = {123--145},
  booktitle    = {Theor. J. Hoge},
  month        = {December},
}
__END__
      assert_equal(str, @obj.format('bibtex', 'inproceedings', 'YourArticle',
                                    { 'journal'   => false,
                                      'url' => false,
                                      'booktitle' => @obj.journal,
                                      'month' => 'December'}))
      assert_equal(str, @obj.bibtex('inproceedings', 'YourArticle',
                                    { 'journal'   => false,
                                      'url' => false,
                                      'booktitle' => @obj.journal,
                                      'month' => 'December'}))
    end

    def test_format_rd
      str = "== Title of the study.\n\n* Hoge, J.P. and Fuga, F.B.\n\n* Theor. J. Hoge 2001 12:123-145 [PMID:12345678]\n\nHoge fuga. hoge fuga."
      assert_equal(str, @obj.format('rd'))
      assert_equal(str, @obj.rd)
    end

    def test_format_nature
      str = 'Hoge, J.P. & Fuga, F.B. Title of the study. Theor. J. Hoge 12, 123-145 (2001).'
      assert_equal(str, @obj.format('Nature'))
      assert_equal(str, @obj.format('nature'))
      assert_equal(str, @obj.nature)
      short_str = 'Hoge, J.P. & Fuga, F.B. Theor. J. Hoge 12, 123-145 (2001).'
      assert_equal(short_str,@obj.nature(true)) #short

      #the case where the number of authoers is larger than 4.
      obj2 = @obj.clone
      obj2.instance_eval{
        @authors = [ "Hoge, J.P.", "Fuga, F.B.", "Foo, Q.E.", "Bar, G.N.", "Piyo, D.G." ]
      }
      em = "Hoge, J.P. et al. Theor. J. Hoge 12, 123-145 (2001)."
      assert_equal(em, obj2.nature(true))
      #the case where the number of authoers is 1.
      obj3 = @obj.clone
      obj3.instance_eval{
        @authors = [ "Hoge, J.P." ]
      }
      em = "Hoge, J.P. Theor. J. Hoge 12, 123-145 (2001)."
      assert_equal(em, obj3.nature(true))
    end

    def test_format_science
      str = 'J.P. Hoge, F.B. Fuga, Theor. J. Hoge 12 123 (2001).'
      assert_equal(str, @obj.format('Science'))
      assert_equal(str, @obj.format('science'))
      assert_equal(str, @obj.science)

      #the case where the number of authoers is larger than 4.
      obj2 = @obj.clone
      obj2.instance_eval{
        @authors = [ "Hoge, J.P.", "Fuga, F.B.", "Foo, Q.E.", "Bar, G.N.", "Piyo, D.G." ]
      }
      em = "J.P. Hoge et al., Theor. J. Hoge 12 123 (2001)."
      assert_equal(em, obj2.science)
    end

    def test_format_genome_biol
      str = 'Hoge JP, Fuga FB: Title of the study. Theor J Hoge 2001, 12:123-145.'
      assert_equal(str, @obj.format('genome biol'))
      assert_equal(str, @obj.genome_biol)
    end

    def test_format_genome_res
      str = "Hoge, J.P. and Fuga, F.B. 2001.\n  Title of the study. Theor. J. Hoge 12: 123-145."
      assert_equal(str, @obj.format('genome res'))
      assert_equal(str, @obj.genome_res)
    end

    def test_format_nar
      str = 'Hoge, J.P. and Fuga, F.B. (2001) Title of the study. Theor. J. Hoge, 12, 123-145.'
      assert_equal(str, @obj.format('nar'))
      assert_equal(str, @obj.nar)
    end

    def test_format_current
      str = 'Hoge JP, Fuga FB: Title of the study. Theor J Hoge 2001, 12:123-145.'
      assert_equal(str, @obj.format('current biology'))
    end

    def test_format_trends
      str = 'Hoge, J.P. and Fuga, F.B. (2001) Title of the study. Theor. J. Hoge 12, 123-145'
      assert_equal(str, @obj.trends)

      #the case where the number of authoers is larger than 2.
      obj2 = @obj.clone
      obj2.instance_eval{
        @authors = [ "Hoge, J.P.", "Fuga, F.B.", "Foo, Q.E."]
      }
      em = "Hoge, J.P. et al. (2001) Title of the study. Theor. J. Hoge 12, 123-145"
      assert_equal(em,obj2.trends)
      obj3 = @obj.clone
      obj3.instance_eval{
        @authors = [ "Hoge, J.P."]
      }
      em ="Hoge, J.P. (2001) Title of the study. Theor. J. Hoge 12, 123-145"
      assert_equal(em,obj3.trends)

    end

    def test_format_cell
      str = 'Hoge, J.P. and Fuga, F.B. (2001). Title of the study. Theor. J. Hoge 12, 123-145.'
      assert_equal(str, @obj.format('cell'))
    end

    def test_equal
      ref2 = {'authors' => [ "Hoge, J.P.", "Fuga, F.B." ], 'title' => "Title of the study.",
              'journal' => "Theor. J. Hoge", 'volume' => 12, 'issue' => 3, 'pages' => "123-145",
              'year' => 2001, 'pubmed' => 12345678, 'medline' => 98765432, 'abstract' => "Hoge fuga. hoge fuga.",
              'url' => "http://example.com", 'mesh' => ['Hoge'], 'affiliations' => ['Tokyo']}
      obj2 = Bio::Reference.new(ref2)
      assert(@obj==obj2)
    end

    def test_embl
      #Do you want to test this
    end

    def test_authors_join
      #authors.length > 1
      obj2 = @obj.clone
      obj2.instance_eval{
        @authors = [ "Hoge, J.P." ]
        def authors_join_test
          authors_join(' and ')
        end
      }
      assert_equal("Hoge, J.P.", obj2.authors_join_test)
      #authors.length == 1
      obj2 = @obj.clone
      obj2.instance_eval{
        @authors = [ "Hoge, J.P.","Fuga, F.B."]
        def authors_join_test
          authors_join(' and ')
        end
      }
      assert_equal("Hoge, J.P. and Fuga, F.B.", obj2.authors_join_test)
      #authors = ""
      obj4 = @obj.clone
      obj4.instance_eval{
        @authors = []
        def authors_join_test
          authors_join('')
        end
      }
      assert_equal("", obj4.authors_join_test)
    end
  end

  class TestReferences < Test::Unit::TestCase

    class NullStderr
      def initialize
        @log = []
      end

      def write(*arg)
        #p arg
        @log.push([ :write, *arg ])
        nil
      end

      def method_missing(*arg)
        #p arg
        @log.push arg
        nil
      end
    end #class NullStderr

    def setup
      # To suppress warning messages, $stderr is replaced by dummy object.
      @stderr_orig = $stderr
      $stderr = NullStderr.new

      hash = {}
      ary = [Bio::Reference.new(hash),
             Bio::Reference.new(hash)]
      @obj = Bio::References.new(ary)
    end

    def teardown
      # bring back $stderr
      $stderr = @stderr_orig
    end

    def test_append
      hash = {}
      ref = Bio::Reference.new(hash)
      assert(@obj.append(ref))
    end

    def test_each
      @obj.each do |ref|
        assert(ref)
      end
    end

  end

end
