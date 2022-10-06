Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCFCC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Oct 2022 15:17:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ogScg-00032W-Pq;
	Thu, 06 Oct 2022 15:17:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ogScf-00032J-RH
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Oct 2022 15:17:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2QQkFhtG22uqI3nGpRM3qHMV/OuPU2DOvZ8JtL5dsss=; b=fF7AZePk2/GpFRwgM1dxJWKk0H
 bsDds+erSEYaMGuAio5bAvhBKOkCYYw6WNosYhSpK2iFqFwTtbMIQZo2WgwdOlJNqFBgxWeySmzdu
 dKZVWSUADKTm1g3hLbY3U6WRHOXLJll5ffW2ZG8x8pZo6WZGYu1VI2w4DUyERAbwu3dg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2QQkFhtG22uqI3nGpRM3qHMV/OuPU2DOvZ8JtL5dsss=; b=S
 gXe/fzUfsJxEhH7Lc2kbC0dBns/3FF3JMGtqO/Pse4hrPZDcvTprJ61xb02DdnSGivSBv9K6qbd6I
 nt3sTy7hnUKZkvtDNmiCPGW2H7Kx1taS8Icoiw7yjRk3iLbg4SKQdPzPQhr5tKojD8vI26TpEQ5VW
 l3io/RlWBirjLsdw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ogSca-00070Y-5t for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Oct 2022 15:17:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 31E68619E5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Oct 2022 15:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF05CC433D6;
 Thu,  6 Oct 2022 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1665069424;
 bh=bQAFisTLMneOIb9teev0BcCjvNSpoFNyx3UBe/gq2l8=;
 h=From:To:Cc:Subject:Date:From;
 b=fl0RV7A2i5BxpdRDCdh0c5XAKi/24PpUzjhx3KqgdIB6/TQksNJst3gOVBxBSveVa
 y6tpohpCWV2Ezm3PfMU8scOgS8NgozkDuvaVnzHdWFQTqxXE2UMd97Df1K8XRQZ3QK
 59hJIuQ2qUm9TkJyGJsyQP8U08Wm8sC+w90q2dvurFftvFaNcIJ4JS51X7Zfl0KyRw
 7+NcA0zsIAJO2XfpBmMxzhxuUiH2Sl8M67zXGX7bVGquETTGuzxx1PvJ3eskFtotlG
 kF3AKG0gOXerzF1OmI2wA/kffkahs/fL7O2h0yM632yj7RyaXq73N+j7r4MIJclOte
 omqqeyjU/IawA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu,  6 Oct 2022 23:16:56 +0800
Message-Id: <20221006151657.58336-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Headers-End: 1ogSca-00070Y-5t
Subject: [f2fs-dev] [PATCH 1/2] mkfs.f2fs: update allocation policy for ro
 feature
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Update allocation policy for ro feature:
- hot_data: allocating blocks by LBA ascending order
- hot_node: allocating blocks by LBA descending order

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/mount.c       |  8 ++++++++
 fsck/segment.c     | 15 ++++++++++++++-
 mkfs/f2fs_format.c |  4 ++--
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index af24484..aebe363 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2777,6 +2777,14 @@ static void move_one_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left,
 	if ((get_sb(feature) & cpu_to_le32(F2FS_FEATURE_RO))) {
 		if (i != CURSEG_HOT_DATA && i != CURSEG_HOT_NODE)
 			return;
+
+		if (i == CURSEG_HOT_DATA) {
+			left = 0;
+			from = SM_I(sbi)->main_blkaddr;
+		} else {
+			left = 1;
+			from = __end_block_addr(sbi);
+		}
 		goto bypass_ssa;
 	}
 
diff --git a/fsck/segment.c b/fsck/segment.c
index 401cbb6..0307bdd 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -28,6 +28,7 @@ int reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
 	u64 blkaddr, offset;
 	u64 old_blkaddr = *to;
 	bool is_node = IS_NODESEG(type);
+	int left = 0;
 
 	if (old_blkaddr == NULL_ADDR) {
 		if (c.func == FSCK) {
@@ -56,7 +57,19 @@ int reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
 
 	blkaddr = SM_I(sbi)->main_blkaddr;
 
-	if (find_next_free_block(sbi, &blkaddr, 0, type, false)) {
+	if (sbi->raw_super->feature & cpu_to_le32(F2FS_FEATURE_RO)) {
+		if (IS_NODESEG(type)) {
+			type = CURSEG_HOT_NODE;
+			blkaddr = __end_block_addr(sbi);
+			left = 1;
+		} else if (IS_DATASEG(type)) {
+			type = CURSEG_HOT_DATA;
+			blkaddr = SM_I(sbi)->main_blkaddr;
+			left = 0;
+		}
+	}
+
+	if (find_next_free_block(sbi, &blkaddr, left, type, false)) {
 		ERR_MSG("Can't find free block");
 		ASSERT(0);
 	}
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 40ac589..8d0f410 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -544,10 +544,10 @@ static int f2fs_prepare_super_block(void)
 	}
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_RO)) {
-		c.cur_seg[CURSEG_HOT_NODE] = 0;
+		c.cur_seg[CURSEG_HOT_NODE] = last_section(last_zone(total_zones));
 		c.cur_seg[CURSEG_WARM_NODE] = 0;
 		c.cur_seg[CURSEG_COLD_NODE] = 0;
-		c.cur_seg[CURSEG_HOT_DATA] = 1;
+		c.cur_seg[CURSEG_HOT_DATA] = 0;
 		c.cur_seg[CURSEG_COLD_DATA] = 0;
 		c.cur_seg[CURSEG_WARM_DATA] = 0;
 	} else if (c.heap) {
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
