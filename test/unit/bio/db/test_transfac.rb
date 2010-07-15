#
# test/unit/bio/*****.rb - Unit test for Bio::TRANSFAC
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
require 'lib/bio/db/transfac.rb'

module Bio
  class TestBioTRANSFAC < Test::Unit::TestCase

    def setup
      filename = File.join(BioRubyTestDataPath, 'transfac/G00003.emb') #This sample file is a gene table?
      @obj = Bio::TRANSFAC.new(File.read(filename))
    end
    def test_ac
      assert_equal("G000003", @obj.ac)
    end

    def test_dt
      expected = "14.06.1995 (created); dbo. 11.12.2000 (updated); vma."
      assert_equal(expected, @obj.dt)
    end

    def test_cc
      assert_equal("", @obj.cc)
    end

    def test_os
      assert_equal("adenovirus type 5", @obj.os)
    end

    def test_oc
      expected = "viridae; ds-DNA nonenveloped viruses; adenoviridae"
      assert_equal(expected, @obj.oc)
    end

    def test_rn
      assert_equal("", @obj.rn)
    end

    def test_ra
      assert_equal("", @obj.ra)
    end

    def test_rt
      assert_equal("", @obj.rt)
    end

    def test_rl
      assert_equal("", @obj.rl)
    end
  end #class TestBioTRANSFAC

   class TRANSFAC
     #I use the definition table as the sample file in Matrix class.
     class TestMATRIX < Test::Unit::TestCase
    def setup
      str =<<EOS
AC        Accession no.
XX
ID        Identifier
XX
DT        Date; author
XX
NA        Name of the binding factor
XX
DE        Short factor description
XX
BF        List of linked factor entries
XX

PO        A   C   G   T      Position within the aligned sequences,
01                           frequency of A, C, G, T residues, resp.;
02                           last column: deduced consensus in
03                           IUPAC 15-letter code
XX
BA        Statistical basis
XX
BS        Factor binding sites underlying the matrix
BS        (SITE accession no.; Start position for matrix sequence; 
           length of sequence used;
BS        number of gaps inserted; strand orientation)
XX
CC        Comments
XX
RX        MEDLINE ID
RN        Reference no.
RA        Reference authors
RT        Reference title
RL        Reference data
XX
EOS
      #filename = File.join(BioRubyTestDataPath, 'transfac/G00003.emb')
      @obj = Bio::TRANSFAC::MATRIX.new(str)
      #@obj = Bio::TRANSFAC::MATRIX.new(File.read(filename))
    end

    def test_na
      assert_equal("Name of the binding factor", @obj.na)
    end

    def test_de
      assert_equal("Short factor description""", @obj.de)
    end

    def test_bf
      assert_equal("", @obj.bf)
    end

    def test_ma
      assert_equal(Matrix[[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0], [0, 15, 0]], @obj.ma)
    end

    def test_ba
      assert_equal("Statistical basis", @obj.ba)
    end

    end #TestMATRIX

  #I can't find a sample file for TestSITE class.
  class TestSITE < Test::Unit::TestCase
    def setup
      filename = File.join(BioRubyTestDataPath, 'transfac/G00003.emb')
      @obj = Bio::TRANSFAC::SITE.new(File.read(filename))
    end

    def test_ty
      assert_equal("", @obj.ty)
    end

    def test_de
      assert_equal("early gene 1A", @obj.de)
    end

    def test_re
      assert_equal("", @obj.re)
    end

    def test_sq
      assert_equal("", @obj.sq)
    end

    def test_el
      assert_equal("", @obj.el)
    end

    def test_sf
      assert_equal("", @obj.sf)
    end

    def test_st
      assert_equal("", @obj.st)
    end

    def test_s1
      assert_equal("", @obj.s1)
    end

    def test_bf
      assert_equal("", @obj.bf)
    end

    def test_so
      assert_equal("", @obj.so)
    end

    def test_mm
      assert_equal("", @obj.mm)
    end

    def test_dr
      assert_equal("EMBL: X02996; AD5001. TRANSPATH: G000003.", @obj.dr)
    end
  end #SITE
  
  # I use the table definition (http://www.gene-regulation.com/pub/databases/transfac/doc/factor2.html) as the sample file.
  class TestFACTOR < Test::Unit::TestCase
    def setup
