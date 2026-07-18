Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405D2C4451B
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 18 Jul 2026 07:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u67UbB2uhvxRWCPYIEEo2iPZiMhL/9IaY7jls436Ops=; b=YBUv1Wy7+Ot7L5VMn894d9liz1
	2xJR4HHrTY6kkahbnl0Lt91SHgm2o/rmPlTZut/qAzBigKTcpswPrAy673c2jost78FArgW7/hpKw
	ADzCU8fmVlbKJINhn1mb8Y9M/FahyPIVwncEse17TfZqnhbeaDLz5BJDoMHX6DtW4XiI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wkzr9-0008PD-Ex;
	Sat, 18 Jul 2026 07:53:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1wkzr7-0008P5-KF
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 07:53:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k0UP1d7Tmbi9qCZ2vJ028F5Kp4gCi9az9RhbcAAGFnU=; b=ZQTCwdHmPn3OZbPfbHNfRDMNuc
 nEA/q0fLFLfz3h1qn0qBy++ZZ9w9lAB0aqAyejl3vMeKQV3++GvQoqz1Y6HaZOpDueJJIFaSYpj0y
 zqIhli2hbxsqGOhU5hLR8y28UxCJe8QaxY8EPOrDgBF+jLtZvqBWyew0fh8Zcs5RA74w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=k0UP1d7Tmbi9qCZ2vJ028F5Kp4gCi9az9RhbcAAGFnU=; b=a7SRvRlMCKAUGjrZPE8A1UTV0x
 8KFhfYeYtjrQqn+Ws0/WpSiLPPoBqWJ/O+9qP86ZVSHt9OPbr71FTDMili+JGBBrG3/LqkIclKDlC
 V3d+m9cpp51+TYU4WERnGj9ms0q3dt8pnVtL1kDc8zMWX7LZayjOoZeju1/E6Fllc/CI=;
Received: from mgamail.intel.com ([192.198.163.19])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wkzr7-0004Ch-9E for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 07:53:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784361185; x=1815897185;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=usp4xS76WrIMBZsPgWMPfQLaX/5OcCg0dIj3qNtrdlU=;
 b=HSsLrxQcjiaa8aE0v1NEoa9fB2bqn3osWW8zdbQQl7J7oAz2TG2bf5oi
 pwC6uNqVoCPTREO3DpSrHEhm2QZDfsD0dHelUZNI6rZhT9zSOKT+kaRiz
 NOMKP2gm7TeoIwCqZdUv/pTuPcl1AMTcuMyaUtUOtEyGeM91qa+yw51f/
 fYUNeIs8hlYMWBTac38tWkj2CiFekEubpc6LGfq1dxIX/zmqvWq+D14h0
 ntppEPnCZjaC/2u6fszfOCwgoZ9yEPjngMEaCFsc/6m8peBKehUEFI9H5
 16NwCxMY42ZnDHhfFaUayRgMcTmJPBZnamMUv+JtAQgdUlMVl4OEVoujJ g==;
X-CSE-ConnectionGUID: 1uADADk/Sxq7TE3bBQZoaA==
X-CSE-MsgGUID: 9sCyNCtGRk22SPQxG+tTqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="84004321"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; d="scan'208";a="84004321"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2026 00:52:12 -0700
X-CSE-ConnectionGUID: q3MvSoYmSUS3UFc1e5d6Zg==
X-CSE-MsgGUID: Mcy5IvL5R7mdhJgb5RSr7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; d="scan'208";a="261948990"
Received: from igk-lkp-server01.igk.intel.com (HELO e5a8ed462067)
 ([10.211.93.152])
 by fmviesa005.fm.intel.com with ESMTP; 18 Jul 2026 00:52:09 -0700
Received: from kbuild by e5a8ed462067 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wkzqB-000000005kH-33kf;
 Sat, 18 Jul 2026 07:52:07 +0000
Date: Sat, 18 Jul 2026 09:51:48 +0200
From: kernel test robot <lkp@intel.com>
To: Yonggil Song <yonggil.song@samsung.com>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "chao@kernel.org" <chao@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
Message-ID: <202607180917.doNNtTXN-lkp@intel.com>
References: <20260706062043epcms2p16928216befdca1242bc2d3cd7cb34afe@epcms2p1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260706062043epcms2p16928216befdca1242bc2d3cd7cb34afe@epcms2p1>
X-Headers-End: 1wkzr7-0004Ch-9E
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce gcless mount option to avoid
 foreground GC
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, oe-kbuild-all@lists.linux.dev,
 Seokhwan Kim <sukka.kim@samsung.com>, Dongjin Kim <dongjin_.kim@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Yonggil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cb8ff3ead9a3fc43727980be58c7099506f65261]

