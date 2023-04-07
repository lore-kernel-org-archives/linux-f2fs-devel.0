Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AFCC6FD1D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Apr 2023 18:15:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pkqcn-0000cC-G4;
	Fri, 07 Apr 2023 18:15:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pkqck-0000c5-Dt
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Apr 2023 18:15:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BpFIudOkMb0Vfa8UEv4ibnPdy5QtCUoJsj01ogMe6hQ=; b=LLeGSJgH0Pfg4N25IW8MHYI6Hg
 inq/a8g9wkZRywLxBVJRXQywIA1ni+WDY6lavqZDWfBGiduvGqKyvOoJc+4uGagdQrsb0vtF4ymNa
 pfR9tVeNusXOtqD2f3O+W1/PArsMj4ViYIzQcUUY3ONSB/33PbcpYgQ/ktRGVtAhEj/k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BpFIudOkMb0Vfa8UEv4ibnPdy5QtCUoJsj01ogMe6hQ=; b=F
 R8lQ+DLcNXi1k+FTeNtgSHM3AMVhxySRKsrKcJbohW41IKrzK+cupNJsKCJemKvW1Q6bm9YovCKVp
 RydNVU/WIiNvk/1gLx1/V6DfSi2JllqYLyOX7nfgdkrc2CKuaXdwBkhh5J4wsMTsI/gP/Ipv52g8v
 QQn/QVUobBLW0RXU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pkqck-000MQl-OJ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Apr 2023 18:15:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 477E565055
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  7 Apr 2023 18:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA6BC433EF;
 Fri,  7 Apr 2023 18:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680891340;
 bh=R5IaRXJ/Qg+3iB9RW4lmo1YHb1AE43YUn4zUM2xxs5Q=;
 h=From:To:Cc:Subject:Date:From;
 b=XZSmTYiLruss9ev7G0liNfXg96G6RieiR1TRsz+uc4Yy2YHHH5b+rLEm+1YnER5f+
 Yc+n0589V28eQQt+G3JCEmMCFgmA35Qe0ArA8rhK3Do//6bXQr7JK/wOPndJrXAu0O
 aweOd1uGbGOkxOl9jk7Vqffx6peJUeGxsxYMLuk+uMw/lySagLuw0xxC4rhEGdSlhn
 vaqP/MsxalJx2qMggmJ7xVZgdMrqnS1OFSIYg23IJRmY5ByQoEMa47/QhXTY0xk7Gd
 ukFNpLvAtdz4yqSPjveFQoGohvyAj2h1PPdT0TqXSfkgKE7hoTswm7S/plXvUaGvoi
 8U7vcNLMHOooQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri,  7 Apr 2023 11:15:39 -0700
Message-Id: <20230407181539.4136580-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
X-Headers-End: 1pkqck-000MQl-OJ
Subject: [f2fs-dev] [PATCH] f2fs: relax sanity check if checkpoint is
 corrupted
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

1. extent_cache
 - let's drop the largest extent_cache
2. invalidate_block
 - don't show the warnings

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c   |  5 +++++
 fs/f2fs/extent_cache.c | 22 +++++++++++++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5774076d7ca3..73ae4e85e70d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -152,6 +152,11 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
 	se = get_seg_entry(sbi, segno);
 
 	exist = f2fs_test_bit(offset, se->cur_valid_map);
+
+	/* skip, if we already have an error in checkpoint. */
+	if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG))
+		return exist;
+
 	if (exist && type == DATA_GENERIC_ENHANCE_UPDATE) {
 		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
 			 blkaddr, exist);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 9a8153895d20..bea6ab9d846a 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -23,18 +23,26 @@ bool sanity_check_extent_cache(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct extent_tree *et = fi->extent_tree[EX_READ];
 	struct extent_info *ei;
 
-	if (!fi->extent_tree[EX_READ])
+	if (!et)
+		return true;
+
+	ei = &et->largest;
+	if (!ei->len)
 		return true;
 
-	ei = &fi->extent_tree[EX_READ]->largest;
+	/* Let's drop, if checkpoint got corrupted. */
+	if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG)) {
+		ei->len = 0;
+		et->largest_updated = true;
+		return true;
+	}
 
-	if (ei->len &&
-		(!f2fs_is_valid_blkaddr(sbi, ei->blk,
-					DATA_GENERIC_ENHANCE) ||
-		!f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
-					DATA_GENERIC_ENHANCE))) {
+	if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
+	    !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
+					DATA_GENERIC_ENHANCE)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
 			  __func__, inode->i_ino,
-- 
2.40.0.577.gac1e443424-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
