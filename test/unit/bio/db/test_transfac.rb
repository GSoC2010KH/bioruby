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
      filename = File.join(BioRubyTestDataPath, 'transfac/G00003.emb')
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

=begin



    def test_initialize
      assert_equal(nil, @obj.initialize)
    end

    def test_cd
      assert_equal(nil, @obj.cd)
    end

    def test_initialize
      assert_equal(nil, @obj.initialize)
    end

    def test_cl
      assert_equal(nil, @obj.cl)
    end

    def test_sd
      assert_equal(nil, @obj.sd)
    end

    def test_bf
      assert_equal(nil, @obj.bf)
    end

    def test_dr
      assert_equal(nil, @obj.dr)
    end

    def test_initialize
      assert_equal(nil, @obj.initialize)
    end

    def test_sd
      assert_equal(nil, @obj.sd)
    end

    def test_de
      assert_equal(nil, @obj.de)
    end

    def test_bc
      assert_equal(nil, @obj.bc)
    end

    def test_bs
      assert_equal(nil, @obj.bs)
    end

    def test_co
      assert_equal(nil, @obj.co)
    end

    def test_tr
      assert_equal(nil, @obj.tr)
    end
=end
  end #class TestBioTRANSFAC

  #The following test classes need the other sample files?
  #alomost all the methods output empty values.
   class TRANSFAC
     # need
     class TestMATRIX < Test::Unit::TestCase
    def setup
      filename = File.join(BioRubyTestDataPath, 'transfac/G00003.emb')
      @obj = Bio::TRANSFAC::MATRIX.new(File.read(filename))
    end

    def test_na
      assert_equal("", @obj.na)
    end

    def test_de
      assert_equal("early gene 1A", @obj.de)
    end

    def test_bf
      assert_equal("", @obj.bf)
    end

    def test_ma
      assert_equal(Matrix[], @obj.ma)
    end

    def test_ba
      assert_equal("", @obj.ba)
    end

    end #TestMATRIX

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

  class TestFACTOR < Test::Unit::TestCase

    def setup
      filename = File.join(BioRubyTestDataPath, 'transfac/G00003.emb')
      @obj = Bio::TRANSFAC::FACTOR.new(File.read(filename))
    end

    def test_fa
      assert_equal("", @obj.fa)
    end

    def test_sy
      assert_equal("", @obj.sy)
    end

    def test_dr
      assert_equal("EMBL: X02996; AD5001. TRANSPATH: G000003.", @obj.dr)
    end

    def test_ho
      assert_equal("", @obj.ho)
    end

    def test_cl
      assert_equal("", @obj.cl)
    end

    def test_sz
      assert_equal("", @obj.sz)
    end

    def test_sq
      assert_equal("", @obj.sq)
    end

    def test_sc
      assert_equal("", @obj.sc)
    end

    def test_ft
      assert_equal("", @obj.ft)
    end

    def test_sf
      assert_equal("", @obj.sf)
    end

    def test_cp
      assert_equal("", @obj.cp)
    end

    def test_cn
      assert_equal("", @obj.cn)
    end

    def test_ff
      assert_equal("", @obj.ff)
    end

    def test_in
      assert_equal("", @obj.in)
    end

    def test_mx
      assert_equal("", @obj.mx)
    end

    def test_bs
      expected = "-498 -458 R01988; AD5$E1A_12; Binding factors: NF-1 T00539. -464 -452 R01989; AD5$E1A_13; Binding factors: POU2F1 T00641. -450 -428 R01990; AD5$E1A_14; Binding factors: ATF T00051. -420 -391 R01991; AD5$E1A_15; Binding factors: Sp1 T00759. -414 -391 R01992; AD5$E1A_16; Binding factors: ATF T00051. -394 -375 R01993; AD5$E1A_17; Binding factors: PEA3 T00685. -384 -363 R01994; AD5$E1A_18. -346 -334 R01995; AD5$E1A_19; Binding factors: PEA3 T00685. -338 -319 R01997; AD5$E1A_21; Binding factors: ATF T00051. -319 -305 R01998; AD5$E1A_22. -304 -289 R01999; AD5$E1A_23; Binding factors: GABP-alpha T01390, GABP-alpha:GABP-beta T00268, PEA3 T00685. -291 -278 R00310; AD5$E1A_04; Binding factors: E2F T00221. -273 -257 R01996; AD5$E1A_20; Binding factors: GABP-alpha T01390, GABP-alpha:GABP-beta T00268, PEA3 T00685. -228 -214 R00311; AD5$E1A_05; Binding factors: E2F T00221, E2F+E4 T00232. -197 -181 R02001; AD5$E1A_25; Binding factors: POU2F1 T00641. -178 -165 R02002; AD5$E1A_26. -99 -91 R02003; AD5$E1A_27. -83 -36 R02004; AD5$E1A_28. -72 -45 R02005; AD5$E1A_29. -52 -21 R00309; AD5$E1A_03; Binding factors: CREB T00163. -38 -21 R02006; AD5$E1A_30. -25 34 R02007; AD5$E1A_31. -12 9 R02008; AD5$E1A_32."
      assert_equal(expected, @obj.bs)
    end
  end #FACTOR
  class TestCELL < Test::Unit::TestCase

    def setup
      filename = File.join(BioRubyTestDataPath, 'transfac/G00003.emb')
      @obj = Bio::TRANSFAC::CELL.new(File.read(filename))
    end

    def test_cd
      assert_equal("", @obj.cd)
    end
  end #CELL
    class TestCLASS < Test::Unit::TestCase

    def setup
      filename = File.join(BioRubyTestDataPath, 'transfac/G00003.emb')
      @obj = Bio::TRANSFAC::CLASS.new(File.read(filename))
    end

    def test_cl
      assert_equal("", @obj.cl)
    end

    def test_sd
      assert_equal("E1A", @obj.sd)
    end

    def test_bf
      assert_equal("", @obj.bf)
    end

    def test_dr
      assert_equal("EMBL: X02996; AD5001. TRANSPATH: G000003.", @obj.dr)
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

