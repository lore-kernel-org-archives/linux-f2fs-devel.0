Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB9606A899
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=g1lHiGdU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PfRFa9qu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IiFwFuBK;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BaBmiDYN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=4G0OX1b11ic7XXshR1R/nL5XqqTmDD95vdqqv33iq20=; b=g1lHiGdUP8e8usEb81qx9lG2Rr
	8jBGSNO584C3GDfnGm0VbRrK5YMcLv/IyzGW2GThjPpiwk3u3lhemc1xM1Zg1ugjE/qoPCTcDTPZt
	CtBGAapX+X1ST67ypOy00CRX5/WBdBDJVD096j7gPXUX27F6Cd0E4ziyRk1ksNJWaJts=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo1v-00000000588-22aF;
	Mon, 16 Nov 2026 04:09:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo1o-0000000057v-1PvR
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rp6mLVICdBq8/4/FX4qIz2SbL5wJln/BJ9o7bQJODlM=; b=PfRFa9quV3NLm5ZiZj6QF+f9bD
 M9TpQ32Klzo6oLSKTIaY9DEYxxoV3cSYil56NEtF3ao94QXR1S44eKeEywVc71Ii33qNENn9aA5j6
 jBnNkoueQqFGkdqDXRXd2ONOrLBq1dOkhzJNKu6xDgFow6YlJaEsd/GoDRjiqykRozQ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rp6mLVICdBq8/4/FX4qIz2SbL5wJln/BJ9o7bQJODlM=; b=IiFwFuBKdyZOnUx3KzcdjZjB2r
 yV3MgiWAJVrLfyn+slLs9ic6iaEzv6JHTqqEIHBzeg9vYrYm9t3/epsy3RtB62rIKlb2hs/qe2RAd
 sz8QlCy2MdyDtsIWFzrpy5mpcR78IdtGdm248lldqB8FWHm8wmzjYkyHFIT2sxLJshvg=;
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo1m-000000005fn-2MKT
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:12 +0000
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2e977109392so16017415ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802145; x=1795406945; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rp6mLVICdBq8/4/FX4qIz2SbL5wJln/BJ9o7bQJODlM=;
 b=BaBmiDYNtEI1bCDv1qj/q5E7PxcFT6EZpIXCyRvyVRpIv6xgCZL3VXVuGSEA0U/cOY
 7mG7bS/ZeJfhu0dvW5qgYw9S37NWyo53OF3fEv7ighk/dNhltw1EXjArFgkAh+tBhIhi
 11y6fvN31yM5BDcs1NkJk0buO3G4DSSe3CPINpsVdkzKvyC2k0miTywORkF8IsJh21CD
 nBldwpuz+4PPK162Yjp91wjwPwvRhimHKmrF798gY7zhAAi8badIHhO1fhBKg8Y5p0+A
 O1Wcf6sY+ZyaxQhJyj5Jar1PhszyW3s34CeBWW1+v9aZsfTzyXshneByzbIpFb4FKhaK
 iNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802145; x=1795406945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rp6mLVICdBq8/4/FX4qIz2SbL5wJln/BJ9o7bQJODlM=;
 b=W2wnwKnerRJ9d76DVxYB7ysQAYxqvtPnFO5pkeIOhQdzKva5/3T/KyDoSaqoAxQPO0
 u0pMXZAZ4c+7SpGMKQkskxTbr3si2k9/CBus+QI+DDne+ps6zibFgAPTzfG3MzuYml/v
 GWJsQrclplydfLfBs6ne9UZ63hIqY/5kZe4E05JJXI43mBGSR67quZIeCfO2WQVPJEgN
 OMlEnWlIwMngnEN4yjoXiveIUeBYbHUnSwvSZEZmP4pZHxy13ar/s3tIZa1yTYGQH+8z
 jbMPwGavbi0tfs8nGvqAt5PoQjXlB2D/kuQt2srKb+6V00JL+QgvjJaCoE+UEQ8BJWrp
 6eVw==
X-Forwarded-Encrypted: i=1;
 AL+hErEIU4xcevis+Wdup0x+9fcEJS3Fx/QunwkeRKPg0xQ3S24tdQ1poR52LOSUzo8NV7x0sabZyfgZHCkBsQ6apTct@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8GO60+ToQ8DeVrnhh/dBJnewlKzcl0Hf6xgZHUYkPz7KZrZKO/
 PRJkEIB33DnZuKYXmNU+00k1jSS5NuFa76WGZZmrDlwd+S67zgkUse0f
X-Gm-Gg: AYBFou0JEpcSQnd2uuVmSoOP0UfHPJtVVGeQs0/5By5qMNbYaSJt3/yISB2KZQPRwbF
 MwrKzf2bXUmQMWgbGCPBdC8sE05t3FWDKqxUYNhpTFTPng2c9VGMmU64hHBHVeFa4UqD0x9nWzW
 NksQbJgCpByuc471sZjfV1IH0YJU1Cn1xcaMk0Jiv829AHQj+dXTYlRhl2eSGzx2o1d8qIJDbk1
 0xLwViPUC84aYpFlQY+2RDgybz4OUnd3M0UCvi3h/n674dM5nd+ZAhu4w6ehOV4vOg78VDbwH4G
 k5DgpvjG/Ho148sKdqxD6TD7E0m9Qz492GSw4Y6hUWKw2Qh6nSX8J3qL4eLfLsJxu00o5igtpe0
 JwncaoqAQiT6jbzGbQY+xLYgw8xIC8cQITnxPOoq08/Eef0pWUunese01zasKZvPuzq/WBCybiM
 /W7t+LphaQm6UohVPdX3hiwMubTnUk5BP9f9Wkb2JoInid7TTlbuhwA1vlitBCuO+K1yssxuuZt
 GuueyKqy6PW9aRgNDF0ODm8wiDh0CVFf498YAWv6T6DKbn+5zhLzCVcNPGwDpz8GzDLZOvr7Qa+
 kNDai/I6hAtCZvVxbg9WH2ZQ+QOZ05yqUNt+wxN8vIdZ0qb+SeeGd6vpONpMSLEBv7HKuq/2AlP
 Ry9cFOh68A49rsX6jJlmXCMBXJlFLn5bk9HP91bx6Q1r5Px8=
