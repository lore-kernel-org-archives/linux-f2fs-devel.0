Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101A4C5CFC1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dl0obLESWAzFpqCTfO3q8C54EOMCKU1yKpX5FOMBQ1Y=; b=M4SaxNp1sXScSDSxuxgEwltHcY
	Ap8VbzRFSnzO2pt2bUryliao8GCSgEN5+D9Ui43StlOCbNYB4XxRfNBTbypW3Fe7uQMGLOflaQhhE
	xD407a0Vg4fmXhfgJZILvNOKJ0I5/IQoimvGRdwiMZKlxzE/Pt+Dp21ByoqV1v0p25ng=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuoBQ-0004CS-0Z;
	Fri, 14 Aug 2026 09:26:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wuoBO-0004C3-Ia
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:26:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q2SKTE3mDAWpbaUp39eqm6e7KDQqD/IN66nudQau/oY=; b=JjnQF0KAW5qtzagouE6Elu+eVD
 F2TB8VAlO9dyZ2ShrZhNNt9BD8l5KW7Bk27hhZcPDPycxvU0ug13zOD0knzJVBbx/vScnj+NUcWXz
 LEOKGPxl975nYsdtuyABSFVyuVNW4rKiPEiHqNaIxo52U07K/aofvRMLNs8TQnKZCTwY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q2SKTE3mDAWpbaUp39eqm6e7KDQqD/IN66nudQau/oY=; b=YonRHEh0M66NfnNh8SAjggGj1K
 xI4c9ivYbexNS1uxcKo0EH+A+W7mWS2vBW6sU0Ne05xHPzZGOVMdbJM8LbTaVZq4N/NCglmJFa+oC
 Wde15cXeW6aVXwI5gUuFAuREDX5E3VewXOM2I30P3xJtZZ4chO9XnW0EfyTUT0DENg3A=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuoBM-0007kR-PD for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:26:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7EB3C43464;
 Fri, 14 Aug 2026 09:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3938F1F000E9;
 Fri, 14 Aug 2026 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786699587;
 bh=q2SKTE3mDAWpbaUp39eqm6e7KDQqD/IN66nudQau/oY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=K+dMfBa0cyPdpFlv+0yqDbuU6SEvrn5eV7+4ThldVZG5r2IdybxdF/7vfINE9ISpP
 a/iSEGgmYcW3HJFxUFV7y7tTqTJaQW0XlaMmd/GdY1yhwjdrwvjOTUGs1G7z/zVknf
 j4e2PwiMAlzIZzOyTo34G+MzTvdCa0uE4CQfq4NTxMoHZ8Wj+pU8Xxz2D6AzobSEW9
 GewTkZpEL/0ua9CAy7hElj6XYY42VVzWnOpPDPnzV2jrJLy/yvh2E8OTz8BVdeDHwL
 XrGsu6umvUWNGh8qIb8NLyZAMeSw/ncDUPXkHTPnAXCACPKZtumXxJ+RLEdIOeqkOw
 mvhGBE9doSFZA==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Jens Axboe <axboe@kernel.dk>, Carlos Maiolino <cem@kernel.org>
Date: Fri, 14 Aug 2026 11:24:28 +0200
Message-ID: <20260814092448.1818082-12-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814092448.1818082-1-aalbersh@kernel.org>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wuoBM-0007kR-PD
Subject: [f2fs-dev] [PATCH v15 11/25] xfs: use BIO_COMPLETE_IN_TASK for
 bounce buffered read I/Os
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Tal Zussman <tz2294@columbia.edu>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Christoph Hellwig <hch@lst.de>

Stop using the xfs per-inode work struct for completing read bios, as
unlike writes we don't want to serialize reads on a single inode as
there is no exclusive resource contention for them.