=begin
    str =<<EOS
AC        Accession no.
XX
ID        Identifier
XX
DT        Date; author
XX
FA        Factor name
XX
SY        Synonyms
XX
OS        Species
OC        Biological classification (taxonomy)
XX
GE        Encoding gene
XX
HO        Homologs (suggested)
XX
CL        Classification (class accession no.; class identifier;
          decimal classification number.)
XX
SZ        Size (length (number of amino acids); calculated 
          molecular mass in kDa; experimental molecular mass 
          (or range) in kDa (experimental method) [Ref]
XX
SQ        Sequence
XX
SC        Sequence comment, i. e. source of the protein sequence
XX
FT        Feature table (1st position last position feature)
XX
SF        Structural features
XX
CP        Cell specificity (positive)
CN        Cell specificity (negative)

EX        Expression pattern:
          organ, cell name, system, developmental stage; relative level of expression
          (very high, high, medium, low, very low, detectable or none);
          detection method; molecule type detected, i.e. RNA or protein; [reference]
XX
FF        Functional features
XX
IN        Interacting factors (factor accession no.; factor name; biological species.)
XX
MX        Matrix (MATRIX accession no.; identifier)
XX
BS        Binding SITE accession no. SITE ID; Quality: N; short description,
          GENE accession no.; biological species
XX

DR        External databases (EMBL, RSNP, SwissProt, PIR, Flybase, PDB,
DR        TRANSCompelTM, PathoDBÂ®, SMARt DBTM, TRANSPATHÂ®, DATF, BKL)
DR        EMBL: accession no.; identifier.
DR        RSNP: accession no.; EMBL: accession no.; pos: SNP position in EMBL sequence;
                var: variation introduced by SNP; effect of SNP (example¿> RSNP: 97894;
                EMBL: M61108; pos: 716; var: a,g; amino acid exchange, A47¿>T);
XX
RN        Reference no.
RX        MEDLINE ID
RA        Reference authors
RT        Reference title
RL        Reference data
XX
EOS
=end
    str =<<EOS
AC        Accession no.
XX
ID        Identifier
XX
DT        Date; author
XX
FA        Factor name
XX
SY        Synonyms
XX
OS        Species
OC        Biological classification (taxonomy)
XX
GE        Encoding gene
XX
HO        Homologs (suggested)
XX
CL        Classification (class accession no.; class identifier;
          decimal classification number.)
XX
SZ        Size (length (number of amino acids); calculated 
          molecular mass in kDa; experimental molecular mass 
          (or range) in kDa (experimental method) [Ref]
XX
SQ        Sequence
XX
SC        Sequence comment, i. e. source of the protein sequence
XX
FT        Feature table (1st position last position feature)
XX
SF        Structural features
XX
CP        Cell specificity (positive)
CN        Cell specificity (negative)

EX        Expression pattern:
          organ, cell name, system, developmental stage; relative level of expression
          (very high, high, medium, low, very low, detectable or none);
          detection method; molecule type detected, i.e. RNA or protein; [reference]
XX
FF        Functional features
XX
IN        Interacting factors (factor accession no.; factor name; biological species.)
XX
MX        Matrix (MATRIX accession no.; identifier)
XX
BS        Binding SITE accession no. SITE ID; Quality: N; short description,
          GENE accession no.; biological species
XX
RN        Reference no.
RX        MEDLINE ID
RA        Reference authors
RT        Reference title
RL        Reference data
XX
EOS
     # filename = File.join(BioRubyTestDataPath, 'transfac/G00003.emb')
      #@obj = Bio::TRANSFAC::FACTOR.new(File.read(filename))
      @obj = Bio::TRANSFAC::FACTOR.new(str)
    end

    def test_fa
      assert_equal("Factor name", @obj.fa)
    end

    def test_sy
      assert_equal("Synonyms", @obj.sy)
    end

    def test_dr
      #assert_equal("EMBL: X02996; AD5001. TRANS1PATH: G000003.", @obj.dr)
      #assert_equal("External databases (EMBL, RSNP, SwissProt, PIR, Flybase, PDB, TRANSCompelTM, PathoDB\302\256, SMARt DBTM, TRANSPATH\302\256, DATF, BKL) EMBL: accession no.; identifier. RSNP: accession no.; EMBL: accession no.; pos: SNP position in EMBL sequence;", @obj.dr)
      assert_equal("", @obj.dr) #deleted the dr line from the sample file because of the specific charactors.
    end

    def test_ho
      assert_equal("Homologs (suggested)", @obj.ho)
    end

    def test_cl
      assert_equal("Classification (class accession no.; class identifier;", @obj.cl)
    end

    def test_sz
      assert_equal("Size (length (number of amino acids); calculated", @obj.sz)
    end

    def test_sq
      assert_equal("Sequence", @obj.sq)
    end

    def test_sc
      assert_equal("Sequence comment, i. e. source of the protein sequence", @obj.sc)
    end

    def test_ft
      assert_equal("Feature table (1st position last position feature)", @obj.ft)
    end

    def test_sf
      assert_equal("Structural features", @obj.sf)
    end

    def test_cp
      assert_equal("Cell specificity (positive)", @obj.cp)
    end

    def test_cn
      assert_equal("Cell specificity (negative)", @obj.cn)
    end

    def test_ff
      assert_equal("Functional features", @obj.ff)
    end

    def test_in
      assert_equal('Interacting factors (factor accession no.; factor name; biological species.)', @obj.in)
    end

    def test_mx
      assert_equal("Matrix (MATRIX accession no.; identifier)", @obj.mx)
    end

    def test_bs
#      expected = "-498 -458 R01988; AD5$E1A_12; Binding factors: NF-1 T00539. -464 -452 R01989; AD5$E1A_13; Binding factors: POU2F1 T00641. -450 -428 R01990; AD5$E1A_14; Binding factors: ATF T00051. -420 -391 R01991; AD5$E1A_15; Binding factors: Sp1 T00759. -414 -391 R01992; AD5$E1A_16; Binding factors: ATF T00051. -394 -375 R01993; AD5$E1A_17; Binding factors: PEA3 T00685. -384 -363 R01994; AD5$E1A_18. -346 -334 R01995; AD5$E1A_19; Binding factors: PEA3 T00685. -338 -319 R01997; AD5$E1A_21; Binding factors: ATF T00051. -319 -305 R01998; AD5$E1A_22. -304 -289 R01999; AD5$E1A_23; Binding factors: GABP-alpha T01390, GABP-alpha:GABP-beta T00268, PEA3 T00685. -291 -278 R00310; AD5$E1A_04; Binding factors: E2F T00221. -273 -257 R01996; AD5$E1A_20; Binding factors: GABP-alpha T01390, GABP-alpha:GABP-beta T00268, PEA3 T00685. -228 -214 R00311; AD5$E1A_05; Binding factors: E2F T00221, E2F+E4 T00232. -197 -181 R02001; AD5$E1A_25; Binding factors: POU2F1 T00641. -178 -165 R02002; AD5$E1A_26. -99 -91 R02003; AD5$E1A_27. -83 -36 R02004; AD5$E1A_28. -72 -45 R02005; AD5$E1A_29. -52 -21 R00309; AD5$E1A_03; Binding factors: CREB T00163. -38 -21 R02006; AD5$E1A_30. -25 34 R02007; AD5$E1A_31. -12 9 R02008; AD5$E1A_32."
 #     assert_equal(expected, @obj.bs)
       assert_equal("Binding SITE accession no. SITE ID; Quality: N; short description,", @obj.bs)
    end
  end #FACTOR

  # I use the definitino file as the sample file in TestCELL class.
  class TestCELL < Test::Unit::TestCase

    def setup
      str =<<EOS
AC   Accession no.
XX
DT   Date; author
XX
SO   Factor source
XX
OS   Species
XX
CD   Cell description
XX
BS   Site detected with this factor source
XX
DR   CLDB: accession no.;
XX
DR   TRANSCOMPEL: accession no.;
XX
EOS
      #filename = File.join(BioRubyTestDataPath, 'transfac/G00003.emb')
      #@obj = Bio::TRANSFAC::CELL.new(File.read(filename))
      @obj = Bio::TRANSFAC::CELL.new(str)
    end

    def test_cd
      assert_equal("Cell description", @obj.cd)
    end
  end #CELL
    #I use the definition file as sample file in TestCLASS class
    class TestCLASS < Test::Unit::TestCase

    def setup
      str =<<EOS
AC   Accession no.
XX
ID     Identifier (class code)
XX
DT     Date; author
XX
CL     Class; link to node in the hierarchical classification
XX
SD     Structure description
XX
CC     Comments
XX
BF     Factors belonging to this class
XX
RX     MEDLINE ID
RN     Reference no.
RA     Reference authors
RT     Reference title
RL     Reference data
XX
DR     PROSITE accession numbers
XX
EOS
      #filename = File.join(BioRubyTestDataPath, 'transfac/G00003.emb')
      #@obj = Bio::TRANSFAC::CLASS.new(File.read(filename))
      @obj = Bio::TRANSFAC::CLASS.new(str)
    end

    def test_cl
      assert_equal("Class; link to node in the hierarchical classification", @obj.cl)
    end

    def test_sd
      assert_equal("Structure description", @obj.sd)
    end

    def test_bf
      assert_equal("Factors belonging to this class", @obj.bf)
    end

    def test_dr
      assert_equal("PROSITE accession numbers", @obj.dr)
      #assert_equal("EMBL: X02996; AD5001. TRANSPATH: G000003.", @obj.dr)
    end
  end #CLASS
   class TestGENE < Test::Unit::TestCase

    def setup
      filename = File.join(BioRubyTestDataPath, 'transfac/G00003.emb')
      @obj = Bio::TRANSFAC::GENE.new(File.read(filename))
    end

    def test_sd
      assert_equal("E1A", @obj.sd)
    end

    def test_de
      assert_equal("early gene 1A", @obj.de)
    end

    def test_bc
      assert_equal("6.3.3.2", @obj.bc)
    end

    def test_bs
      expected = "-498 -458 R01988; AD5$E1A_12; Binding factors: NF-1 T00539. -464 -452 R01989; AD5$E1A_13; Binding factors: POU2F1 T00641. -450 -428 R01990; AD5$E1A_14; Binding factors: ATF T00051. -420 -391 R01991; AD5$E1A_15; Binding factors: Sp1 T00759. -414 -391 R01992; AD5$E1A_16; Binding factors: ATF T00051. -394 -375 R01993; AD5$E1A_17; Binding factors: PEA3 T00685. -384 -363 R01994; AD5$E1A_18. -346 -334 R01995; AD5$E1A_19; Binding factors: PEA3 T00685. -338 -319 R01997; AD5$E1A_21; Binding factors: ATF T00051. -319 -305 R01998; AD5$E1A_22. -304 -289 R01999; AD5$E1A_23; Binding factors: GABP-alpha T01390, GABP-alpha:GABP-beta T00268, PEA3 T00685. -291 -278 R00310; AD5$E1A_04; Binding factors: E2F T00221. -273 -257 R01996; AD5$E1A_20; Binding factors: GABP-alpha T01390, GABP-alpha:GABP-beta T00268, PEA3 T00685. -228 -214 R00311; AD5$E1A_05; Binding factors: E2F T00221, E2F+E4 T00232. -197 -181 R02001; AD5$E1A_25; Binding factors: POU2F1 T00641. -178 -165 R02002; AD5$E1A_26. -99 -91 R02003; AD5$E1A_27. -83 -36 R02004; AD5$E1A_28. -72 -45 R02005; AD5$E1A_29. -52 -21 R00309; AD5$E1A_03; Binding factors: CREB T00163. -38 -21 R02006; AD5$E1A_30. -25 34 R02007; AD5$E1A_31. -12 9 R02008; AD5$E1A_32."
      assert_equal(expected, @obj.bs)
    end

    def test_co
      assert_equal("Copyright (C), Biobase GmbH.", @obj.co)
    end

    def test_tr
      assert_equal("", @obj.tr)
    end
  end #GENE

end #TRANSFAC

end #module Bio

