Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A8FC88E4C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9sLMVjf49aKCb0ra5HSwayXCi6AZygYQLcUgUAmbZus=; b=cwKrqUcJ6Truj3bv6GwdvY0tHu
	oP6UGXi7608tNwkCSM3ZMvmjviMA9Y4scml9mZLgtNXymbOvvHMZFv8ghX9Gb2XdNYj2mb66wLUbi
	XkNCfmL7lhHdDKW86PTAmukXqmaR8BPD5Ky0XZvEPWahc/+713IgmnDMs7VsyJcdZcpU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4wNV-00035f-Ux;
	Fri, 11 Sep 2026 08:12:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1x4wNU-00035S-TS
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:12:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LQY6ybovI6uThHsKqg2EXfHiARtcqpVcnZMwHeAuKVA=; b=XCfDEW+jYWcBB8Km6H1FPznNN3
 vtCf0+isW+TeTu6lDNQ602E9CuSjQf7BlD+NQ6Z2OvXrsaZZrIghs3ze2Btu2UF0C/W7IJUxTTXH5
 eahoHhyH9ONs57f4regtspvtPchBfSwgXRVaz6EwNMksC2ybNe+yHXHWrMWWnelGLAkA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LQY6ybovI6uThHsKqg2EXfHiARtcqpVcnZMwHeAuKVA=; b=UNQtK4PWE0DvoiyMk5zw+gUQVI
 tIL59i3rpViBh6Sr8johjHp+5OfHukM6bhd2El7BzoU1rMFkwySuPnxfbAQI7deL1UJK79aZDPLsv
 6bumZ+taRm434wjoRWLkfkhO3EyoxdqXZ77IplhlC5YR6fal6QcnxclLSNJRjV46UV3M=;
Received: from mgamail.intel.com ([198.175.65.19])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4wNR-0003ju-WF for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:12:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789114375; x=1820650375;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gvmZf3ItsRhJ8/S0UFE29TrvpRykf6zfuBlByhYmbFI=;
 b=VdGdLt2SghnjcG2dwtn0oqjxykIGdIyHD/V4Qn2HNJtnAHA/mEuNBO0n
 yffiD5EEd2Pa0m+xIKt66F6lzQvwVLDT/KsKmEsnvpsqX8RVF/TomdkVV
 b7HzQN/8D6drAp4LBuwzNccFHsze/Sqh63GC54EKUokVkASIFZ6pLGiUX
 r4JBvP4xZVTWGvJJVtqe5Mq4etl9F0KD4FchT34DbeRZ/UG+fBZmb4LIZ
 4J08806hRPTepxVvxrgp3kWT55tQBvOqT52j+O8JC0yi/SHZrAkhqHopR
 TBJ2H8CivvLs3qdHb9OupYChlLyQd2HsJMMANIU16+td1Giny+qAV3kod A==;
X-CSE-ConnectionGUID: xJMlaqNMTMC45xkSEdwMzw==
X-CSE-MsgGUID: bbr1ObRrRVCy1mRc2niIow==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89508840"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89508840"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 01:12:49 -0700
X-CSE-ConnectionGUID: +ItDRX2hTa+1pmY5/NcOxA==
X-CSE-MsgGUID: w+iIru6QRJSpZd8HExTxcg==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; d="scan'208";a="271834668"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
 by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 01:12:47 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x4wMQ-000000001HK-0ldF;
 Fri, 11 Sep 2026 08:12:02 +0000
Date: Fri, 11 Sep 2026 16:10:47 +0800
From: kernel test robot <lkp@intel.com>
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Message-ID: <202609111633.uyRbsEUB-lkp@intel.com>
References: <20260910181057.640203-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260910181057.640203-1-daeho43@gmail.com>
X-Headers-End: 1x4wNR-0003ju-WF
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce reserve_shrink mount option
 for filesystem shrinkage
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
Cc: llvm@lists.linux.dev, Daeho Jeong <daehojeong@google.com>,
 oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jaegeuk-f2fs/dev-test]