X-Received: by 2002:a17:90b:17d1:b0:3ac:9a5e:9ce9 with SMTP id
 98e67ed59e1d1-3b1b0a3b41cmr10101949a91.29.1794802144505; 
 Sun, 15 Nov 2026 20:09:04 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:03 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:34 -0800
Message-ID: <20261116040851.2849696-4-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo1m-000000005fn-2MKT
Subject: [f2fs-dev] [PATCH v2 03/20] f2fs: extend f2fs_folio_state for
 subpage blocks
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

With subpage blocks, even an order-0 folio holds several blocks, so
track uptodate and dirty state per block for any folio that holds more
than one block, not only for large folios.

- Identify the folio state by a magic number. An order-0 folio can carry
  one now, so folio_test_large() no longer tells it apart from the
  context of a compressed page, which folio->private can also point to.
  Carry the page private flags over when the state is attached.
- Make the uptodate and dirty helpers take block indices, and attach the
  state on demand in them. Some of their callers cannot return an error,
  e.g. f2fs_set_link() and f2fs_delete_entry() once a directory folio
  holds several blocks, so allocate the state with __GFP_NOFAIL, as
  ifs_alloc() does in iomap, and drop the allocation failure handling
  of the callers. The write paths attach the state before a folio is
  dirtied, so writeback does not normally have to allocate it.
- Handle per-block state in invalidation, dirtying and writeback.
- Clear PAGECACHE_TAG_TOWRITE as well as PAGECACHE_TAG_DIRTY in
  f2fs_clear_page_cache_dirty_tag().

Some of these changes also apply to large folios when the block size
equals PAGE_SIZE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c    | 440 ++++++++++++++++++++++++++--------------------
 fs/f2fs/f2fs.h    |  35 ++--
 fs/f2fs/file.c    |  18 +-
 fs/f2fs/segment.c |   2 +-
 4 files changed, 269 insertions(+), 226 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index aacc92839f61..b913d53e96e7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -96,15 +96,14 @@ struct bio_post_read_ctx {
 static bool __ffs_mark_subrange_uptodate(struct folio *folio,
 		struct f2fs_folio_state *ffs, size_t offset, size_t len)
 {
-	unsigned int nr_subpages = folio_nr_pages(folio);
-	unsigned int start, end;
-
-	start = offset >> PAGE_SHIFT;
-	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	end = min(end, nr_subpages);
+	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
+	unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
+	unsigned int start = F2FS_BYTES_TO_BLK(sbi, offset);
+	unsigned int end = min_t(unsigned int,
+				F2FS_BLK_ALIGN(sbi, offset + len), nr_blocks);
 
 	bitmap_set(ffs->state, start, end - start);
-	return bitmap_full(ffs->state, nr_subpages);
+	return bitmap_full(ffs->state, nr_blocks);
 }
 
 /*
@@ -122,7 +121,7 @@ static bool __ffs_mark_subrange_uptodate(struct folio *folio,
  * release the bio's reference to the decompress_io_ctx of the page's cluster.
  */
 /*
- * Update read_pages_pending.
+ * Update read_blocks_pending.
  */
 static inline void f2fs_update_read_folio_pending(struct folio *folio, int nr)
 {
@@ -134,7 +133,7 @@ static inline void f2fs_update_read_folio_pending(struct folio *folio, int nr)
 
 	ffs = (struct f2fs_folio_state *)folio->private;
 	spin_lock_irqsave(&ffs->state_lock, flags);
-	ffs->read_pages_pending += nr;
+	ffs->read_blocks_pending += nr;
 	spin_unlock_irqrestore(&ffs->state_lock, flags);
 }
 
@@ -173,8 +172,8 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			if (uptodate)
 				uptodate = __ffs_mark_subrange_uptodate(folio, ffs,
 						fi.offset, fi.length);
-			ffs->read_pages_pending -= nr_pages;
-			finished = !ffs->read_pages_pending;
+			ffs->read_blocks_pending -= nr_pages;
+			finished = !ffs->read_blocks_pending;
 			spin_unlock_irqrestore(&ffs->state_lock, flags);
 		}
 
