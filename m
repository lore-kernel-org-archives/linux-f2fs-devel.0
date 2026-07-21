Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9CFC4452D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jt1/yO3iSU/vydy/FZT/1EQqnO7cIjvhwAx7/aPfjuM=; b=l/GsN2g+G3qnnx19/hb+q9/vKm
	WS3A1gUrgZm3nUelWy3JjYAy2jzcNJ4MO1FT7jt/suCe4uJWpRE+1b6oot/GbgJjc2gAIxFrGKzOs
	ffdugGwTrBcw7n18I2uMaMMV5jz+t4UBjxJQt8KiGfqJ4Q8aaZundYawbcr5BQ3t9Wks=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmFSq-0002Qi-6m;
	Tue, 21 Jul 2026 18:45:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wmFSR-0002Nc-Vi
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u81BkS3jMnJue5L3AYROT1gE9HvtANvaiLqhCodO2vM=; b=gWUB6/RB+Cq2SJnYAYDHCXFmVH
 O0IzO/qmsSt3DhUZqF7pfQHoQVUm3fbHWZMWd96G37olox18EOOIWOeqsrgl2tLAlWwtPZ2KvrDAD
 CkDV4IUZp+K8RLkAIkMDInNzAwaqPNbw5LuRiRDIn2FXQVynK4+fmC4aMm6l5X9LYMAU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u81BkS3jMnJue5L3AYROT1gE9HvtANvaiLqhCodO2vM=; b=WF6ciQk6NRO/yka9l9hKg1IBZl
 BjPB+qb070VD7ypQPnYDPzxwCY39gHFxFg+qdjDNp6yVuEk6JifE53M9TEP3WUJb7g15rU+Bvmbnt
 J/9anT9sC7CTl1BDLScM68l94od/7qw9GlX7i/jOZyVdorpNBtu0Sm0UOV+3eQVvm9Pw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmFSM-000323-1m for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AD04A43E88;
 Tue, 21 Jul 2026 18:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B251F00A3D;
 Tue, 21 Jul 2026 18:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784659476;
 bh=u81BkS3jMnJue5L3AYROT1gE9HvtANvaiLqhCodO2vM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IUzlk21AkPgwRnGJ7YHdWcJ3/MayMTE/pkXp/BJYB3anwkYcZ+NZ1lmBYxWgyaSes
 R329cBnCzJc941GqD3IQ2eenkpoFaMgr6XtRCkkg0vvdvZvb0w+0qhulleoNPEy0Vn
 b98Gs7a6oz7J9xWPIdfqLt3T5ko6t/cbPz+hLvvY1ckOAB5tU7i6r/zrEUMIht/Z9N
 mEiQ5d1xc2Erp9gYLQ1Axz9UGw79dh3lhSziOlLvrW4YQ3SIXsD865d3Yd6stnc9Zy
 cBAbX5uQFLWTTes0ehpttDtj93qSEU3foDqZ92wwQyueKANPfkU1sqZkS9QD2nNZ5i
 XxcavDrg08H8w==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 21 Jul 2026 20:40:51 +0200
Message-ID: <20260721184346.416657-15-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721184346.416657-1-aalbersh@kernel.org>
References: <20260721184346.416657-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wmFSM-000323-1m
Subject: [f2fs-dev] [PATCH v13 14/23] xfs: always prioritize fsverity
 metadata ioends in ioend completion
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

When both block device integrity checksums and fsverity are used, all
read ioends end up in the ioend processing. This means that fsverity
data and metadata ioends could both get on ioend queue ip->i_ioend_list.

Then, when worker pick ups the work, it will process all ioends in the
queue. Before, processing ioends are sorted based on file offset,
meaning data ioend first, metadata second. Metadata ioend already
holding folio lock, if data ioend needs this exact folio the worker will
self deadlock.

