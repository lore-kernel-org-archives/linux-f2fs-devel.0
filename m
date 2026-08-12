Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A25C5CFDB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:Message-ID:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eEdHzbwcoCkaCGxLU0R3Z9++YgzOj50g7YwISNOXQmY=; b=QfsvO0NWn8rezTrxeOHl8fFE4d
	xue2M0brHKdaAIYfRIpECxbpdk9JH/VV2YPycXOnDEGBSBvUskOrzE5lC9Cn18dWy4lmwycOZzhBV
	RMWD0Rx7mIODUrJPqsFfm8fGa36o3mLfz1uU6Mo47jAScMkBsGlJx3xe9KpaR2C6MlOw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wu4Lr-0004Ow-N2;
	Wed, 12 Aug 2026 08:30:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1wu4Lq-0004Oi-4D
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 08:30:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5BICLD0710L3SpbhkdpZRZcijtorYGGpTWaZwrqr6bc=; b=DoWdl4uNsG9KTvtZ1GjI+FbLWi
 z8oQPkJAafkpy/YNTLIW27NGjKOXjyXGjta5JfCGa05iM54FYdg5AxZlDjMEtWaJbwAsWZYnojSGj
 gAwd+Zc8B99FncSOcf7Pq7gip0lFemuHzmOUYwCCy34Wfr98vg4+atNR3EX1v62LUpkA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5BICLD0710L3SpbhkdpZRZcijtorYGGpTWaZwrqr6bc=; b=jPO1rEa8DTNvyywOsBoq5hOUOg
 RkdKQj1x1B2y5U0Y01kChzcZGwzOo+NFw7uKqtJWM8HwJARwvtCrAu1EGcLy6Y9pyl8ej79IqaPPQ
 7E7lvIaxzFQULAUklaol4sInVy5NKGyOT68mjLzDfVTx5qkNWh3u+I4gdEt1vmKqPle8=;
Received: from mgamail.intel.com ([198.175.65.12])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wu4Lt-0003Fi-Dl for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 08:30:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786523418; x=1818059418;
 h=date:from:to:cc:subject:message-id;
 bh=grROCCp/NlSZhIChKu/T+K573rFhmjdvZT5uMTe+e3A=;
 b=XZh78SkLaBvPT/nq6c0Wzan6Kl5uijOqBpE3h7iyYHInnwk77zA5Ik/L
 StimfG7vXvvNGVrFDEATReOKKwwX+crUsrIKnCLOQpxlYuew/37dR/w+N
 39b3LNhiauI2G+LU3unn8exYpylVT/VAzLyrSdXywoAl6xaVBVRhDL9RV
 N7G1YbO9ZiU/FWtF0RzQ/D2zEYA7KG79z8JRAKFhcH84NA5Ul2oOZ0qA8
 jW7zNYQPLUuCCOR5SisGMOKrsThuH/nscaBOf6P6xULAiVxlbr2T+NY2C
 Z0sXMPJx0i4D0pW9oaZ60phMaT1hvQ5DZGehzf0lFcj4GeSWc7A/BET6a Q==;
X-CSE-ConnectionGUID: Kx7c5AXVR820tTp9+tbNxQ==
X-CSE-MsgGUID: 0CUIW93UQHqEGxj6TkQXgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98582545"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="98582545"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 01:30:12 -0700
X-CSE-ConnectionGUID: B6SYgmSXRtCnkgOGvIVo2Q==
X-CSE-MsgGUID: lKm+h/wGQG+7TNYrCzz/3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="267072037"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa003.jf.intel.com with ESMTP; 12 Aug 2026 01:30:10 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wu4Lf-00000000Q6w-1DjN;
 Wed, 12 Aug 2026 08:30:07 +0000