[also build test WARNING on jaegeuk-f2fs/dev linus/master v7.3-rc2 next-20260909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daeho-Jeong/f2fs-introduce-reserve_shrink-mount-option-for-filesystem-shrinkage/20260910-111056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20260910181057.640203-1-daeho43%40gmail.com
patch subject: [PATCH] f2fs: introduce reserve_shrink mount option for filesystem shrinkage
config: powerpc-randconfig-001-20260911 (https://download.01.org/0day-ci/archive/20260911/202609111633.uyRbsEUB-lkp@intel.com/config)
compiler: clang version 21.1.8 (https://github.com/llvm/llvm-project 2078da43e25a4623cab2d0d60decddf709aaea28)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260911/202609111633.uyRbsEUB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609111633.uyRbsEUB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/f2fs/debug.c:18:
>> fs/f2fs/f2fs.h:2663:6: warning: shift count >= width of type [-Wshift-count-overflow]
    2663 |         if (test_opt(sbi, RESERVE_SHRINK)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/f2fs.h:157:26: note: expanded from macro 'test_opt'
     157 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
   1 warning generated.
--
   In file included from fs/f2fs/gc.c:19:
>> fs/f2fs/f2fs.h:2663:6: warning: shift count >= width of type [-Wshift-count-overflow]
    2663 |         if (test_opt(sbi, RESERVE_SHRINK)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/f2fs.h:157:26: note: expanded from macro 'test_opt'
     157 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
>> fs/f2fs/gc.c:2495:13: warning: shift count >= width of type [-Wshift-count-overflow]
    2495 |         } else if (test_opt(sbi, RESERVE_SHRINK)) {
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/f2fs.h:157:26: note: expanded from macro 'test_opt'
     157 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
   fs/f2fs/gc.c:2498:3: warning: shift count >= width of type [-Wshift-count-overflow]
    2498 |                 clear_opt(sbi, RESERVE_SHRINK);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/f2fs.h:153:28: note: expanded from macro 'clear_opt'
     153 |         (F2FS_OPTION(sbi).opt &= ~BIT(F2FS_MOUNT_##option))
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
   3 warnings generated.
--
   In file included from fs/f2fs/super.c:34:
>> fs/f2fs/f2fs.h:2663:6: warning: shift count >= width of type [-Wshift-count-overflow]
    2663 |         if (test_opt(sbi, RESERVE_SHRINK)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/f2fs.h:157:26: note: expanded from macro 'test_opt'
     157 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
>> fs/f2fs/super.c:548:7: warning: shift count >= width of type [-Wshift-count-overflow]
     548 |         if (!test_opt(sbi, RESERVE_SHRINK))
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/f2fs.h:157:26: note: expanded from macro 'test_opt'
     157 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
   fs/f2fs/super.c:2326:6: warning: shift count >= width of type [-Wshift-count-overflow]
    2326 |         if (test_opt(sbi, RESERVE_SHRINK)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/f2fs.h:157:26: note: expanded from macro 'test_opt'
     157 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
   fs/f2fs/super.c:2557:6: warning: shift count >= width of type [-Wshift-count-overflow]
    2557 |         if (test_opt(sbi, RESERVE_SHRINK))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/f2fs.h:157:26: note: expanded from macro 'test_opt'
     157 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
   4 warnings generated.
--
   In file included from fs/f2fs/sysfs.c:17:
>> fs/f2fs/f2fs.h:2663:6: warning: shift count >= width of type [-Wshift-count-overflow]
    2663 |         if (test_opt(sbi, RESERVE_SHRINK)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/f2fs.h:157:26: note: expanded from macro 'test_opt'
     157 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
>> fs/f2fs/sysfs.c:599:7: warning: shift count >= width of type [-Wshift-count-overflow]
     599 |                 if (test_opt(sbi, RESERVE_SHRINK)) {
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/f2fs.h:157:26: note: expanded from macro 'test_opt'
     157 |         (F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^  ~~~~
   2 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for HOTPLUG_CPU
   Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
   Selected by [y]:
   - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=n] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]


vim +2663 fs/f2fs/f2fs.h

  2650	
  2651	static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
  2652							struct inode *inode, bool cap)
  2653	{
  2654		block_t avail_user_block_count;
  2655	
  2656		avail_user_block_count = sbi->user_block_count -
  2657						sbi->current_reserved_blocks -
  2658						sbi->alias_reserved_blocks;
  2659	
  2660		if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_root(sbi, inode, cap))
  2661			avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
  2662	
> 2663		if (test_opt(sbi, RESERVE_SHRINK)) {
  2664			if (avail_user_block_count > F2FS_OPTION(sbi).reserve_shrink_blocks)
  2665				avail_user_block_count -= F2FS_OPTION(sbi).reserve_shrink_blocks;
  2666			else
  2667				avail_user_block_count = 0;
  2668		}
  2669	
  2670		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
  2671			if (avail_user_block_count > sbi->unusable_block_count)
  2672				avail_user_block_count -= sbi->unusable_block_count;
  2673			else
  2674				avail_user_block_count = 0;
  2675		}
  2676	
  2677		return avail_user_block_count;
  2678	}
  2679	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