Fix this by prioritizing fsverity metadata while sorting read ioends.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/ioend.c      |  8 ++++----
 fs/xfs/xfs_aops.c     | 32 +++++++++++++++++++++++++++++++-
 include/linux/iomap.h |  5 ++++-
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 0565328764c1..8e46b7f1aa6a 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -4,7 +4,6 @@
  */
 #include <linux/bio-integrity.h>
 #include <linux/iomap.h>
-#include <linux/list_sort.h>
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
 #include <linux/fserror.h>
@@ -425,7 +424,7 @@ void iomap_ioend_try_merge(struct iomap_ioend *ioend,
 }
 EXPORT_SYMBOL_GPL(iomap_ioend_try_merge);
 
-static int iomap_ioend_compare(void *priv, const struct list_head *a,
+int iomap_ioend_compare(void *priv, const struct list_head *a,
 		const struct list_head *b)
 {
 	struct iomap_ioend *ia = container_of(a, struct iomap_ioend, io_list);
@@ -437,10 +436,11 @@ static int iomap_ioend_compare(void *priv, const struct list_head *a,
 		return 1;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(iomap_ioend_compare);
 
-void iomap_sort_ioends(struct list_head *ioend_list)
+void iomap_sort_ioends(struct list_head *ioend_list, list_cmp_func_t cmp)
 {
-	list_sort(NULL, ioend_list, iomap_ioend_compare);
+	list_sort(NULL, ioend_list, cmp);
 }
 EXPORT_SYMBOL_GPL(iomap_sort_ioends);
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 34d0ff7c7086..c7843a8776b0 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -182,6 +182,32 @@ xfs_end_ioend_write(
 	memalloc_nofs_restore(nofs_flag);
 }
 
+/*
+ * Prioritize fsverity metadata over file data. Sort based on i_size as fsverity
+ * metadata is always beyond EOF
+ */
+static int
+xfs_read_ioend_compare(
+	void			*priv,
+	const struct list_head	*a,
+	const struct list_head	*b)
+{
+	struct iomap_ioend	*ia = container_of(a, struct iomap_ioend,
+			io_list);
+	struct iomap_ioend	*ib = container_of(b, struct iomap_ioend,
+			io_list);
+	loff_t			i_size = i_size_read(ia->io_inode);
+
+	if (!IS_VERITY(ia->io_inode))
+		return iomap_ioend_compare(priv, a, b);
+
+	if (ia->io_offset > i_size && ib->io_offset < i_size)
+		return -1;
+	if (ia->io_offset < i_size && ib->io_offset > i_size)
+		return 1;
+	return 0;
+}
+
 /*
  * Finish all pending IO completions that require transactional modifications.
  *
@@ -210,7 +236,11 @@ xfs_end_io(
 	list_replace_init(&ip->i_ioend_list, &tmp);
 	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
 
-	iomap_sort_ioends(&tmp);
+	ioend = list_first_entry_or_null(&tmp, struct iomap_ioend, io_list);
+	if (bio_op(&ioend->io_bio) == REQ_OP_READ)
+		iomap_sort_ioends(&tmp, xfs_read_ioend_compare);
+	else
+		iomap_sort_ioends(&tmp, iomap_ioend_compare);
 	while ((ioend = list_first_entry_or_null(&tmp, struct iomap_ioend,
 			io_list))) {
 		list_del_init(&ioend->io_list);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 56b43d594e6e..36fc931382a8 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -10,6 +10,7 @@
 #include <linux/mm_types.h>
 #include <linux/blkdev.h>
 #include <linux/folio_batch.h>
+#include <linux/list_sort.h>
 
 struct address_space;
 struct fiemap_extent_info;
@@ -488,7 +489,9 @@ struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend,
 void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
 void iomap_ioend_try_merge(struct iomap_ioend *ioend,
 		struct list_head *more_ioends);
-void iomap_sort_ioends(struct list_head *ioend_list);
+int iomap_ioend_compare(void *priv, const struct list_head *a,
+		const struct list_head *b);
+void iomap_sort_ioends(struct list_head *ioend_list, list_cmp_func_t cmp);
 ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len);
 int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