@@ -372,18 +371,18 @@ bool f2fs_ffs_has_dirty_subpage(struct folio *folio)
 {
 	struct f2fs_folio_state *ffs;
 	unsigned long flags;
-	unsigned int nr_subpages;
+	unsigned int nr_blocks;
 	bool dirty;
 
 	if (!f2fs_folio_has_ffs(folio))
 		return false;
 
 	ffs = (struct f2fs_folio_state *)folio->private;
-	nr_subpages = folio_nr_pages(folio);
+	nr_blocks = f2fs_blocks_per_folio(F2FS_F_SB(folio), folio);
 
 	spin_lock_irqsave(&ffs->state_lock, flags);
-	dirty = find_next_bit(ffs->state, 2 * nr_subpages,
-				nr_subpages) < 2 * nr_subpages;
+	dirty = find_next_bit(ffs->state, 2 * nr_blocks,
+				nr_blocks) < 2 * nr_blocks;
 	spin_unlock_irqrestore(&ffs->state_lock, flags);
 
 	return dirty;
@@ -402,7 +401,7 @@ static void f2fs_ffs_put_write_pending(struct folio *folio, unsigned int nr)
 		goto release;
 
 	ffs = (struct f2fs_folio_state *)folio->private;
-	if (!atomic_sub_and_test(nr, &ffs->write_pages_pending))
+	if (!atomic_sub_and_test(nr, &ffs->write_blocks_pending))
 		return;
 release:
 	if (!f2fs_ffs_has_dirty_subpage(folio))
@@ -1572,7 +1571,7 @@ static int f2fs_submit_page_read_sync(struct inode *inode, struct folio *folio,
 			      REQ_OP_READ, true);
 
 	/* Wait until all bios have completed (pending drops back to our bias). */
-	while (READ_ONCE(ffs->read_pages_pending) != 1)
+	while (READ_ONCE(ffs->read_blocks_pending) != 1)
 		f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 
 	/* Remove the bias. */
@@ -1693,12 +1692,8 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
 	if (IS_ERR(folio))
 		return folio;
 
-	if (folio_test_large(folio)) {
-		if (!f2fs_ffs_find_or_alloc(folio)) {
-			err = -ENOMEM;
-			goto put_err;
-		}
-	}
+	if (folio_test_large(folio))
+		f2fs_ffs_find_or_alloc(folio);
 
 	if (f2fs_lookup_read_extent_cache_block(inode, index,
 						&dn.data_blkaddr)) {
@@ -1821,12 +1816,8 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 	 * for a fully uptodate folio; a partially uptodate one cannot be
 	 * rebuilt and will fail the subpage check below.
 	 */
-	if (folio_test_large(folio) && !f2fs_folio_has_ffs(folio)) {
-		if (!f2fs_ffs_find_or_alloc(folio)) {
-			f2fs_folio_put(folio, true);
-			return ERR_PTR(-ENOMEM);
-		}
-	}
+	if (folio_test_large(folio) && !f2fs_folio_has_ffs(folio))
+		f2fs_ffs_find_or_alloc(folio);
 
 	if (unlikely(!f2fs_ffs_test_blk_uptodate(folio, index))) {
 		f2fs_folio_put(folio, true);
@@ -1862,12 +1853,6 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (folio_test_large(folio) && !f2fs_ffs_find_or_alloc(folio)) {
-		f2fs_folio_put(folio, true);
-		f2fs_put_cache(ientry, true);
-		return ERR_PTR(-ENOMEM);
-	}
-
 	set_new_dnode(&dn, inode, ientry, NULL, 0);
 	err = f2fs_reserve_block(&dn, index);
 	if (err) {
@@ -2900,29 +2885,43 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio)
 {
-	struct f2fs_folio_state *ffs;
-	unsigned int nr_subpages = folio_nr_pages(folio);
-	unsigned long private = (unsigned long)folio->private;
-
-	f2fs_bug_on(F2FS_F_SB(folio), !folio_test_large(folio));
-	f2fs_bug_on(F2FS_F_SB(folio),
-		    test_bit(F2FS_FOLIO_PRIVATE_NOT_POINTER, &private));
+	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
+	struct f2fs_folio_state *ffs = folio->private;
+	unsigned int nr_blocks;
+	unsigned long private_flags;
 
 	if (f2fs_folio_has_ffs(folio))
-		return (struct f2fs_folio_state *)folio->private;
+		return ffs;
 
-	ffs = f2fs_kmalloc(F2FS_F_SB(folio),
-			struct_size(ffs, state, BITS_TO_LONGS(2 * nr_subpages)),
-			GFP_NOFS | __GFP_ZERO);
-	if (!ffs)
-		return NULL;
+	/* Carry over the page private flags kept in folio->private. */
+	private_flags = f2fs_folio_get_private_flags(folio);
 
+	nr_blocks = f2fs_blocks_per_folio(sbi, folio);
+	ffs = kzalloc(struct_size(ffs, state, BITS_TO_LONGS(2 * nr_blocks)),
+			GFP_NOIO | __GFP_NOFAIL);
+
+	ffs->magic = F2FS_FOLIO_STATE_MAGIC;
 	spin_lock_init(&ffs->state_lock);
+	ffs->private_flags = private_flags;
 	if (folio_test_uptodate(folio))
-		bitmap_set(ffs->state, 0, nr_subpages);
-	if (folio_test_dirty(folio))
-		bitmap_set(ffs->state, nr_subpages, nr_subpages);
+		bitmap_set(ffs->state, 0, nr_blocks);
+	if (folio_test_dirty(folio)) {
+		struct inode *inode = folio->mapping->host;
+		pgoff_t last_lblk = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
+		pgoff_t first_lblk = f2fs_folio_lblk(sbi, folio);
+		pgoff_t valid_blocks = 0;
 
+		if (f2fs_verity_in_progress(inode))
+			valid_blocks = nr_blocks;
+		else if (first_lblk < last_lblk)
+			valid_blocks = min_t(pgoff_t, nr_blocks,
+					     last_lblk - first_lblk);
+
+		if (valid_blocks)
+			bitmap_set(ffs->state, nr_blocks, valid_blocks);
+	}
+
+	folio_detach_private(folio);
 	folio_attach_private(folio, ffs);
 	return ffs;
 }
@@ -2940,17 +2939,17 @@ static void ffs_detach_free(struct folio *folio)
 	if (!ffs)
 		return;
 
-	WARN_ON_ONCE(ffs->read_pages_pending != 0);
-	WARN_ON_ONCE(atomic_read(&ffs->write_pages_pending));
+	WARN_ON_ONCE(ffs->read_blocks_pending != 0);
+	WARN_ON_ONCE(atomic_read(&ffs->write_blocks_pending));
+	ffs->magic = 0;
 	kfree(ffs);
 }
 
 bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index)
 {
+	struct f2fs_sb_info *sbi = F2FS_M_SB(folio->mapping);
 	struct f2fs_folio_state *ffs;
-	unsigned int idx;
-
-	f2fs_bug_on(F2FS_F_SB(folio), !folio_contains(folio, index));
+	pgoff_t offset;
 
 	if (folio_test_uptodate(folio))
 		return true;
@@ -2958,63 +2957,60 @@ bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index)
 	if (!f2fs_folio_has_ffs(folio))
 		return false;
 
-	ffs = (struct f2fs_folio_state *)folio->private;
-	idx = index - folio->index;
-	return test_bit(idx, ffs->state);
+	ffs = folio->private;
+	offset = f2fs_folio_blk_offset(sbi, folio, index);
+	if (WARN_ON_ONCE(offset >= f2fs_blocks_per_folio(sbi, folio)))
+		return false;
+
+	if (test_bit(offset, ffs->state)) {
+		/* Order the bit test before reading the block data */
+		smp_rmb();
+		return true;
+	}
+	return false;
 }
 
 void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
 				       size_t len)
 {
+	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 	struct f2fs_folio_state *ffs;
 	unsigned long flags;
 	bool mark_uptodate = false;
 
 	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
 
-	if (!f2fs_folio_has_ffs(folio)) {
+	if (!f2fs_is_multiblock_folio(sbi, folio)) {
 		folio_mark_uptodate(folio);
 		return;
 	}
 
-	ffs = (struct f2fs_folio_state *)folio->private;
-	spin_lock_irqsave(&ffs->state_lock, flags);
-	mark_uptodate = __ffs_mark_subrange_uptodate(folio, ffs, offset, len) &&
-			!ffs->read_pages_pending;
-	spin_unlock_irqrestore(&ffs->state_lock, flags);
-	if (mark_uptodate)
+	/*
+	 * Without f2fs_folio_state, the folio uptodate flag covers every block,
+	 * so marking the whole folio needs no allocation. This keeps bio
+	 * completion paths such as decompression free of allocation.
+	 */
+	if (!f2fs_folio_has_ffs(folio) && !offset && len >= folio_size(folio)) {
 		folio_mark_uptodate(folio);
-}
-
-static void ffs_clear_subrange_uptodate(struct folio *folio,
-					size_t offset, size_t len)
-{
-	struct f2fs_folio_state *ffs;
-	unsigned int nr_subpages, start, end;
-	unsigned long flags;
-
-	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
-
-	if (!f2fs_folio_has_ffs(folio))
 		return;
+	}
 
-	ffs = (struct f2fs_folio_state *)folio->private;
-	nr_subpages = folio_nr_pages(folio);
-	start = offset >> PAGE_SHIFT;
-	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	end = min(end, nr_subpages);
-
+	ffs = f2fs_ffs_find_or_alloc(folio);
 	spin_lock_irqsave(&ffs->state_lock, flags);
-	bitmap_clear(ffs->state, start, end - start);
+	mark_uptodate = __ffs_mark_subrange_uptodate(folio, ffs, offset, len) &&
+			!ffs->read_blocks_pending;
 	spin_unlock_irqrestore(&ffs->state_lock, flags);
+	if (mark_uptodate)
+		folio_mark_uptodate(folio);
 }
 
 static void f2fs_clear_truncated_page_state(struct folio *folio, pgoff_t i)
 {
+	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
+
 	if (f2fs_folio_has_ffs(folio)) {
-		ffs_clear_subrange_uptodate(folio,
-				(loff_t)i << PAGE_SHIFT, PAGE_SIZE);
-		folio_clear_uptodate(folio);
+		f2fs_ffs_clear_subrange_uptodate(folio,
+				F2FS_BLK_TO_BYTES(sbi, i), F2FS_BLKSIZE(sbi));
 	} else {
 		folio_clear_uptodate(folio);
 		folio_clear_f2fs_gcing(folio);
@@ -3023,33 +3019,36 @@ static void f2fs_clear_truncated_page_state(struct folio *folio, pgoff_t i)
 
 bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index)
 {
+	struct f2fs_sb_info *sbi = F2FS_M_SB(folio->mapping);
 	struct f2fs_folio_state *ffs;
-	unsigned int idx, nr_subpages;
-
-	f2fs_bug_on(F2FS_F_SB(folio), !folio_contains(folio, index));
+	unsigned int nr_blocks;
+	pgoff_t offset;
 
 	if (!f2fs_folio_has_ffs(folio))
 		return folio_test_dirty(folio);
 
-	ffs = (struct f2fs_folio_state *)folio->private;
-	nr_subpages = folio_nr_pages(folio);
-	idx = index - folio->index;
-	return test_bit(nr_subpages + idx, ffs->state);
+	ffs = folio->private;
+	nr_blocks = f2fs_blocks_per_folio(sbi, folio);
+	offset = f2fs_folio_blk_offset(sbi, folio, index);
+	if (WARN_ON_ONCE(offset >= nr_blocks))
+		return false;
+
+	return test_bit(nr_blocks + offset, ffs->state);
 }
 
 static unsigned int __ffs_mark_subrange_dirty(struct folio *folio,
 			struct f2fs_folio_state *ffs, size_t offset, size_t len)
 {
-	unsigned int nr_subpages = folio_nr_pages(folio);
+	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
+	unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
 	unsigned int start, end, before;
 
-	start = offset >> PAGE_SHIFT;
-	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	end = min(end, nr_subpages);
+	start = F2FS_BYTES_TO_BLK(sbi, offset);
+	end = min_t(unsigned int, F2FS_BLK_ALIGN(sbi, offset + len), nr_blocks);
 
-	before = bitmap_weight(ffs->state, 2 * nr_subpages);
-	bitmap_set(ffs->state, nr_subpages + start, end - start);
-	return bitmap_weight(ffs->state, 2 * nr_subpages) - before;
+	before = bitmap_weight(ffs->state, 2 * nr_blocks);
+	bitmap_set(ffs->state, nr_blocks + start, end - start);
+	return bitmap_weight(ffs->state, 2 * nr_blocks) - before;
 }
 
 /*
@@ -3062,16 +3061,17 @@ static unsigned int __ffs_mark_subrange_dirty(struct folio *folio,
 void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
 				    size_t offset, size_t len)
 {
+	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 	struct f2fs_folio_state *ffs;
 	unsigned int set;
 	unsigned long flags;
 
 	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
 
-	if (!f2fs_folio_has_ffs(folio))
+	if (!f2fs_is_multiblock_folio(sbi, folio))
 		return;
 
-	ffs = (struct f2fs_folio_state *)folio->private;
+	ffs = f2fs_ffs_find_or_alloc(folio);
 
 	spin_lock_irqsave(&ffs->state_lock, flags);
 	set = __ffs_mark_subrange_dirty(folio, ffs, offset, len);
@@ -3081,22 +3081,54 @@ void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
 		f2fs_account_dirty_blocks(folio->mapping->host, set);
 }
 
+void f2fs_ffs_clear_subrange_uptodate(struct folio *folio,
+					     size_t offset, size_t len)
+{
+	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
+	struct f2fs_folio_state *ffs;
+	unsigned int nr_blocks, start, end;
+	unsigned long flags;
+
+	f2fs_bug_on(sbi, offset + len > folio_size(folio));
+
+	if (!f2fs_folio_has_ffs(folio)) {
+		if (!folio_test_uptodate(folio))
+			return;
+		/* Without ffs, clearing the whole folio needs no allocation. */
+		if (!offset && len >= folio_size(folio)) {
+			folio_clear_uptodate(folio);
+			return;
+		}
+	}
+
+	ffs = f2fs_ffs_find_or_alloc(folio);
+	nr_blocks = f2fs_blocks_per_folio(sbi, folio);
+	start = F2FS_BYTES_TO_BLK(sbi, offset);
+	end = min_t(unsigned int, F2FS_BLK_ALIGN(sbi, offset + len), nr_blocks);
+
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	bitmap_clear(ffs->state, start, end - start);
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+	if (folio_test_uptodate(folio))
+		folio_clear_uptodate(folio);
+}
+
 static bool __ffs_clear_subrange_dirty(struct folio *folio,
 			struct f2fs_folio_state *ffs, size_t offset, size_t len,
 			unsigned int *cleared)
 {
-	unsigned int nr_subpages = folio_nr_pages(folio);
+	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
+	unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
 	unsigned int start, end, before;
 
-	start = offset >> PAGE_SHIFT;
-	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	end = min(end, nr_subpages);
+	start = F2FS_BYTES_TO_BLK(sbi, offset);
+	end = min_t(unsigned int, F2FS_BLK_ALIGN(sbi, offset + len), nr_blocks);
 
-	before = bitmap_weight(ffs->state, 2 * nr_subpages);
-	bitmap_clear(ffs->state, nr_subpages + start, end - start);
-	*cleared = before - bitmap_weight(ffs->state, 2 * nr_subpages);
-	return find_next_bit(ffs->state, 2 * nr_subpages, nr_subpages) <
-			2 * nr_subpages;
+	before = bitmap_weight(ffs->state, 2 * nr_blocks);
+	bitmap_clear(ffs->state, nr_blocks + start, end - start);
+	*cleared = before - bitmap_weight(ffs->state, 2 * nr_blocks);
+	return find_next_bit(ffs->state, 2 * nr_blocks, nr_blocks) <
+			2 * nr_blocks;
 }
 
 /**
@@ -3117,10 +3149,19 @@ bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 	unsigned int cleared = 0;
 	bool dirty;
 
-	if (!f2fs_folio_has_ffs(folio))
-		return false;
+	if (!f2fs_folio_has_ffs(folio)) {
+		/*
+		 * Without ffs, the folio dirty flag covers every block. Callers
+		 * that clear the flag first (writeback, GC) must have ffs.
+		 */
+		if (!folio_test_dirty(folio))
+			return false;
+		/* Clearing the whole folio leaves no dirty block. */
+		if (!offset && len >= folio_size(folio))
+			return false;
+	}
 