url:    https://github.com/intel-lab-lkp/linux/commits/Yonggil-Song/f2fs-introduce-gcless-mount-option-to-avoid-foreground-GC/20260706-154229
base:   cb8ff3ead9a3fc43727980be58c7099506f65261
patch link:    https://lore.kernel.org/r/20260706062043epcms2p16928216befdca1242bc2d3cd7cb34afe%40epcms2p1
patch subject: [PATCH] f2fs: introduce gcless mount option to avoid foreground GC
config: i386-randconfig-2006-20250825 (https://download.01.org/0day-ci/archive/20260718/202607180917.doNNtTXN-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260718/202607180917.doNNtTXN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607180917.doNNtTXN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/bits.h:5,
                    from include/linux/bitops.h:6,
                    from include/linux/log2.h:12,
                    from arch/x86/include/asm/div64.h:8,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/fs_dirent.h:5,
                    from include/linux/fs/super_types.h:5,
                    from include/linux/fs/super.h:5,
                    from include/linux/fs.h:5,
                    from fs/f2fs/dir.c:9:
   fs/f2fs/f2fs.h: In function 'inc_valid_node_count':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/f2fs/f2fs.h:150:33: note: in expansion of macro 'BIT'
     150 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~
   fs/f2fs/f2fs.h:2945:25: note: in expansion of macro 'test_opt'
    2945 |                         test_opt(sbi, RESERVE_NODE));
         |                         ^~~~~~~~
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/f2fs/f2fs.h:150:33: note: in expansion of macro 'BIT'
     150 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~
   fs/f2fs/f2fs.h:2953:13: note: in expansion of macro 'test_opt'
    2953 |         if (test_opt(sbi, RESERVE_NODE) &&
         |             ^~~~~~~~
--
   In file included from include/linux/bits.h:5,
                    from include/linux/ratelimit_types.h:5,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:31,
                    from arch/x86/include/asm/bug.h:193,
                    from arch/x86/include/asm/alternative.h:9,
                    from arch/x86/include/asm/barrier.h:5,
                    from include/linux/list.h:11,
                    from include/linux/module.h:12,
                    from fs/f2fs/super.c:8:
   fs/f2fs/f2fs.h: In function 'inc_valid_node_count':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/f2fs/f2fs.h:150:33: note: in expansion of macro 'BIT'
     150 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~
   fs/f2fs/f2fs.h:2945:25: note: in expansion of macro 'test_opt'
    2945 |                         test_opt(sbi, RESERVE_NODE));
         |                         ^~~~~~~~
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/f2fs/f2fs.h:150:33: note: in expansion of macro 'BIT'
     150 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~
   fs/f2fs/f2fs.h:2953:13: note: in expansion of macro 'test_opt'
    2953 |         if (test_opt(sbi, RESERVE_NODE) &&
         |             ^~~~~~~~
   fs/f2fs/super.c: In function 'limit_reserve_root':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/f2fs/f2fs.h:150:33: note: in expansion of macro 'BIT'
     150 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~
   fs/f2fs/super.c:520:13: note: in expansion of macro 'test_opt'
     520 |         if (test_opt(sbi, RESERVE_NODE) &&
         |             ^~~~~~~~
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/f2fs/f2fs.h:150:33: note: in expansion of macro 'BIT'
     150 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~
   fs/f2fs/super.c:526:46: note: in expansion of macro 'test_opt'
     526 |         if (!test_opt(sbi, RESERVE_ROOT) && !test_opt(sbi, RESERVE_NODE) &&
         |                                              ^~~~~~~~
   fs/f2fs/super.c: In function 'f2fs_check_opt_consistency':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/f2fs/f2fs.h:150:33: note: in expansion of macro 'BIT'
     150 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~
   fs/f2fs/super.c:1528:13: note: in expansion of macro 'test_opt'
    1528 |         if (test_opt(sbi, RESERVE_NODE) &&
         |             ^~~~~~~~
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/f2fs/super.c:1529:42: note: in expansion of macro 'BIT'
    1529 |                         (ctx->opt_mask & BIT(F2FS_MOUNT_RESERVE_NODE)) &&
         |                                          ^~~
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/f2fs/super.c:1534:35: note: in expansion of macro 'BIT'
    1534 |                 ctx->opt_mask &= ~BIT(F2FS_MOUNT_RESERVE_NODE);
         |                                   ^~~
   fs/f2fs/super.c: In function 'f2fs_show_options':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/f2fs/f2fs.h:150:33: note: in expansion of macro 'BIT'
     150 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~
   fs/f2fs/super.c:2475:44: note: in expansion of macro 'test_opt'
    2475 |         if (test_opt(sbi, RESERVE_ROOT) || test_opt(sbi, RESERVE_NODE))
         |                                            ^~~~~~~~


vim +7 include/vdso/bits.h

3945ff37d2f48d Vincenzo Frascino 2020-03-20  6  
3945ff37d2f48d Vincenzo Frascino 2020-03-20 @7  #define BIT(nr)			(UL(1) << (nr))
cbdb1f163af2bb Andy Shevchenko   2022-11-28  8  #define BIT_ULL(nr)		(ULL(1) << (nr))
3945ff37d2f48d Vincenzo Frascino 2020-03-20  9  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