Date: Wed, 12 Aug 2026 16:29:54 +0800
From: kernel test robot <lkp@intel.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <202608121654.riTjCLm7-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Headers-End: 1wu4Lt-0003Fi-Dl
Subject: [f2fs-dev] [jaegeuk-f2fs:dev-test 30/30] fs/f2fs/inode.c:1065:6:
 error: call to undeclared function 'current_is_kswapd';
 ISO C99 and later do not support implicit function declarations
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
Cc: llvm@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
 oe-kbuild-all@lists.linux.dev
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
head:   7451b3cd93b30f714efc83f6571abf8c50541839
commit: 7451b3cd93b30f714efc83f6571abf8c50541839 [30/30] f2fs: call __add_ino_entry out of the eviction path
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260812/202608121654.riTjCLm7-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 12df34b8469b8095359de8c249cb1b2753fadeea)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260812/202608121654.riTjCLm7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608121654.riTjCLm7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/f2fs/inode.c:1065:6: error: call to undeclared function 'current_is_kswapd'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1065 |         if (current_is_kswapd()) {
         |             ^
   1 error generated.


vim +/current_is_kswapd +1065 fs/f2fs/inode.c

  1019	
  1020	static void f2fs_post_evict_inode(struct inode *inode)
  1021	{
  1022		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
  1023		struct f2fs_inode_info *fi = F2FS_I(inode);
  1024		nid_t xnid = fi->i_xattr_nid;
  1025		unsigned int record_bits = 0;
  1026	
  1027		dquot_drop(inode);
  1028	
  1029		stat_dec_inline_xattr(inode);
  1030		stat_dec_inline_dir(inode);
  1031		stat_dec_inline_inode(inode);
  1032		stat_dec_compr_inode(inode);
  1033		stat_sub_compr_blocks(inode,
  1034				atomic_read(&fi->i_compr_blocks));
  1035	
  1036		if (likely(!f2fs_cp_error(sbi) &&
  1037					!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
  1038			f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
  1039	
  1040		/*
  1041		 * anyway, it needs to remove the inode from sbi->inode_list[DIRTY_META]
  1042		 * list to avoid UAF in f2fs_sync_inode_meta() during checkpoint.
  1043		 */
  1044		f2fs_inode_synced(inode);
  1045	
  1046		/* for the case f2fs_new_inode() was failed, .i_ino is zero, skip it */
  1047		if (inode->i_ino)
  1048			invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino,
  1049								inode->i_ino);
  1050		if (xnid)
  1051			invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
  1052	
  1053		if (!inode->i_nlink)
  1054			goto skip_record;
  1055	
  1056		if (is_inode_flag_set(inode, FI_APPEND_WRITE))
  1057			record_bits = BIT(APPEND_INO);
  1058		if (is_inode_flag_set(inode, FI_UPDATE_WRITE))
  1059			record_bits = BIT(UPDATE_INO);
  1060	
  1061		if (!record_bits)
  1062			goto skip_record;
  1063	
  1064		/* Let's do this in workqueue out of the direct reclaim path. */
> 1065		if (current_is_kswapd()) {
  1066			f2fs_record_inode_state(sbi, inode->i_ino, record_bits);
  1067		} else {
  1068			struct evict_inode_work *ew =
  1069				mempool_alloc(evict_inode_work_pool, GFP_NOFS);
  1070	
  1071			ew->sbi = sbi;
  1072			ew->ino = inode->i_ino;
  1073			ew->add_ino_entry_bits = record_bits;
  1074			INIT_WORK(&ew->work, f2fs_evict_inode_work);
  1075			queue_work(sbi->evict_wq, &ew->work);
  1076		}
  1077	skip_record:
  1078		if (is_inode_flag_set(inode, FI_FREE_NID)) {
  1079			f2fs_alloc_nid_failed(sbi, inode->i_ino);
  1080			clear_inode_flag(inode, FI_FREE_NID);
  1081		} else {
  1082			/*
  1083			 * If xattr nid is corrupted, we can reach out error condition,
  1084			 * err & !f2fs_exist_written_data(sbi, inode->i_ino, ORPHAN_INO)).
  1085			 * In that case, f2fs_check_nid_range() is enough to give a clue.
  1086			 */
  1087		}
  1088	}
  1089	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
