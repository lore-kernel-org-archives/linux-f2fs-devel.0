Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D55C3600C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:11:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u0MEX-0004xS-CB;
	Thu, 03 Apr 2025 15:11:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1u0MEQ-0004xD-70
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Apr 2025 15:11:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XkMHED6hlGcNmdkXoMK1XFizA8QVeHA9ipiihRDap5A=; b=msRaGTlhsaz9iGL5Q4/TU3Jj92
 91Y5VJUfRzKRpQX1jxUSlLMC90aUU1faDecEmIBAtErxo75UVgvt8haIATwnto5QqHPmFq/5W5JVZ
 15X969Jezs/alUTX+IEdr5GANKETFOxdHpdKpq3jacmZFJZ44rBdhi2ROYsAaQSjJclc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XkMHED6hlGcNmdkXoMK1XFizA8QVeHA9ipiihRDap5A=; b=Y+twoo2cFyF5lI+yo+PHOAELMl
 Vh27hazwSLZlao5BvLX6xZW+zCcxLRsMLQA4MgCmibZnVw16N9YdTzEZhAu9oFRmzSo8s+d7oDzZ/
 ADG+ayg9z/zBUASPMsnqSqsaQc+jhVjaEby1nu5h6E/gHVJ2RvY+uTldlfGov15iSAbY=;
Received: from mgamail.intel.com ([192.198.163.9])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u0ME6-0006VL-B3 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Apr 2025 15:11:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743693090; x=1775229090;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pazXNSNFRwcbem0gEd5+HAWBBg0Pc62HTCAJjOo1360=;
 b=Dle45rRFgTY1KmlwZd+bMVuaBzEN/q2ZUsEb4odFzxYQ5wqdwrPD9Qgr
 vY3gjiPkG/9U2fVlNO3E/eEoJvC13t8ljnl3ewyc1meXU+M0rpLPT2prx
 REkPAbRb6oC3msqztmWUsDTE5GzZZmMFvmUk02tysfOAWnJPZLAAVT2Xa
 TemkyYgNX8CGdWXKQhLfgqsqSQYtkJnglIRuhaqyPnO2YJEU87vPAoe2o
 znsfPGvPHqGiRDOueyMDoDQfCwIr4UQnTeYgY4z94jI0aw61qsqXMgNwH
 zKbw4PLqIHw7uCUAft5U0PgWZoJQehQrbEg+ifC8xBjIZF+fH5PPcZExO w==;
X-CSE-ConnectionGUID: EmrAGRz6Tz2otidY0cX/jw==
X-CSE-MsgGUID: jK4MGkMUQ5eXhw2EvEkMKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="55738650"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; d="scan'208";a="55738650"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2025 08:11:25 -0700
X-CSE-ConnectionGUID: TzyCgRpwS9Ci2czWVDkHYw==
X-CSE-MsgGUID: ihRpxO2bRmmQt9iUym/Wvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; d="scan'208";a="132242656"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
 by orviesa005.jf.intel.com with ESMTP; 03 Apr 2025 08:11:22 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1u0MDu-0000V7-2v;
 Thu, 03 Apr 2025 15:11:18 +0000
Date: Thu, 3 Apr 2025 23:11:12 +0800
From: kernel test robot <lkp@intel.com>
To: "yohan.joung" <yohan.joung@sk.com>, jaegeuk@kernel.org, chao@kernel.org
Message-ID: <202504032206.xzJoHkRX-lkp@intel.com>
References: <20250403071016.2940-1-yohan.joung@sk.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250403071016.2940-1-yohan.joung@sk.com>
X-Headers-End: 1u0ME6-0006VL-B3
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: prevent the current section from
 being selected as a victim during GC
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
Cc: pilhyun.kim@sk.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi yohan.joung,

kernel test robot noticed the following build errors:

[auto build test ERROR on jaegeuk-f2fs/dev-test]
[also build test ERROR on jaegeuk-f2fs/dev linus/master v6.14 next-20250403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/yohan-joung/f2fs-prevent-the-current-section-from-being-selected-as-a-victim-during-GC/20250403-151057
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20250403071016.2940-1-yohan.joung%40sk.com
patch subject: [PATCH v4] f2fs: prevent the current section from being selected as a victim during GC
config: i386-buildonly-randconfig-005-20250403 (https://download.01.org/0day-ci/archive/20250403/202504032206.xzJoHkRX-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250403/202504032206.xzJoHkRX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504032206.xzJoHkRX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/f2fs/checkpoint.c:20:
   fs/f2fs/segment.h: In function '__set_test_and_free':
>> fs/f2fs/segment.h:480:81: error: macro "GET_SEC_FROM_SEG" requires 2 arguments, but only 1 given
     480 |                                 if (GET_SEC_FROM_SEG(sbi->next_victim_seg[BG_GC]) == secno)
         |                                                                                 ^
   fs/f2fs/segment.h:105: note: macro "GET_SEC_FROM_SEG" defined here
     105 | #define GET_SEC_FROM_SEG(sbi, segno)                            \
         | 
>> fs/f2fs/segment.h:480:37: error: 'GET_SEC_FROM_SEG' undeclared (first use in this function)
     480 |                                 if (GET_SEC_FROM_SEG(sbi->next_victim_seg[BG_GC]) == secno)
         |                                     ^~~~~~~~~~~~~~~~
   fs/f2fs/segment.h:480:37: note: each undeclared identifier is reported only once for each function it appears in
   fs/f2fs/segment.h:483:81: error: macro "GET_SEC_FROM_SEG" requires 2 arguments, but only 1 given
     483 |                                 if (GET_SEC_FROM_SEG(sbi->next_victim_seg[FG_GC]) == secno)
         |                                                                                 ^
   fs/f2fs/segment.h:105: note: macro "GET_SEC_FROM_SEG" defined here
     105 | #define GET_SEC_FROM_SEG(sbi, segno)                            \
         | 


vim +/GET_SEC_FROM_SEG +480 fs/f2fs/segment.h

   458	
   459	static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
   460			unsigned int segno, bool inmem)
   461	{
   462		struct free_segmap_info *free_i = FREE_I(sbi);
   463		unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
   464		unsigned int start_segno = GET_SEG_FROM_SEC(sbi, secno);
   465		unsigned int next;
   466		unsigned int usable_segs = f2fs_usable_segs_in_sec(sbi);
   467	
   468		spin_lock(&free_i->segmap_lock);
   469		if (test_and_clear_bit(segno, free_i->free_segmap)) {
   470			free_i->free_segments++;
   471	
   472			if (!inmem && IS_CURSEC(sbi, secno))
   473				goto skip_free;
   474			next = find_next_bit(free_i->free_segmap,
   475					start_segno + SEGS_PER_SEC(sbi), start_segno);
   476			if (next >= start_segno + usable_segs) {
   477				if (test_and_clear_bit(secno, free_i->free_secmap)) {
   478					free_i->free_sections++;
   479	
 > 480					if (GET_SEC_FROM_SEG(sbi->next_victim_seg[BG_GC]) == secno)
   481						sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
   482	
   483					if (GET_SEC_FROM_SEG(sbi->next_victim_seg[FG_GC]) == secno)
   484						sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
   485				}
   486			}
   487		}
   488	skip_free:
   489		spin_unlock(&free_i->segmap_lock);
   490	}
   491	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