Factor the code for kicking off a read that needs and ioend and the
task context completion into a single helper so that it is split off
the xfs_end_bio machinery, which is not only used for writes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_aops.c  | 10 ++++------
 fs/xfs/xfs_file.c  |  6 ++----
 fs/xfs/xfs_ioend.c | 32 +++++++++++++++++++++++++++-----
 fs/xfs/xfs_ioend.h |  2 ++
 4 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index a39dcd8c9a1c..d2484c4a6151 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -578,12 +578,10 @@ xfs_bio_submit_read(
 	const struct iomap_iter		*iter,
 	struct iomap_read_folio_ctx	*ctx)
 {
-	struct bio			*bio = ctx->read_ctx;
-
-	/* defer read completions to the ioend workqueue */
-	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset,
-		iomap_ioend_flags(&iter->iomap));
-	iomap_bio_submit_read_endio(iter, ctx, xfs_end_bio);
+	xfs_ioend_submit_read(iter->inode, ctx->read_ctx,
+			ctx->read_ctx_file_offset,
+			iomap_ioend_flags(&iter->iomap));
+	ctx->read_ctx = NULL;
 }
 
 static const struct iomap_read_ops xfs_iomap_read_ops = {
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 6d989bd1696b..b3e1263516dd 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -235,10 +235,8 @@ xfs_dio_read_bounce_submit_io(
 	struct bio		*bio,
 	loff_t			file_offset)
 {
-	iomap_init_ioend(iter->inode, bio, file_offset,
-		iomap_ioend_flags(&iter->iomap) | IOMAP_IOEND_DIRECT);
-	bio->bi_end_io = xfs_end_bio;
-	submit_bio(bio);
+	xfs_ioend_submit_read(iter->inode, bio, file_offset,
+			iomap_ioend_flags(&iter->iomap) | IOMAP_IOEND_DIRECT);
 }
 
 static const struct iomap_dio_ops xfs_dio_read_bounce_ops = {
diff --git a/fs/xfs/xfs_ioend.c b/fs/xfs/xfs_ioend.c
index 40695d18dac0..37a3ae8066e9 100644
--- a/fs/xfs/xfs_ioend.c
+++ b/fs/xfs/xfs_ioend.c
@@ -16,6 +16,32 @@
 #include "xfs_reflink.h"
 #include "xfs_zone_alloc.h"
 #include "xfs_ioend.h"
+#include <linux/bio-integrity.h>
+
+static void
+xfs_end_io_read(
+	struct bio		*bio)
+{
+	struct iomap_ioend	*ioend = iomap_ioend_from_bio(bio);
+	int			error = blk_status_to_errno(bio->bi_status);
+
+	iomap_finish_ioends(ioend, error);
+}
+
+void
+xfs_ioend_submit_read(
+	struct inode		*inode,
+	struct bio		*bio,
+	loff_t			file_offset,
+	u16			ioend_flags)
+{
+	iomap_init_ioend(inode, bio, file_offset, ioend_flags);
+	if (ioend_flags & IOMAP_IOEND_INTEGRITY)
+		fs_bio_integrity_alloc(bio);
+	bio->bi_end_io = xfs_end_io_read;
+	bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
+	submit_bio(bio);
+}
 
 static void
 xfs_ioend_put_open_zones(
@@ -148,11 +174,7 @@ xfs_end_io(
 			io_list))) {
 		list_del_init(&ioend->io_list);
 		iomap_ioend_try_merge(ioend, &tmp);
-		if (bio_op(&ioend->io_bio) == REQ_OP_READ)
-			iomap_finish_ioends(ioend,
-				blk_status_to_errno(ioend->io_bio.bi_status));
-		else
-			xfs_end_ioend_write(ioend);
+		xfs_end_ioend_write(ioend);
 		cond_resched();
 	}
 }
diff --git a/fs/xfs/xfs_ioend.h b/fs/xfs/xfs_ioend.h
index 525865767fca..7c2a1ea3e6ed 100644
--- a/fs/xfs/xfs_ioend.h
+++ b/fs/xfs/xfs_ioend.h
@@ -12,5 +12,7 @@ static inline bool xfs_ioend_is_append(struct iomap_ioend *ioend)
 }
 
 void xfs_end_bio(struct bio *bio);
+void xfs_ioend_submit_read(struct inode *inode, struct bio *bio,
+		loff_t file_offset, u16 ioend_flags);
 
 #endif /* __XFS_IOEND_H */
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
