Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AABC3ABC3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 May 2025 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c25IGzfhqT72XMlC3SiVE1HRNCACKG/C51+sZtxCgoc=; b=hrEi0IKSXnUq7gNUXcLj4RpMJg
	trEOsKiqrCPAaobawPnAMzfUZnNQDLt2wlSe5MShk5Mra1g9Fqg8rCk99WffzDZq+D/JfcEG7wJER
	IPRgB/Wruc/cvLvKcsNmT8ShUXC5gd1g5Qu4RiLFGyejnycZiDHVDCywi/UvwYYfkcQY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uEoch-0003dz-Vf;
	Tue, 13 May 2025 12:20:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1uEocg-0003ds-7m
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 May 2025 12:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jlORhZIko7JOXl1TC+wF406r6mAvX0kAjFNdGkuXhfk=; b=I8biWHIICkOuNlmhHZPBolEdiE
 NUg5chYI1nbUKlINORRJWYTSL3YlPn1pyGWKIA3G4Q2fxvbuiUQmV+HUesZL1OZUFABj71Lwrly6V
 29kWYbcih1q95aAAP7mYo+vy3f/REgcDOXblkljllW1L4TJmPtrS9BVUqvyluwHV466Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jlORhZIko7JOXl1TC+wF406r6mAvX0kAjFNdGkuXhfk=; b=d
 9BQMqJD+kHw4Pw/UDQHVk+m5i5rzhl3RJcXNC3Q3nmS5L6c9jgu1EnqDNGiuzDjO0odhwBbc43jqe
 xH710U09+4Q9jx9Fpg08meeYywBySNjE8QKxf741zz4SC5elRhHa1LNRR1h2kuBX0GXb02etkFZWu
 /G/P2yTDgXT/pCI4=;
Received: from mgamail.intel.com ([192.198.163.15])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uEocc-00065D-C0 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 May 2025 12:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747138834; x=1778674834;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=Ybutf2ZA0+rRTJ80CH2hJeSazzgT4qAWA0r4s/tfjQM=;
 b=HEUpjNLVmGD0Wq3ONeDRtkykzoSpKXSQDURM5RREZ7kIcRvTcv05RZyg
 RjznfEKfNEi1+WvIdncO8FNQjbJfVpUYSvUXxYJCzA1K4AuRzuLTrlXkS
 Y7cDnvDs3k04sVqWcZCfBNgQGjjGtsMZUkhpVfEsLvS0kXCjBCXi6tHW3
 FovH/nSu+neDDygoTLPyaBoCAKj6ZEvGAQiab7OU31Nynztug235cVov0
 Stcd015IxLdbMqob3lC9JnY/y8iHnKnTi1iRvv3mcMmYkFI+a80ZER31V
 wmp/XDr/J3T2mRg9KZZrxsCJ2FwFgs18AkdOL0fjOHdaSTlwPubjudrsI w==;
X-CSE-ConnectionGUID: CW0tePIwS26r/uG7SIozaw==
X-CSE-MsgGUID: kUWJK/hWSm2KJsGW+yHjmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="49127381"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; d="scan'208";a="49127381"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 05:20:24 -0700
X-CSE-ConnectionGUID: 5o298X1LR6iFqCuV/bBBtg==
X-CSE-MsgGUID: gYqTXkO0RfeLl189ltJQGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; d="scan'208";a="137578854"
Received: from igk-lkp-server01.igk.intel.com (HELO b9ffd1689040)
 ([10.211.3.150])
 by fmviesa006.fm.intel.com with ESMTP; 13 May 2025 05:20:22 -0700
Received: from kbuild by b9ffd1689040 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1uEocO-0000yM-0Z;
 Tue, 13 May 2025 12:20:20 +0000
Date: Tue, 13 May 2025 20:20:06 +0800
From: kernel test robot <lkp@intel.com>
To: Hongbo Li <lihongbo22@huawei.com>
Message-ID: <202505132038.wjQGfZCG-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1uEocc-00065D-C0
Subject: [f2fs-dev] [jaegeuk-f2fs:dev-test 188/191] fs/f2fs/super.c:5283:6:
 warning: unused variable 'i'
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, llvm@lists.linux.dev,
 linux-f2fs-devel@lists.sourceforge.net, Eric Sandeen <sandeen@redhat.com>,
 oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
head:   7274f75b0d876f1cc87349fe8e5c8b45f90695c5
commit: 33605141d92b1eb2a5e625a79abe35856a588662 [188/191] f2fs: switch to the new mount api
config: i386-buildonly-randconfig-2003-20250513 (https://download.01.org/0day-ci/archive/20250513/202505132038.wjQGfZCG-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250513/202505132038.wjQGfZCG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505132038.wjQGfZCG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/f2fs/super.c:5283:6: warning: unused variable 'i' [-Wunused-variable]
    5283 |         int i;
         |             ^
   fs/f2fs/super.c:370:20: warning: unused function 'ctx_set_flags' [-Wunused-function]
     370 | static inline void ctx_set_flags(struct f2fs_fs_context *ctx,
         |                    ^~~~~~~~~~~~~
   2 warnings generated.


vim +/i +5283 fs/f2fs/super.c

  5279	
  5280	static void f2fs_fc_free(struct fs_context *fc)
  5281	{
  5282		struct f2fs_fs_context *ctx = fc->fs_private;
> 5283		int i;
  5284	
  5285		if (!ctx)
  5286			return;
  5287	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