-	ffs = (struct f2fs_folio_state *)folio->private;
+	ffs = f2fs_ffs_find_or_alloc(folio);
 	spin_lock_irqsave(&ffs->state_lock, flags);
 	dirty = __ffs_clear_subrange_dirty(folio, ffs, offset, len, &cleared);
 	spin_unlock_irqrestore(&ffs->state_lock, flags);
@@ -3131,55 +3172,37 @@ bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 	return dirty;
 }
 
-static unsigned int ffs_next_dirty_subpage(struct f2fs_folio_state *ffs,
-			const struct folio *folio, unsigned int start,
-			unsigned int end)
-{
-	unsigned int nr_subpages = folio_nr_pages(folio);
-
-	return find_next_bit(ffs->state, nr_subpages + end + 1,
-			nr_subpages + start) - nr_subpages;
-}
-
-static unsigned int ffs_next_clean_subpage(struct f2fs_folio_state *ffs,
-			const struct folio *folio, unsigned int start,
-			unsigned int end)
-{
-	unsigned int nr_subpages = folio_nr_pages(folio);
-
-	return find_next_zero_bit(ffs->state, nr_subpages + end + 1,
-			nr_subpages + start) - nr_subpages;
-}
-
-static unsigned int ffs_find_dirty_range(struct folio *folio,
-					u64 *range_start, u64 range_end)
+bool f2fs_ffs_dirty_blk_range(struct folio *folio, unsigned int from,
+			      unsigned int to, unsigned int *start,
+			      unsigned int *count)
 {
+	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 	struct f2fs_folio_state *ffs;
-	unsigned int start, end, nr_pages;
-
-	if (*range_start >= range_end)
-		return 0;
-
-	if (!f2fs_folio_has_ffs(folio))
-		return range_end - *range_start;
-
-	ffs = (struct f2fs_folio_state *)folio->private;
-	start = offset_in_folio(folio, *range_start) >> PAGE_SHIFT;
-	end = DIV_ROUND_UP(min_not_zero(offset_in_folio(folio, range_end),
-					folio_size(folio)), PAGE_SIZE) - 1;
+	unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
+	unsigned long flags;
 
-	start = ffs_next_dirty_subpage(ffs, folio, start, end);
-	if (start > end)
-		return 0;
+	if (from >= to || to > nr_blocks)
+		return false;
 
-	if (start == end)
-		nr_pages = 1;
-	else
-		nr_pages = ffs_next_clean_subpage(ffs, folio,
-						 start + 1, end) - start;
+	if (!f2fs_folio_has_ffs(folio)) {
+		if (!folio_test_dirty(folio))
+			return false;
+		*start = from;
+		*count = to - from;
+		return true;
+	}
 
-	*range_start = folio_pos(folio) + ((u64)start << PAGE_SHIFT);
-	return (u64)nr_pages << PAGE_SHIFT;
+	ffs = folio->private;
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	*start = find_next_bit(ffs->state, nr_blocks + to, nr_blocks + from) - nr_blocks;
+	if (*start >= to) {
+		spin_unlock_irqrestore(&ffs->state_lock, flags);
+		return false;
+	}
+	*count = find_next_zero_bit(ffs->state, nr_blocks + to,
+				    nr_blocks + *start) - nr_blocks - *start;
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+	return true;
 }
 
 static bool find_next_valid_block(const struct folio *folio,
@@ -3307,13 +3330,9 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 		/*
 		 * Allocate the folio state before doing anything with the
 		 * folio, so that the block mapping helpers below can rely on
-		 * it, and fail early if memory is not available.
+		 * it.
 		 */
 		ffs = f2fs_ffs_find_or_alloc(folio);
-		if (!ffs) {
-			ret = -ENOMEM;
-			goto err_out;
-		}
 	}
 	index = folio->index;
 	offset = 0;
