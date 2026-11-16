Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD11606A339
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WamUjgJZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lk2Lbt/X;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MSMGmIDR;
	dkim=neutral header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IKpTrJfS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=Qe4jNcIOPSjlJ6ykPrW8gQNViyORQFLy5oCiPvbX1Vs=; b=WamUjgJZsyHyBBHoGrCh/yG1f9
	p/B5Ev2l2SLLfP8o9sL1bvQrYMcDM8UNyGJsYkiXE8vfjXOtxJ58Zu5RgXbVXG5BpIwNGjPPAWEOT
	CHsahSt9ymKiX/mBnBpp1Hr5Kf4pB5rjWHMi4LvGy6sotgUQv4BhMSbLtRA0psX+xBSM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xT3fQ-000000001yE-1fAP;
	Mon, 16 Nov 2026 20:51:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <lkp@intel.com>) id 1xT3fO-000000001y7-2uff
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 20:51:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mF+5LJPny8StaD39CFoDqff04cfc3UL1BENucKw5erQ=; b=lk2Lbt/XbJC/gFuYzDMrrMMYAD
 kFYo39Ei0bKmI2o9DMK8glO2W1Sfz8tPKN/LPSSS9KZnKKmj3sbjr4JEHD91NcT1Mm+wNcxz4pcJL
 gnbmHUZGoE05wB7FnGjBXJ2JqsnXLtl4CFIHoZrT2yp4Y4WmVnS+IRO+TlAIedEXMgjw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mF+5LJPny8StaD39CFoDqff04cfc3UL1BENucKw5erQ=; b=MSMGmIDRnPH9yz/CaK9Nl7RXk7
 j2zI71ESHZ8WfwENQb8ClZaKaLrYyFnOQwWplnBL2x7yI5o9l1L/AbL4jlP68UaqIa5IIUDxowUow
 d0hQRmgON9G77nr1cLUVVYGPd4ySvIJSSlsEZhr8XxwzBjOa4dTrmIz5QSJA9A2uHF9s=;
Received: from [198.175.65.17] (helo=mgamail.intel.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xT3fL-000000000lY-1xR0
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 20:51:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794862263; x=1826398263;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NGPITMRExA4k1FsoRlFIhpMvIupdLuYZuYltGtidHuE=;
 b=IKpTrJfSGUL+xgEVfVZDWFxJasNy8RVzo2i5zLgvYsKxylph+W2r8WKb
 tFvT+co67DR/kd+qmgUterv+wC5decVKMsZq8UWsuCnEJXqI8ibDuuB9n
 dDJuLqCEr2FIjHv9l7kX/xBzgTOGIdf/SnwuFd/sK0Ok/oii0rfjhOL57
 6awlKctQZB3710rrDXsOknzb8skNA0lvzrj1jxDkl4SnSZL7PKk57RjUp
 n7FWDWZZACg74YOynfGdGweyIEYIHIzU2nARUl7z6m63+VPGeM1EtK35r
 V6YLJt1PSKHpTCSZcz5isbyEhKFT1inWcfxWK7ip0ABQUXL4hkpq1LDOU Q==;
X-CSE-ConnectionGUID: kyyUNHFkQmC4el4EqvkXsg==
X-CSE-MsgGUID: PFsHLBFDQQig9YuOlJ043w==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3627626"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3627626"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 12:50:58 -0800
X-CSE-ConnectionGUID: 3br2HG2yQbaqG5uDAy28jQ==
X-CSE-MsgGUID: 7pnb/xcOSci17EykFV5phg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9660346"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa002.jf.intel.com with ESMTP; 16 Nov 2026 12:50:56 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xT3fB-000000019PN-24hQ;
 Mon, 16 Nov 2026 20:50:53 +0000
Date: Tue, 17 Nov 2026 04:50:38 +0800
From: kernel test robot <lkp@intel.com>
To: huang zheng <huangzheng9869@gmail.com>, jaegeuk@kernel.org, chao@kernel.org
Message-ID: <202611170426.9bqr9xq4-lkp@intel.com>
References: <20261116095011.2868219-1-huangzheng9869@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261116095011.2868219-1-huangzheng9869@gmail.com>
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xT3fL-000000000lY-1xR0
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add checkpoint step timing
 statistics to debugfs
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Huang Zheng <huangzheng9869@gmail.com>, llvm@lists.linux.dev,
 huangzheng1@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi huang,

kernel test robot noticed the following build errors:

[auto build test ERROR on jaegeuk-f2fs/dev-test]
[also build test ERROR on jaegeuk-f2fs/dev linus/master v7.4-rc3 next-20261113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/huang-zheng/f2fs-add-checkpoint-step-timing-statistics-to-debugfs/20261116-175011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20261116095011.2868219-1-huangzheng9869%40gmail.com
patch subject: [PATCH v2] f2fs: add checkpoint step timing statistics to debugfs
config: i386-randconfig-1010-20261116 (https://download.01.org/0day-ci/archive/20261117/202611170426.9bqr9xq4-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261117/202611170426.9bqr9xq4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611170426.9bqr9xq4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/f2fs/checkpoint.c:1744:3: error: call to undeclared function 'update_cp_stats'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1744 |                 update_cp_stats(sbi, cpc);
         |                 ^
   fs/f2fs/checkpoint.c:1744:3: note: did you mean 'update_ckpt_flags'?
   fs/f2fs/checkpoint.c:1616:13: note: 'update_ckpt_flags' declared here
    1616 | static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
         |             ^
   1 error generated.


vim +/update_cp_stats +1744 fs/f2fs/checkpoint.c

  1732	
  1733	static inline void check_cp_time(struct f2fs_sb_info *sbi, struct cp_control *cpc)
  1734	{
  1735		unsigned long long sb_diff, cur_diff;
  1736		enum cp_time ct;
  1737	
  1738		sb_diff = (u64)ktime_ms_delta(sbi->cp_stats.times[CP_TIME_END],
  1739						sbi->cp_stats.times[CP_TIME_START]);
  1740		cur_diff = (u64)ktime_ms_delta(cpc->stats.times[CP_TIME_END],
  1741						cpc->stats.times[CP_TIME_START]);
  1742	
  1743		if (cur_diff > sb_diff) {
> 1744			update_cp_stats(sbi, cpc);
  1745			if (cur_diff < CP_LONG_LATENCY_THRESHOLD)
  1746				return;
  1747	
  1748			f2fs_warn(sbi, "checkpoint was blocked for %llu ms", cur_diff);
  1749			for (ct = CP_TIME_START; ct < CP_TIME_MAX - 1; ct++)
  1750				f2fs_warn(sbi, "Step#%d: %llu ms", ct,
  1751					(u64)ktime_ms_delta(cpc->stats.times[ct + 1],
  1752							cpc->stats.times[ct]));
  1753		}
  1754	}
  1755	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
