Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337A5C5CFC1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iQPnzf/+1evzij0vaY4z0ZQlmY4j6IAYC9YRcSREG54=; b=IsOK85jv+BZec0DZQ8oIEoEBXX
	5Dt4EJYDrY4e4Waf13mPJQM4ZRBYPX7b+yPeLJkVJ6wEJamjWmZMiF1C6ese56Bga4TPSWnrYhFVA
	wN8/rtJUeGnrITjEyBHr4Abmr4v3mB+tiwwuQ5d22a/7iDf9sBwUJ8kZlLGpx8mG3tOA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuoBK-0006G0-U6;
	Fri, 14 Aug 2026 09:26:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wuoBJ-0006Fr-IZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:26:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lGL8NsZlcEAeC8jVNcrKN+dXzs/Q/Uw4+7q/XmRaGvQ=; b=iNG8TdFe3YbqJsyrc+xip6Sb8T
 5BJChaNxxXHV0JCXJeufsnfsN5WmJmXOgXHllP9rHqnYXlecVRxSoKKYlgK+vh9amOqY+7YprRyFR
 MAVtC0haXtItKti1UcSa+ZbcP+ayPFuyDui8S+8VAogQCqjQTrZjPJm0cE6iy/X8ixvY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lGL8NsZlcEAeC8jVNcrKN+dXzs/Q/Uw4+7q/XmRaGvQ=; b=a+GbqG1pD9c+kcbb8g66YlNDBI
 wy5Z82J5PFLCdIa3svLWYyi5Roq2rzxW8q4ktwpK4D+NEzSx2GqaOLXZU9EpQtO6FZ7beq8W3EnPH
 fgFldYGU7ynfL2zWTDoKtfT34ynSVTQkOYExYCE+Rz9S0tSMxGOmhppZL6IZS0NihMcA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuoBH-0007kG-Vj for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:26:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AD4EF42434;
 Fri, 14 Aug 2026 09:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E84A1F00A3D;
 Fri, 14 Aug 2026 09:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786699582;
 bh=lGL8NsZlcEAeC8jVNcrKN+dXzs/Q/Uw4+7q/XmRaGvQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UEgGk0NiozQwdsLlSYm5AiE2L6bFnzuxoQZoPHQzW9t65o3GrzP9mOePOsDtqg8hS
 h4GsOaXx8kvLw/kAC0X58mqMNsKPtHxo2auzdnTGwEElvdDGEmDBCgHiI1sxD3ea/P
 DcUgCLAGow7GSqI34XIyP+g4TgHxqf7/TytR6AK0DKJgRq7D7QYKMEVS+zl1ZJIWZd
 qM2Zsc7On9RwOXsvP/1n67ztqbEfabTNBdwkdRWa5IxHbxT5hBZAFniBUk1+fayQrb
 J7x4gVzYzunl0e7kfUb0nd85eqbGFcN+w6MStKnXlzqt7AN23mMvVJHMIpqCmUDQZu
 PpR9DfcTrrjpA==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Jens Axboe <axboe@kernel.dk>, Carlos Maiolino <cem@kernel.org>
Date: Fri, 14 Aug 2026 11:24:27 +0200
Message-ID: <20260814092448.1818082-11-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814092448.1818082-1-aalbersh@kernel.org>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wuoBH-0007kG-Vj
Subject: [f2fs-dev] [PATCH v15 10/25] iomap: add a IOMAP_IOEND_INTEGRITY flag
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

This will make it easier to share code for the various submit callback
provided by the file system to iomap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/ioend.c      |  2 +-
 fs/xfs/xfs_aops.c     |  5 +++--
 fs/xfs/xfs_file.c     |  5 +++--
 include/linux/iomap.h | 11 ++++++++++-
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index d71e7f5609c6..dece11397cd7 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -149,7 +149,7 @@ int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
 		return error;
 	}
 
-	if (wpc->iomap.flags & IOMAP_F_INTEGRITY)
+	if (ioend->io_flags & IOMAP_IOEND_INTEGRITY)
 		fs_bio_integrity_generate(&ioend->io_bio);
 	submit_bio(&ioend->io_bio);
 	return 0;
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 6f21e207a0ad..a39dcd8c9a1c 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -491,7 +491,7 @@ xfs_zoned_writeback_submit(
 		bio_endio(&ioend->io_bio);
 		return error;
 	}
-	if (wpc->iomap.flags & IOMAP_F_INTEGRITY)
+	if (ioend->io_flags & IOMAP_IOEND_INTEGRITY)
 		fs_bio_integrity_generate(&ioend->io_bio);
 	xfs_zone_alloc_and_submit(ioend, &XFS_ZWPC(wpc)->open_zone);
 	return 0;
@@ -581,7 +581,8 @@ xfs_bio_submit_read(
 	struct bio			*bio = ctx->read_ctx;
 
 	/* defer read completions to the ioend workqueue */
-	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
+	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset,
+		iomap_ioend_flags(&iter->iomap));
 	iomap_bio_submit_read_endio(iter, ctx, xfs_end_bio);
 }
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ef29dba6e38e..6d989bd1696b 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -235,7 +235,8 @@ xfs_dio_read_bounce_submit_io(
 	struct bio		*bio,
 	loff_t			file_offset)
 {
-	iomap_init_ioend(iter->inode, bio, file_offset, IOMAP_IOEND_DIRECT);
+	iomap_init_ioend(iter->inode, bio, file_offset,
+		iomap_ioend_flags(&iter->iomap) | IOMAP_IOEND_DIRECT);
 	bio->bi_end_io = xfs_end_bio;
 	submit_bio(bio);
 }
@@ -724,7 +725,7 @@ xfs_dio_zoned_submit_io(
 
 	bio->bi_end_io = xfs_end_bio;
 	ioend = iomap_init_ioend(iter->inode, bio, file_offset,
-			IOMAP_IOEND_DIRECT);
+		iomap_ioend_flags(&iter->iomap) | IOMAP_IOEND_DIRECT);
 	xfs_zone_alloc_and_submit(ioend, &ac->open_zone);
 }
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 7328e30fb8ad..0959b97e641b 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -406,6 +406,12 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 #define IOMAP_IOEND_DIRECT		(1U << 3)
 /* is DONTCACHE I/O */
 #define IOMAP_IOEND_DONTCACHE		(1U << 4)
+/* generate integrity (PI) information */
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+#define IOMAP_IOEND_INTEGRITY		(1U << 5)
+#else
+#define IOMAP_IOEND_INTEGRITY		0
+#endif /* CONFIG_BLK_DEV_INTEGRITY */
 
 /*
  * Flags that if set on either ioend prevent the merge of two ioends.
@@ -413,7 +419,7 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
  */
 #define IOMAP_IOEND_NOMERGE_FLAGS \
 	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_DIRECT | \
-	 IOMAP_IOEND_DONTCACHE)
+	 IOMAP_IOEND_DONTCACHE | IOMAP_IOEND_INTEGRITY)
 
 /* ioend flags directly implied by iomap flags */
 static inline u16 iomap_ioend_flags(const struct iomap *iomap)
@@ -424,6 +430,9 @@ static inline u16 iomap_ioend_flags(const struct iomap *iomap)
 		flags |= IOMAP_IOEND_UNWRITTEN;
 	if (iomap->flags & IOMAP_F_SHARED)
 		flags |= IOMAP_IOEND_SHARED;
+	if (iomap->flags & IOMAP_F_INTEGRITY)
+		flags |= IOMAP_IOEND_INTEGRITY;
+
 	return flags;
 }
 
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