@@ -3393,7 +3412,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 			continue;
 		}
 
-		/* We must increment read_pages_pending before possible BIOs submitting
+		/* We must increment read_blocks_pending before possible BIOs submitting
 		 * to prevent from premature folio_end_read() call on folio
 		 */
 		if (folio_test_large(folio)) {
@@ -3847,7 +3866,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	__folio_start_writeback(folio, folio_test_dirty(folio));
 	if (f2fs_folio_has_ffs(folio)) {
 		ffs = (struct f2fs_folio_state *)folio->private;
-		atomic_inc(&ffs->write_pages_pending);
+		atomic_inc(&ffs->write_blocks_pending);
 		pending_added = true;
 	}
 
@@ -3927,7 +3946,7 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 
 		if (f2fs_folio_has_ffs(folio)) {
 			ffs = (struct f2fs_folio_state *)folio->private;
-			atomic_inc(&ffs->write_pages_pending);
+			atomic_inc(&ffs->write_blocks_pending);
 		}
 
 		set_new_dnode(&dn, dn_inode, NULL, NULL, 0);
@@ -4499,7 +4518,6 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 	struct f2fs_lock_context lc;
 	u64 pos = 0;
 	u64 end_pos = 0;
-	u32 r_len = 0;
 	int err = 0;
 	int submitted = 0;
 	int nwritten = 0;
@@ -4633,29 +4651,60 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 
 		folio_start_writeback(folio);
 
+		/*
+		 * PG_dirty was already cleared by writeback_iter(), and a
+		 * single-block folio has no ffs dirty bitmap, so the dirty
+		 * range cannot be derived. Write the whole folio.
+		 */
+		if (!folio_test_large(folio)) {
+			err = f2fs_write_folio_dirty_range(folio, &submitted,
+					wbc, io_type, &pos, end_pos - pos);
+			folio_submitted += submitted;
+			nwritten += submitted;
+			if (err)
+				goto out;
+			goto written;
+		}
+
+		if (!f2fs_folio_has_ffs(folio)) {
+			ffs = f2fs_ffs_find_or_alloc(folio);
+			f2fs_ffs_mark_subrange_dirty(folio, 0, end_pos - pos);
+		} else {
+			ffs = (struct f2fs_folio_state *)folio->private;
+		}
 		/*
 		 * Large folios can be submitted as multiple bios, which may
 		 * complete while we are still submitting the remaining dirty
-		 * ranges.  Hold a bias on write_pages_pending to prevent
+		 * ranges.  Hold a bias on write_blocks_pending to prevent
 		 * folio_end_writeback() from being called early.
 		 */
-		if (!bias_added && f2fs_folio_has_ffs(folio)) {
-			ffs = (struct f2fs_folio_state *)folio->private;
-			WARN_ON_ONCE(atomic_read(&ffs->write_pages_pending) != 0);
-			atomic_inc(&ffs->write_pages_pending);
+		if (!bias_added) {
+			WARN_ON_ONCE(atomic_read(&ffs->write_blocks_pending) != 0);
+			atomic_inc(&ffs->write_blocks_pending);
 			bias_added = true;
 		}
 
-		while ((r_len = ffs_find_dirty_range(folio, &pos, end_pos))) {
+		unsigned int from = 0, start, count;
+		unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
+		unsigned int to_blk = min_t(unsigned int,
+				F2FS_BLK_ALIGN(sbi, end_pos - folio_pos(folio)),
+				nr_blocks);
+
+		while (f2fs_ffs_dirty_blk_range(folio, from, to_blk,
+						&start, &count)) {
 			submitted = 0;
+			pos = folio_pos(folio) + F2FS_BLK_TO_BYTES(sbi, start);
 			err = f2fs_write_folio_dirty_range(folio, &submitted,
-					wbc, io_type, &pos, r_len);
+					wbc, io_type, &pos,
+					F2FS_BLK_TO_BYTES(sbi, count));
 			folio_submitted += submitted;
 			nwritten += submitted;
 			if (err)
 				goto out;
+			from = start + count;
 		}
 
+written:
 		/* If none of the subpages of a folio is submitted, keep the atomic flag */
 		if (folio_submitted &&
 		    f2fs_is_atomic_file(inode) &&
@@ -5141,7 +5190,6 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 					  unsigned int len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct f2fs_folio_state *ffs;
 	size_t ori_off = offset_in_folio(folio, pos);
 	size_t need_off = ori_off;
 	int err = 0;
@@ -5170,9 +5218,7 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 		}
 	}
 
-	ffs = f2fs_ffs_find_or_alloc(folio);
-	if (!ffs)
-		return -ENOMEM;
+	f2fs_ffs_find_or_alloc(folio);
 
 	/* Skip read if the folio is already fully uptodate or the write
 	 * covers the entire folio.
@@ -5248,8 +5294,7 @@ static int prepare_large_folio_atomic_write_begin(struct inode *inode,
 
 	len = min_t(unsigned int, len, folio_size(folio) - ori_off);
 
-	if (!f2fs_ffs_find_or_alloc(folio))
-		return -ENOMEM;
+	f2fs_ffs_find_or_alloc(folio);
 
 	/* Inline data must have been converted before reaching here. */
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
@@ -5533,31 +5578,37 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 
 	if (inode->i_ino >= F2FS_ROOT_INO(sbi) &&
 				(offset || length != folio_size(folio))) {
-		size_t clear_start = round_up(offset, PAGE_SIZE);
-		size_t clear_end = round_down(offset + length, PAGE_SIZE);
+		size_t clear_start = round_up(offset, F2FS_BLKSIZE(sbi));
+		size_t clear_end = round_down(offset + length, F2FS_BLKSIZE(sbi));
 		size_t clear_length;
 		bool dirty;
 
 		/*
 		 * If the truncated range falls within a single subpage, no
-		 * subpage state needs to be cleared.
+		 * subpage state needs to be cleared. The folio of an inline
+		 * inode has no subpage state; its uptodate flag tells that the
+		 * inline data was loaded, so it must not be cleared.
 		 */
-		if (clear_start >= clear_end || !f2fs_folio_has_ffs(folio))
+		if (clear_start >= clear_end ||
+		    !f2fs_is_multiblock_folio(sbi, folio) ||
+		    f2fs_has_inline_data(inode))
 			return;
 
 		clear_length = clear_end - clear_start;
 		dirty = f2fs_ffs_clear_subrange_dirty_and_test(folio,
 						clear_start, clear_length);
-		ffs_clear_subrange_uptodate(folio, clear_start, clear_length);
-		folio_clear_uptodate(folio);
+		f2fs_ffs_clear_subrange_uptodate(folio, clear_start,
+						 clear_length);
 
 		/*
 		 * If the truncated subrange happens to clear the remaining
 		 * dirty bitmap of the whole folio, cancel the folio-level
 		 * dirty state.
 		 */
-		if (!dirty && folio_test_dirty(folio))
+		if (!dirty && folio_test_dirty(folio)) {
+			f2fs_clear_page_cache_dirty_tag(folio);
 			folio_cancel_dirty(folio);
+		}
 		if (!dirty && !folio_test_writeback(folio))
 			folio_clear_f2fs_gcing(folio);
 		return;
@@ -5592,6 +5643,7 @@ static bool f2fs_dirty_data_folio(struct address_space *mapping,
 		struct folio *folio)
 {
 	struct inode *inode = mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
 	trace_f2fs_set_page_dirty(folio, DATA);
 
@@ -5599,13 +5651,13 @@ static bool f2fs_dirty_data_folio(struct address_space *mapping,
 		bool uptodate = true;
 
 		if (f2fs_folio_has_ffs(folio)) {
-			struct f2fs_folio_state *ffs =
-				(struct f2fs_folio_state *)folio->private;
+			struct f2fs_folio_state *ffs = folio->private;
+			unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
 			unsigned long flags;
 
 			spin_lock_irqsave(&ffs->state_lock, flags);
-			uptodate = bitmap_full(ffs->state, folio_nr_pages(folio)) &&
-				   !ffs->read_pages_pending;
+			uptodate = bitmap_full(ffs->state, nr_blocks) &&
+				   !ffs->read_blocks_pending;
 			spin_unlock_irqrestore(&ffs->state_lock, flags);
 		}
 		if (uptodate)
@@ -5957,6 +6009,8 @@ void f2fs_clear_page_cache_dirty_tag(struct folio *folio)
 	xa_lock_irqsave(&mapping->i_pages, flags);
 	__xa_clear_mark(&mapping->i_pages, folio->index,
 						PAGECACHE_TAG_DIRTY);
+	__xa_clear_mark(&mapping->i_pages, folio->index,
+						PAGECACHE_TAG_TOWRITE);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3f83d01489d4..249c962434b5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1630,13 +1630,17 @@ static inline void f2fs_clear_bit(unsigned int nr, char *addr);
  * folio->private is a wrapped pointer.
  */
 
+#define F2FS_FOLIO_STATE_MAGIC		0xF5F2FF50
+
 struct f2fs_folio_state {
+	u32			magic;
 	spinlock_t		state_lock;
-	unsigned int		read_pages_pending;
-	atomic_t		write_pages_pending;
+	unsigned int		read_blocks_pending;
+	atomic_t		write_blocks_pending;
 	unsigned long		private_flags;
-	/* state[0..nr_subpages - 1] tracks uptodate subpages.
-	 * state[nr_subpages..2 * nr_subpages - 1] tracks dirty subpages.
+	/*
+	 * state[0..nr_blocks - 1] tracks uptodate blocks.
+	 * state[nr_blocks..2 * nr_blocks - 1] tracks dirty blocks.
 	 */
 	unsigned long		state[];
 };
@@ -2337,6 +2341,12 @@ static inline bool f2fs_has_subpage_blocks(struct f2fs_sb_info *sbi)
 	return F2FS_BLKSIZE(sbi) < PAGE_SIZE;
 }
 
+static inline bool f2fs_is_multiblock_folio(struct f2fs_sb_info *sbi,
+					    const struct folio *folio)
+{
+	return folio_size(folio) > F2FS_BLKSIZE(sbi);
+}
+
 static inline pgoff_t f2fs_folio_lblk(struct f2fs_sb_info *sbi,
 				      const struct folio *folio)
 {
@@ -2483,18 +2493,9 @@ static inline bool f2fs_folio_has_ffs(const struct folio *folio)
 {
 	unsigned long private = (unsigned long)folio->private;
 
-	if (!folio_test_large(folio) || !private)
+	if (!private || (private & BIT(F2FS_FOLIO_PRIVATE_NOT_POINTER)))
 		return false;
-
-	/*
-	 * A large folio should always carry f2fs_folio_state rather than
-	 * non-pointer private flags at its folio->private.
-	 */
-	if (unlikely(test_bit(F2FS_FOLIO_PRIVATE_NOT_POINTER, &private))) {
-		f2fs_bug_on(F2FS_F_SB(folio), 1);
-		return false;
-	}
-	return true;
+	return *((u32 *)private) == F2FS_FOLIO_STATE_MAGIC;
 }
 
 static inline void clear_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
@@ -4529,6 +4530,10 @@ void f2fs_ffs_mark_subrange_dirty(struct folio *folio, size_t offset, size_t len
 bool f2fs_ffs_has_dirty_subpage(struct folio *folio);
 bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 					    size_t len);
+void f2fs_ffs_clear_subrange_uptodate(struct folio *folio, size_t offset,
+				      size_t len);
+bool f2fs_ffs_dirty_blk_range(struct folio *folio, unsigned int from,
+			      unsigned int to, unsigned int *start, unsigned int *count);
 void f2fs_write_failed(struct inode *inode, loff_t to);
 void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 bool f2fs_release_folio(struct folio *folio, gfp_t wait);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5a6f0ff9f377..28fccc735a39 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -238,12 +238,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto out_sem;
 	}
 
-	if (folio_test_large(folio) && !f2fs_ffs_find_or_alloc(folio)) {
-		folio_unlock(folio);
-		err = -ENOMEM;
-		goto out_sem;
-	}
-
 	nr = DIV_ROUND_UP(dirty_len, PAGE_SIZE);
 
 	for (i = 0; i < nr; i++) {
@@ -1628,12 +1622,6 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			memcpy_folio(fdst, dst_off, fsrc, src_off,
 				    F2FS_BLKSIZE(sbi));
 			if (folio_test_large(fdst)) {
-				if (!f2fs_ffs_find_or_alloc(fdst)) {
-					f2fs_folio_put(fdst, true);
-					if (!same_folio)
-						f2fs_folio_put(fsrc, true);
-					return -ENOMEM;
-				}
 				f2fs_ffs_mark_subrange_uptodate(fdst,
 						dst_off, F2FS_BLKSIZE(sbi));
 				f2fs_ffs_mark_subrange_dirty(fdst, dst_off,
@@ -4975,16 +4963,12 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 			 * bitmap as well, otherwise f2fs_write_cache_folios()
 			 * finds no dirty range and skips the whole folio.
 			 */
-			if (!f2fs_ffs_find_or_alloc(folio)) {
-				ret = -ENOMEM;
-				goto next;
-			}
+			f2fs_ffs_find_or_alloc(folio);
 			f2fs_ffs_mark_subrange_dirty(folio, off, dlen);
 		}
 
 		folio_mark_dirty(folio);
 		folio_set_f2fs_gcing(folio);
-next:
 		redirty_idx = folio_next_index(folio);
 		folio_unlock(folio);
 		folio_put_refs(folio, 2);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2b0821c2c18b..93f165151c0f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4193,7 +4193,7 @@ static void do_write_block(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 				fio->old_blkaddr, fio->new_blkaddr, err);
 			/*
 			 * For a large folio, the caller rolls back
-			 * write_pages_pending and ends writeback when the last
+			 * write_blocks_pending and ends writeback when the last
 			 * pending write is gone.
 			 */
 			if (!f2fs_folio_has_ffs(folio))
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
