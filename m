Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08E4C25B75
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:55:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sF9ps-00016E-9x;
	Thu, 06 Jun 2024 09:55:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sF9pq-000168-P6
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jun 2024 09:55:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iQP2PeTUocUHwk3NmgD/RU+Dhz6nAgfskuFqVJeo9CY=; b=VXY2d58OMpoBbaZ/NKv69W0/ox
 7DIlvLVJEYdfkc8EHA5NMrKg9L1ZF7IPjR62koZtfcSmwRDbZQxopWNSSEFuPEpFMImiCzqU5V3jT
 vx72yOcXud4Ahsx7mb7C9pcHLFZY/10+zEDhSs3+N9cmLXpqxspvKvwRMrJalqVl71lo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iQP2PeTUocUHwk3NmgD/RU+Dhz6nAgfskuFqVJeo9CY=; b=b
 sYWUXKF8atsnEqMocxIwpnX4ic5VWVa7ZlqgUS7Yab9nTGzLcRsMKioXblej+kmX27SPpi/ySAnHz
 /UJN4QHiekoW/3L/FVfH270ougqbhcEwrs2CrJyNzNnlqlVWjkGSxgBVOc80QD32hbaaA6cZql6eM
 +o8iFs4ZkcVbFC2k=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sF9ps-0004bv-1r for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jun 2024 09:55:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E985B61D1F;
 Thu,  6 Jun 2024 09:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FA1C4AF0B;
 Thu,  6 Jun 2024 09:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717667696;
 bh=GNpmoUqNJ5Xzdvywh8sIQ3KCs7bJubcVgL87Sik46R0=;
 h=From:To:Cc:Subject:Date:From;
 b=Sp+/mZ1DDMC7/qtA4SInsKKdOF3SmxZP1uldo8Ec63DG2w07Fxk2pFOaQCbhk0KKm
 XWRCh+ws2PXyLc7b2rEF2PXtUGGlFVrT1WXM/dFbEWItPhOfQyduE/V/t0dafCl5kF
 Z4jgd3jn/jxADd5y+Mva+Mv3jKBjG9Y+tID+l2skQC88THT/eUX6rpU5KSjnGgHIse
 Od2kJXhMEOfLyfKlkaNzzpjwwJDTQR3ghPcaGO5jAhhFY4xgImxKaU4fcIemrDuXoA
 UW8UzbgBPM/QAOer/RjAMe4jzgoHtM+yS+CZpJiFA3BydGoYv4BHpPb60y4BD+Wxxy
 p1zMGEA7tSZbA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu,  6 Jun 2024 17:54:51 +0800
Message-Id: <20240606095451.4088735-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1sF9ps-0004bv-1r
Subject: [f2fs-dev] [PATCH] f2fs: fix to update user block counts in
 block_operations()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Commit 59c9081bc86e ("f2fs: allow write page cache when writting cp")
allows write() to write data to page cache during checkpoint, so block
count fields like .total_valid_block_count, .alloc_valid_block_count
and .rf_node_block_count may encounter race condition as below:

CP				Thread A
- write_checkpoint
 - block_operations
  - f2fs_down_write(&sbi->node_change)
  - __prepare_cp_block
  : ckpt->valid_block_count = .total_valid_block_count
  - f2fs_up_write(&sbi->node_change)
				- write
				 - f2fs_preallocate_blocks
				  - f2fs_map_blocks(,F2FS_GET_BLOCK_PRE_AIO)
				   - f2fs_map_lock
				    - f2fs_down_read(&sbi->node_change)
				   - f2fs_reserve_new_blocks
				    - inc_valid_block_count
				    : percpu_counter_add(&sbi->alloc_valid_block_count, count)
				    : sbi->total_valid_block_count += count
				    - f2fs_up_read(&sbi->node_change)
 - do_checkpoint
 : sbi->last_valid_block_count = sbi->total_valid_block_count
 : percpu_counter_set(&sbi->alloc_valid_block_count, 0)
 : percpu_counter_set(&sbi->rf_node_block_count, 0)
				- fsync
				 - need_do_checkpoint
				  - f2fs_space_for_roll_forward
				  : alloc_valid_block_count was reset to zero,
				    so, it may missed last data during checkpoint

Let's change to update .total_valid_block_count, .alloc_valid_block_count
and .rf_node_block_count in block_operations(), then their access can be
protected by .node_change and .cp_rwsem lock, so that it can avoid above
race condition.

Fixes: 59c9081bc86e ("f2fs: allow write page cache when writting cp")
Cc: Yunlei He <heyunlei@oppo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 66eaad591b60..010bbd5af211 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1298,6 +1298,12 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	 * dirty node blocks and some checkpoint values by block allocation.
 	 */
 	__prepare_cp_block(sbi);
+
+	/* update user_block_counts */
+	sbi->last_valid_block_count = sbi->total_valid_block_count;
+	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
+	percpu_counter_set(&sbi->rf_node_block_count, 0);
+
 	f2fs_up_write(&sbi->node_change);
 	return err;
 }
@@ -1575,11 +1581,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		start_blk += NR_CURSEG_NODE_TYPE;
 	}
 
-	/* update user_block_counts */
-	sbi->last_valid_block_count = sbi->total_valid_block_count;
-	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
-	percpu_counter_set(&sbi->rf_node_block_count, 0);
-
 	/* Here, we have one bio having CP pack except cp pack 2 page */
 	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
 	/* Wait for all dirty meta pages to be submitted for IO */
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
