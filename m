Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF31C4451B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K5UdpP8urOcUxyCZmr6rCa8nu/LbJ7McOMg4Fx/taT8=; b=k1TPOeI+JyLwdf+7XWF3IQu67y
	zrY3JP8uPeZ6l7B/ifNRMtpSHR0XwPoIgGbRn9Lw6PZwIgG4aQpw3DqTrVd8iAVwofFKPX7t3peRg
	eDWyE76Yo3ahUtYyo8Iiyi9DCN+XEQBUO4WPXPS6TfCUBDtbYpWEw/5BHPo13YJ3Aqrs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wljwZ-0004C1-0J;
	Mon, 20 Jul 2026 09:05:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wljwW-0004BZ-1j
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:05:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ud4tz/BDL/obPmE8te2U/Sx01IYeE2miqyZ5tUvfHoI=; b=IYQZ1ceMIUAafFx09Oy5mye15I
 83eeOgwOKUPYhJG/yoOeaPdnQiNhBa/bA5d+9fjQCmsfFEdqXBvDqsDo04TiyJbXN3pMN72ZmtVbT
 KZ8WbPfSQ5U20LX2HQt5BP1hGkFhRXfTzgwWDxIFQEtN+vJTdraIbq4mukx5sQj/aPAk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ud4tz/BDL/obPmE8te2U/Sx01IYeE2miqyZ5tUvfHoI=; b=lJ1BMWEPbr6+Aa54hVsyAtoQhr
 PSElAtRjJSr4E1ciwd0gzJmlmj3PZqJw6X1s2wV+SEPTixuCRgpptac5yKcQ2XEI9GlVeo3NqCRCC
 GvthvqZRDesLGKYp/SbdWOlXoEQJO4yf/voNdo992QgpzeUyQNO6B0FhUudv86g6J8QE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wljwV-00088d-DN for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:05:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 23DF243B5C;
 Mon, 20 Jul 2026 09:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972211F00A3D;
 Mon, 20 Jul 2026 09:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784538333;
 bh=ud4tz/BDL/obPmE8te2U/Sx01IYeE2miqyZ5tUvfHoI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B7T1FaGUmE9dws7g2U0Bb0bVciF1UU70LPvopn2A1egAUVRCe6Mj1H0VZHUVtYPpw
 0+RmHjSPRvn7/6ZoTSoZkAVnT1k946ht57PITUHO0KMkZ+etsVXDy3K14o+RrG5iNH
 pZIXL/ddTvMNzpRhXophpWAaN42S5dQIiuVyDxuaDu3glX97AgzQT3jKT2Fi7STwI1
 +I1GKRzBbqRK2KDIKVu3NPGrPJfcnK+EI8L9Zxp96aaFEUZdI3x9TPRz5j9Lq18oWX
 nqG/KIFEBRZevZ8F1xx2FpOdRcjQGbwtrgEEX6UZxejKKZcPD6Xk5/1uRPoT0ALZnL
 p9wgAt10m8saA==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon, 20 Jul 2026 11:03:41 +0200
Message-ID: <20260720090410.3487990-14-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720090410.3487990-1-aalbersh@kernel.org>
References: <20260720090410.3487990-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wljwV-00088d-DN
Subject: [f2fs-dev] [PATCH v12 13/21] xfs: use read ioend for fsverity data
 verification
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Use read ioends for fsverity verification. Do not issues fsverity
metadata I/O through the same workqueue due to risk of a deadlock by a
filled workqueue.

Pass fsverity_info from iomap context down to the ioend as hashtable
lookups are expensive.

Add a simple helper to check that this is not fsverity metadata but file
data that needs verification.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_aops.c     | 45 ++++++++++++++++++++++++++++++++++---------
 fs/xfs/xfs_fsverity.c |  9 +++++++++
 fs/xfs/xfs_fsverity.h |  6 ++++++
 3 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 27ff2b240457..b0537c67e960 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -24,6 +24,7 @@
 #include "xfs_rtgroup.h"
 #include "xfs_fsverity.h"
 #include <linux/bio-integrity.h>
