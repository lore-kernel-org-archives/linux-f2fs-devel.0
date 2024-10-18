Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D48D3C54E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Oct 2024 06:27:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t1gRw-00060N-G5;
	Fri, 18 Oct 2024 06:27:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t1gRu-00060D-N9
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Oct 2024 06:26:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GrOjjnnzA7CtdPjIIlp2qzrm/wj9fjVgE3NXEQT4aJc=; b=SCna0LWXnBFogegt7ERIPwrAZZ
 19p1ThRFq6TAY1NZqVmtx70i2oqklIIBBg5oAU6oaXOGz7FyLkbjZL5grTb7WxqnzT03WVyme7S1S
 h3nHGzXCAVqkFlfCFB+Nhv1JsdgTOEBelJqzb9auwmOWAT7ZnoeXqhRq5/YwhGkXXP+8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GrOjjnnzA7CtdPjIIlp2qzrm/wj9fjVgE3NXEQT4aJc=; b=W
 N2F7TnVJwJJjNfVeJ3z1ktY+Uv2G2xzDD1fwq4XVz/iGIRgud/CglUOSK9xLH18KZmvkeHGlSRYB4
 UJfXL/bed2l6qDAWcY9E0ZbS9vcjf8xcErUiqZ6ypyXb91dXhIGYaDvWt3klzruxse0ZBoaUhbUG5
 rpUVpevy/HLJqIms=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t1gRu-0005Li-Ob for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Oct 2024 06:26:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E38D75C5549
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 18 Oct 2024 06:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F1BC4CEC3;
 Fri, 18 Oct 2024 06:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729232807;
 bh=7A5TJzuMgQQEj4Vo64PmUWu+4ittU4tPXAhcTNhgg34=;
 h=From:To:Cc:Subject:Date:From;
 b=BM+rKPOtJFDR0IWOy4FPyKzGJpuEhlqEZ8wuFwvOPXpmK9MthKCfKt6uvzNu2cUQY
 zk6yr4UpqlEqiL540qO0Eh2MXMtSN0RWIR+f5ZBvVIkCW6YQXws6t7i2ZFEJMgumd5
 BlLPhkrdhpue8Gf8nHYEB9n+ViSsRPxjj7S1joP/HhpNixP2iD75UafIkvHZ1Zyubn
 XLveugqEiT61zshvJFbDVaD2ArVIzt5CAC1rCKzWM/lH8CtVgRp00teB4yzS2+HqYn
 0kXytu7s3oDgs7TSLmf+k7IRSdaxGqH75dkuU641TNWWv26S4XFgY8yhnt+ZiI31oQ
 umY+LU34eddag==
To: jaegeuk@kernel.org
Date: Fri, 18 Oct 2024 14:26:36 +0800
Message-Id: <20241018062638.2619214-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1t1gRu-0005Li-Ob
Subject: [f2fs-dev] [PATCH 1/3] f2fs: zone: introduce first_zoned_segno in
 f2fs_sb_info
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

first_zoned_segno() returns a fixed value, let's cache it in
structure f2fs_sb_info to avoid redundant calculation.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c |  4 ++--
 fs/f2fs/segment.h | 10 ----------
 fs/f2fs/super.c   | 13 +++++++++++++
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0ff7f2812312..55bcd411257a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1760,6 +1760,7 @@ struct f2fs_sb_info {
 	unsigned int dirty_device;		/* for checkpoint data flush */
 	spinlock_t dev_lock;			/* protect dirty_device */
 	bool aligned_blksize;			/* all devices has the same logical blksize */
+	unsigned int first_zoned_segno;		/* first zoned segno */
 
 	/* For write statistics */
 	u64 sectors_written_start;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e1003e262184..a1806976f4ad 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2732,7 +2732,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_PRIOR_CONV || pinning)
 			segno = 0;
 		else
-			segno = max(first_zoned_segno(sbi), *newseg);
+			segno = max(sbi->first_zoned_segno, *newseg);
 		hint = GET_SEC_FROM_SEG(sbi, segno);
 	}
 #endif
@@ -2744,7 +2744,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 	if (secno >= MAIN_SECS(sbi) && f2fs_sb_has_blkzoned(sbi)) {
 		/* Write only to sequential zones */
 		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_ONLY_SEQ) {
-			hint = GET_SEC_FROM_SEG(sbi, first_zoned_segno(sbi));
+			hint = GET_SEC_FROM_SEG(sbi, sbi->first_zoned_segno);
 			secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
 		} else
 			secno = find_first_zero_bit(free_i->free_secmap,
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index cd6325f3b9ca..838c436266f4 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -971,13 +971,3 @@ static inline void wake_up_discard_thread(struct f2fs_sb_info *sbi, bool force)
 	dcc->discard_wake = true;
 	wake_up_interruptible_all(&dcc->discard_wait_queue);
 }
-
-static inline unsigned int first_zoned_segno(struct f2fs_sb_info *sbi)
-{
-	int devi;
-
-	for (devi = 0; devi < sbi->s_ndevs; devi++)
-		if (bdev_is_zoned(FDEV(devi).bdev))
-			return GET_SEGNO(sbi, FDEV(devi).start_blk);
-	return 0;
-}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0d96e352b4ac..9325d8dc7f7d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4223,6 +4223,16 @@ static void f2fs_record_error_work(struct work_struct *work)
 	f2fs_record_stop_reason(sbi);
 }
 
+static inline unsigned int get_first_zoned_segno(struct f2fs_sb_info *sbi)
+{
+	int devi;
+
+	for (devi = 0; devi < sbi->s_ndevs; devi++)
+		if (bdev_is_zoned(FDEV(devi).bdev))
+			return GET_SEGNO(sbi, FDEV(devi).start_blk);
+	return 0;
+}
+
 static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
@@ -4623,6 +4633,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* For write statistics */
 	sbi->sectors_written_start = f2fs_get_sectors_written(sbi);
 
+	/* get segno of first zoned block device */
+	sbi->first_zoned_segno = get_first_zoned_segno(sbi);
+
 	/* Read accumulated write IO statistics if exists */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
 	if (__exist_node_summaries(sbi))
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
