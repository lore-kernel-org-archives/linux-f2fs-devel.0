Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7A606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CKqPn+B4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FfXDx4uP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=c1fT33i4;
	dkim=neutral header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l/mm4HEd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=7yDjAq30dr+SQw5nYYiwGmsqCvS83fuxEnUZQLjNHyU=; b=CKqPn+B4lWKRdMQtbgSv3SkiIB
	fJiD4bxdwUf8rkGBaO7HdepbeCFPRna+Hjupjbv8hFWSOzqW7gVLmglpW/uqMpvXQ+79AaRdUB95V
	bSovpldPyCx7gcL2YKHbew9yz8oBL4vuzZi9kS0WrUMH08WBFqn/h8fIH49V3dYaM2Zs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSzWb-00000000569-1pKx;
	Mon, 16 Nov 2026 16:25:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <lkp@intel.com>) id 1xSzWK-0000000055v-1DNy
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 16:25:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Owf9XUNd00WhrvxRkjSR8nMAd1e7fEWIc20Fa4z88JQ=; b=FfXDx4uPInejq08gorY4k7etrK
 8eQ6uUtQAE3+T88i0MjmRU66dAR7AZ+npQLpXpstepNCKjasjtrgAN8ZCnyzNn4Py6jG147nHbwl3
 pzwonP14yGBTe4FAFtpPRH9jnw7EixmgBMALKYJRPCnLJWBa+rW6pBq1aBFn8WjWkyR4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Owf9XUNd00WhrvxRkjSR8nMAd1e7fEWIc20Fa4z88JQ=; b=c1fT33i4ZKJvtE9n5DzVK+oOx3
 nTgeRQp85Ex8xfyBrAcD5KPkBR0aURbCY1DZmR5TMqslKsChBKUQrX4P2QzPiAuFkxP7qTvLoduql
 oyII7F/BuBp586rYDwGkvFYgPu0axBFd3CyP26SP9YcXiXUKyU92yta2dbokcf/pIHU4=;
Received: from mgamail.intel.com ([192.198.163.11])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSzWI-000000000fX-2HX5
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 16:25:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794846327; x=1826382327;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zq/0cVXACAhVV1O2zrEpFTBhCFeoln5zUktT7z+NI5Q=;
 b=l/mm4HEdho5Dg+A1w16uylYEmWjtpAjIHEAaWwUBYtM6faxWAPYJitFo
 0tJxTH19kFpb2CeY8/71564OO4aVkw0PDrKVRQuDo6O75PsFOUO6SfLMZ
 +SVkHqgxNB7PvE6kI3uQJajNo3b3SofkfPHyXka8ThhpL7kEbA1BVOJft
 UrNSayb/z0t6JtNo0KAaop1S6FyYyUyFSfzlTOE/QRKZHMMmR9e6uAvMN
 8MTkCcSKgJ08T5MtPtszQiL3iluPmHpViyA7M+MYtgXtVLBS56Bbqpddm
 HwQKXZX3/zi1rGedwWV4X+LU7HdQoS0RmGNFYt3sf2deTboPbJq8o2kq0 A==;
X-CSE-ConnectionGUID: DIpCIq5dQiiHmV3uREw0+w==
X-CSE-MsgGUID: +MgxEmIkTQSf3jhn0nBawg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3510034"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3510034"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 08:25:21 -0800
X-CSE-ConnectionGUID: yHe9RphfTpil+Sr7ndTo+A==
X-CSE-MsgGUID: 2K8F7cAKS2GT+qLfrgyqhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9785125"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa009.jf.intel.com with ESMTP; 16 Nov 2026 08:25:18 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xSzW8-000000018yK-1SGL;
 Mon, 16 Nov 2026 16:25:16 +0000
Date: Tue, 17 Nov 2026 00:24:35 +0800
From: kernel test robot <lkp@intel.com>
To: huang zheng <huangzheng9869@gmail.com>, jaegeuk@kernel.org, chao@kernel.org
Message-ID: <202611170005.Q9ISJ71Q-lkp@intel.com>
References: <20261116095011.2868219-1-huangzheng9869@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261116095011.2868219-1-huangzheng9869@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xSzWI-000000000fX-2HX5
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
Cc: Huang Zheng <huangzheng9869@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, huangzheng1@xiaomi.com,
 linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
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
config: i386-buildonly-randconfig-1000-20261116 (https://download.01.org/0day-ci/archive/20261117/202611170005.Q9ISJ71Q-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261117/202611170005.Q9ISJ71Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611170005.Q9ISJ71Q-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/f2fs/checkpoint.c: In function 'check_cp_time':
>> fs/f2fs/checkpoint.c:1744:17: error: implicit declaration of function 'update_cp_stats'; did you mean 'update_ckpt_flags'? [-Wimplicit-function-declaration]
    1744 |                 update_cp_stats(sbi, cpc);
         |                 ^~~~~~~~~~~~~~~
         |                 update_ckpt_flags


vim +1744 fs/f2fs/checkpoint.c

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