+#include <linux/fsverity.h>
 
 struct xfs_writepage_ctx {
 	struct iomap_writepage_ctx ctx;
@@ -182,6 +183,23 @@ xfs_end_ioend_write(
 	memalloc_nofs_restore(nofs_flag);
 }
 
+/*
+ * IO read completion.
+ */
+static void
+xfs_end_ioend_read(
+	struct iomap_ioend	*ioend)
+{
+	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
+
+	if (!ioend->io_bio.bi_status &&
+			xfs_fsverity_is_file_data(ip, ioend->io_offset))
+		fsverity_verify_bio(ioend->io_vi,
+				    &ioend->io_bio);
+	iomap_finish_ioends(ioend,
+		blk_status_to_errno(ioend->io_bio.bi_status));
+}
+
 /*
  * Finish all pending IO completions that require transactional modifications.
  *
@@ -216,8 +234,7 @@ xfs_end_io(
 		list_del_init(&ioend->io_list);
 		iomap_ioend_try_merge(ioend, &tmp);
 		if (bio_op(&ioend->io_bio) == REQ_OP_READ)
-			iomap_finish_ioends(ioend,
-				blk_status_to_errno(ioend->io_bio.bi_status));
+			xfs_end_ioend_read(ioend);
 		else
 			xfs_end_ioend_write(ioend);
 		cond_resched();
@@ -243,9 +260,14 @@ xfs_end_bio(
 	}
 
 	spin_lock_irqsave(&ip->i_ioend_lock, flags);
-	if (list_empty(&ip->i_ioend_list))
-		WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
+	if (list_empty(&ip->i_ioend_list)) {
+		if (IS_ENABLED(CONFIG_FS_VERITY) && ioend->io_vi &&
+		    ioend->io_offset < xfs_fsverity_metadata_offset(ip))
+			fsverity_enqueue_verify_work(&ip->i_ioend_work);
+		else
+			WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
 					 &ip->i_ioend_work));
+	}
 	list_add_tail(&ioend->io_list, &ip->i_ioend_list);
 	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
 }
@@ -787,9 +809,12 @@ xfs_bio_submit_read(
 	struct iomap_read_folio_ctx	*ctx)
 {
 	struct bio			*bio = ctx->read_ctx;
+	struct iomap_ioend		*ioend;
 
 	/* defer read completions to the ioend workqueue */
-	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
+	ioend = iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset,
+			0);
+	ioend->io_vi = ctx->vi;
 	iomap_bio_submit_read_endio(iter, ctx, xfs_end_bio);
 }
 
@@ -801,11 +826,13 @@ static const struct iomap_read_ops xfs_iomap_read_ops = {
 
 static inline const struct iomap_read_ops *
 xfs_get_iomap_read_ops(
-	const struct address_space	*mapping)
+	const struct address_space	*mapping,
+	loff_t				position)
 {
 	struct xfs_inode		*ip = XFS_I(mapping->host);
 
-	if (bdev_has_integrity_csum(xfs_inode_buftarg(ip)->bt_bdev))
+	if (bdev_has_integrity_csum(xfs_inode_buftarg(ip)->bt_bdev) ||
+			xfs_fsverity_is_file_data(ip, position))
 		return &xfs_iomap_read_ops;
 	return &iomap_bio_read_ops;
 }
@@ -817,7 +844,7 @@ xfs_vm_read_folio(
 {
 	struct iomap_read_folio_ctx	ctx = { .cur_folio = folio };
 
-	ctx.ops = xfs_get_iomap_read_ops(folio->mapping);
+	ctx.ops = xfs_get_iomap_read_ops(folio->mapping, folio_pos(folio));
 	iomap_read_folio(&xfs_read_iomap_ops, &ctx, NULL);
 	return 0;
 }
@@ -828,7 +855,7 @@ xfs_vm_readahead(
 {
 	struct iomap_read_folio_ctx	ctx = { .rac = rac };
 
-	ctx.ops = xfs_get_iomap_read_ops(rac->mapping),
+	ctx.ops = xfs_get_iomap_read_ops(rac->mapping, readahead_pos(rac));
 	iomap_readahead(&xfs_read_iomap_ops, &ctx, NULL);
 }
 
diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index 0971d2f983db..e3c8ac51c43f 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -18,3 +18,12 @@ xfs_fsverity_metadata_offset(
 {
 	return round_up(i_size_read(VFS_IC(ip)), XFS_FSVERITY_START_ALIGN);
 }
+
+bool
+xfs_fsverity_is_file_data(
+	const struct xfs_inode	*ip,
+	loff_t			offset)
+{
+	return fsverity_active(VFS_IC(ip)) &&
+			offset < xfs_fsverity_metadata_offset(ip);
+}
diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
index 5771db2cd797..ec77ba571106 100644
--- a/fs/xfs/xfs_fsverity.h
+++ b/fs/xfs/xfs_fsverity.h
@@ -9,12 +9,18 @@
 
 #ifdef CONFIG_FS_VERITY
 loff_t xfs_fsverity_metadata_offset(const struct xfs_inode *ip);
+bool xfs_fsverity_is_file_data(const struct xfs_inode *ip, loff_t offset);
 #else
 static inline loff_t xfs_fsverity_metadata_offset(const struct xfs_inode *ip)
 {
 	WARN_ON_ONCE(1);
 	return ULLONG_MAX;
 }
+static inline bool xfs_fsverity_is_file_data(const struct xfs_inode *ip,
+					    loff_t offset)
+{
+	return false;
+}
 #endif	/* CONFIG_FS_VERITY */
 
 #endif	/* __XFS_FSVERITY_H__ */
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
