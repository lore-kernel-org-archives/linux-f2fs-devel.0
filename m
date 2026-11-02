Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C348606D81A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Tz60fP1s;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S8h5SWea;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h40aaUSk;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WIIIG0TO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=VryXsA+Pn7wGATX4uolOzh+gIvT6Os2LXSWSTuGK6dw=; b=Tz60fP1sRo5+k06syY6FAxzqFF
	xFPf15rteFr1bPd/E7td4eGT1xQknvXzlZpeVooavFKm1r+HQUrQ+QJxo8r+4DWhW2SdoxH+By/Af
	HhtK361XCNyL+WH4eQLNmUMqFCPGSid9LZuPBTD5ccX8pFJECAhoWIS2ZKsGB4eIvlME=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxtO-000000004gj-0EwM;
	Mon, 02 Nov 2026 19:40:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxtL-000000004gS-3IRH
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4q46MUoyhUT+7icoVix//HewwS+9pY+CVjWWjsML6/k=; b=S8h5SWeaSkL6RAzlA++SK7Y4v7
 tFrBwYl+a12x0kiMubyrALaupNmZ18GLIFLNRp8SfgkW/vv3nmU8024qAMNaKtny8vn6A9DgEHHU7
 pisPMg1An65UVlVslbyLajGKaq+kVkPpF6KbH5rzxT9j1ZqardRksU5k7njneUq7yo7c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4q46MUoyhUT+7icoVix//HewwS+9pY+CVjWWjsML6/k=; b=h40aaUSkAAH9jcFDeZaMRA8DjC
 6pJAv0ryb89kibHSs9CzxyUgQFZsTWyRIGOGkSdK0Vx2SVQmk6fpmCW6xHDYcQOBkMiMnL0fivqWR
 H676SKIok7XxCyB2NKallKTZT9znthQr3PtxP9HgetIOkJQnBy6X3gHqAMbOuIDxMr+M=;
Received: from mail-pf1-f173.google.com ([209.85.210.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxtI-000000002DF-1La8
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:27 +0000
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-8a070b3f44aso1122736b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648419; x=1794253219; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4q46MUoyhUT+7icoVix//HewwS+9pY+CVjWWjsML6/k=;
 b=WIIIG0TObKVhbfWVan6TZGH5kXXzuF7cN2RKtbRa3/17ZjvhIuiH/fJAxJ37DhgsQB
 rYbRvqm1/Cb4g49p5Qgh03iKGBhSDEnrBRnDr+LE37dFCtqDikh75mMmPuJG/1oirQuZ
 TKbxf2uqI59rtrPJUfzlyoBoMyHol1Kvt7J6+3pTGc78JqhZCzOLIdE7LsPmzKXj5AEh
 7rpWFLk7FSGuo7fqgfyN6MF5OzAZmnE2otALJLG9HulfdC05MXbfTiCDCZblebpU9vLn
 9G7xjgXT9IligdejgNKp4xOMvrkOWFMdXolAJUtyx77UEgGoQpM6G+RAHdwZS5S4YwVM
 Tl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648419; x=1794253219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4q46MUoyhUT+7icoVix//HewwS+9pY+CVjWWjsML6/k=;
 b=pXAbk9QfJt60e43b0pfMzzjsZxlI8Ax23f74DmzuO1rV6e78lM0dSx9PhyUHr8VCVb
 M+MEGv+lvsWeO/4wU+jQPMVZ9ewB9N8FyMCoBMuJNE/SGQPU4UAVZtJwqFESclXa0SrG
 ENYCR/l8HPXkAE3SrzkJfBPOgK2lj7nexvf1bZs8G/5Jwv+Ca4DdQim86qqq0JqRw7os
 E2iEA5QGrYCmaEZr4mEoHnFExY8Elfz6USPioTmftjvQpMu714FCpK+PeNWORIwBbkoI
 zr0EMex7M7MPT+A4VgiH2X/r7V1c7wHV7mHEElBU3FuWCsZVZiAddjFJhkEPeFDASTj/
 lQPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoj/Vr3K+g0I/MiYplZGhcDGCfnEQwYjKrcoyfrcI3WTRa7MP3LFUaSdH34k0sk3UOZ/Dbc6rSAu9F0Wuuo+kW@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIZIqAj+3bl9OGFFUfkvzzZgLAv0YZGxZBCjxeI9WGF9AEdpoLD
 DYe0EGDlGGWTs4WE0Bv5zZ6eKp8Gaqcvblaz66nZWq/ojM9BOGaT9EXs
X-Gm-Gg: AYBFou2785ARe1FVjPhkQ8rr3J+8FQ2I/rdhvi9Omw9Ags1P4l4RWtRy03FJSen172G
 sjmtLbihEUyEfH7GTdJ7z8rnz2hiVpVENvmPNvd5EZoawW1U690ONrDmrkZ4r4VPgzYyIYCNtg+
 QMQTL5cx5YJH91H5SvXQojo7CNBu+gnWXMmavxlDIcMkGXm+YSj04IIGsClmBFoNRL6fTymNeLp
 Q9Yp+lGO8A8nJQnNlY48sA+sLnD5VP7IJA87Bn/mLekrlyjy3w3kAPd7O90WVavNTX5bPskjzEL
 UKDpgVsKi6MvDwPVj/HF4S+MJEhchWT05gCzQKSO5v++utry+gOAor3DDmS0GbLd2obzNBcX0qb
 mdSh41XOk5Xa6S2SJFtRe0YjWGs9FpfK9Zb75O9TqLOTrp/IwPN1y87iD8OeotGJ+ZjhQ+7Iru4
 OYItDz12Hh/vEWt1klfiUimTy0OJbDIuCLcpceYeecH2LaSarleEkz1nnqIsZosisRHqRJv208n
 lPZxoHsaTCdkYXiT22s9lx6Uq+4NBe8OFmBxgPRd06M2hBRMJS3QXT9KlbFEmB+HqYrL3E8K24/
 7uHrhdLMbRGKcLInxk8O3Q/A6olcN7l4py8rvwyIzp9SzTprcwiYe9kfB2A8L/3f1LF/NQIgn3X
 bFwAZTshoITtMOP4C8yA+wyZKMZ/Ag2Heaz02S/g3vX/gAA==
X-Received: by 2002:a05:6a20:b096:b0:3e2:9dee:42cd with SMTP id
 adf61e73a8af0-3e928d22422mr8498697637.36.1793648418114; 
 Mon, 02 Nov 2026 11:40:18 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:17 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:39 -0800
Message-ID: <20261102193952.3002018-8-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261102193952.3002018-1-daeho43@gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxtI-000000002DF-1La8
Subject: [f2fs-dev] [PATCH 07/20] f2fs: support subpage blocks in data write
 path and writeback
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

With blocks smaller than PAGE_SIZE, a folio holds several blocks, so
write_begin, write_end and writeback have to handle individual blocks
instead of the whole folio.

- Read, zero and reserve the blocks touched by a write per block in
  write_begin, and mark only the written blocks dirty in write_end.
- Write back only the dirty blocks of a multi-block folio and complete
  write I/O per block. In subpage mode every inode is written back by
  f2fs_write_cache_folios(), which now handles dentry and quota folios
  and checkpoint errors as f2fs_write_single_data_page() does. Both use
  the new f2fs_cp_controlled_inode() and f2fs_wb_folio_action() helpers
  for these rules.
  It also resets the error for each folio, so that the remaining folios
  are still written back after an error, as writeback_iter() expects
  for integrity writeback, instead of redirtying them.
  f2fs_write_folio_dirty_range() cleans up each block where it is
  written or skipped, and advances last_disk_size only up to the last
  block it submitted. On an error, it clears the dirty state of the
  blocks before the failed one, so that only the failed block and the
  ones after it are written again.
- Count inode dirty blocks per folio: add all blocks of a folio when
  it is dirtied and remove them when it is cleaned, instead of counting
  the dirty bits of the folio state. A multi-block folio can be dirtied
  without a folio state, e.g. after a read of the whole folio or
  through folio_mark_dirty(), and a state attached later starts with
  dirty bits that were never counted, so the bit count cannot stay
  balanced. A partially dirty folio is counted as fully dirty.
- Compressed and atomic files are not supported yet in subpage mode:
  write_begin returns -EOPNOTSUPP for them. Inline data is converted
  first.

Some of these changes also apply to large folios when the block size
equals PAGE_SIZE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/checkpoint.c |  39 +---
 fs/f2fs/data.c       | 486 ++++++++++++++++++++++---------------------
 fs/f2fs/dir.c        |   2 +-
 fs/f2fs/f2fs.h       |   1 -
 fs/f2fs/file.c       |  11 +-
 fs/f2fs/gc.c         |  11 +-
 fs/f2fs/inline.c     |   7 +-
 fs/f2fs/node.c       |   2 +-
 8 files changed, 275 insertions(+), 284 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1060ee651756..a9a2b9d93231 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1324,46 +1324,21 @@ static void __remove_dirty_inode(struct inode *inode, enum inode_type type)
 	stat_dec_dirty_inode(F2FS_I_SB(inode), type);
 }
 
-/*
- * Account @nr dirty blocks (negative when dirtiness is cleared) for @inode.
- */
-void f2fs_account_dirty_blocks(struct inode *inode, int nr)
+void f2fs_update_dirty_folio(struct inode *inode, struct folio *folio)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	enum inode_type type = S_ISDIR(inode->i_mode) ? DIR_INODE : FILE_INODE;
+	unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
 
-	if (!nr)
-		return;
-
-	spin_lock(&sbi->inode_lock[type]);
-	if (nr > 0) {
-		if (type != FILE_INODE || test_opt(sbi, DATA_FLUSH))
-			__add_dirty_inode(inode, type);
-		inode_add_dirty_blocks(inode, nr);
-	} else {
-		inode_sub_dirty_blocks(inode, -nr);
-		__remove_dirty_inode(inode, type);
-	}
-	spin_unlock(&sbi->inode_lock[type]);
-}
-
-void f2fs_update_dirty_folio(struct inode *inode, struct folio *folio)
-{
 	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
 			!S_ISLNK(inode->i_mode))
 		return;
 
-	/*
-	 * Large folios have a subpage dirty bitmap, so defer their dirty accounting
-	 * to the f2fs_ffs_*subrange_dirty*() helpers.  This avoids nesting
-	 * ffs->state_lock with the inode dirty list lock.
-	 */
-	if (f2fs_folio_has_ffs(folio)) {
-		folio_set_f2fs_reference(folio);
-		return;
-	}
-
-	f2fs_account_dirty_blocks(inode, 1);
+	spin_lock(&sbi->inode_lock[type]);
+	if (type != FILE_INODE || test_opt(sbi, DATA_FLUSH))
+		__add_dirty_inode(inode, type);
+	inode_add_dirty_blocks(inode, nr_blocks);
+	spin_unlock(&sbi->inode_lock[type]);
 
 	folio_set_f2fs_reference(folio);
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 07b7aeb94350..41246f83b31d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -420,8 +420,7 @@ static void f2fs_write_end_bio(struct bio *bio)
 
 	bio_for_each_folio_all(fi, bio) {
 		struct folio *folio = fi.folio;
-		unsigned int nr_pages = fi.length >> PAGE_SHIFT;
-		unsigned int npages = nr_pages;
+		unsigned int nr_blocks = fi.length >> sbi->log_blocksize;
 		enum count_type type;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -441,8 +440,7 @@ static void f2fs_write_end_bio(struct bio *bio)
 			}
 		}
 
-		while (nr_pages--)
-			dec_cache_count(sbi, type);
+		sub_cache_counts(sbi, type, nr_blocks);
 
 		/*
 		 * we should access sbi before folio_end_writeback() to
@@ -452,7 +450,7 @@ static void f2fs_write_end_bio(struct bio *bio)
 				wq_has_sleeper(&sbi->cp_wait))
 			wake_up(&sbi->cp_wait);
 
-		f2fs_ffs_put_write_pending(folio, npages);
+		f2fs_ffs_put_write_pending(folio, nr_blocks);
 	}
 
 	bio_put(bio);
@@ -3023,7 +3021,7 @@ static void f2fs_clear_truncated_page_state(struct folio *folio, pgoff_t i)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 
-	if (f2fs_folio_has_ffs(folio)) {
+	if (f2fs_is_multiblock_folio(sbi, folio)) {
 		f2fs_ffs_clear_subrange_uptodate(folio,
 				F2FS_BLK_TO_BYTES(sbi, i), F2FS_BLKSIZE(sbi));
 	} else {
@@ -3051,21 +3049,6 @@ bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index)
 	return test_bit(nr_blocks + offset, ffs->state);
 }
 
-static unsigned int __ffs_mark_subrange_dirty(struct folio *folio,
-			struct f2fs_folio_state *ffs, size_t offset, size_t len)
-{
-	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
-	unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
-	unsigned int start, end, before;
-
-	start = F2FS_BYTES_TO_BLK(sbi, offset);
-	end = min_t(unsigned int, F2FS_BLK_ALIGN(sbi, offset + len), nr_blocks);
-
-	before = bitmap_weight(ffs->state, 2 * nr_blocks);
-	bitmap_set(ffs->state, nr_blocks + start, end - start);
-	return bitmap_weight(ffs->state, 2 * nr_blocks) - before;
-}
-
 /*
  * Mark the given range dirty for writeback.
  *
@@ -3078,7 +3061,8 @@ void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 	struct f2fs_folio_state *ffs;
-	unsigned int set;
+	unsigned int nr_blocks;
+	unsigned int start, end;
 	unsigned long flags;
 
 	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
@@ -3087,13 +3071,13 @@ void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
 		return;
 
 	ffs = f2fs_ffs_find_or_alloc(folio);
+	nr_blocks = f2fs_blocks_per_folio(sbi, folio);
+	start = F2FS_BYTES_TO_BLK(sbi, offset);
+	end = min_t(unsigned int, F2FS_BLK_ALIGN(sbi, offset + len), nr_blocks);
 
 	spin_lock_irqsave(&ffs->state_lock, flags);
-	set = __ffs_mark_subrange_dirty(folio, ffs, offset, len);
+	bitmap_set(ffs->state, start + nr_blocks, end - start);
 	spin_unlock_irqrestore(&ffs->state_lock, flags);
-
-	if (set)
-		f2fs_account_dirty_blocks(folio->mapping->host, set);
 }
 
 void f2fs_ffs_clear_subrange_uptodate(struct folio *folio,
@@ -3129,19 +3113,16 @@ void f2fs_ffs_clear_subrange_uptodate(struct folio *folio,
 }
 
 static bool __ffs_clear_subrange_dirty(struct folio *folio,
-			struct f2fs_folio_state *ffs, size_t offset, size_t len,
-			unsigned int *cleared)
+			struct f2fs_folio_state *ffs, size_t offset, size_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 	unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
-	unsigned int start, end, before;
+	unsigned int start, end;
 
 	start = F2FS_BYTES_TO_BLK(sbi, offset);
 	end = min_t(unsigned int, F2FS_BLK_ALIGN(sbi, offset + len), nr_blocks);
 
-	before = bitmap_weight(ffs->state, 2 * nr_blocks);
 	bitmap_clear(ffs->state, nr_blocks + start, end - start);
-	*cleared = before - bitmap_weight(ffs->state, 2 * nr_blocks);
 	return find_next_bit(ffs->state, 2 * nr_blocks, nr_blocks) <
 			2 * nr_blocks;
 }
@@ -3153,15 +3134,13 @@ static bool __ffs_clear_subrange_dirty(struct folio *folio,
  * @len: byte length of the subrange
  *
  * Clear the dirty bits of the 4K subpages covered by [offset, offset + len),
- * account the cleared subpages against the inode dirty counters, and return
- * whether the folio still has any dirty subpage left.
+ * and return whether the folio still has any dirty subpage left.
  */
 bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 					    size_t len)
 {
 	struct f2fs_folio_state *ffs;
 	unsigned long flags;
-	unsigned int cleared = 0;
 	bool dirty;
 
 	if (!f2fs_folio_has_ffs(folio)) {
@@ -3178,12 +3157,9 @@ bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 
 	ffs = f2fs_ffs_find_or_alloc(folio);
 	spin_lock_irqsave(&ffs->state_lock, flags);
-	dirty = __ffs_clear_subrange_dirty(folio, ffs, offset, len, &cleared);
+	dirty = __ffs_clear_subrange_dirty(folio, ffs, offset, len);
 	spin_unlock_irqrestore(&ffs->state_lock, flags);
 
-	if (cleared)
-		f2fs_account_dirty_blocks(folio->mapping->host, -cleared);
-
 	return dirty;
 }
 
@@ -3943,7 +3919,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 					struct writeback_control *wbc,
 					enum iostat_type io_type,
-					u64 *pos, u64 len)
+					u64 start, u64 end)
 {
 	struct inode *inode = folio->mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -3951,19 +3927,19 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 				folio_test_f2fs_atomic(folio);
 	struct inode *dn_inode = atomic_commit ?
 				F2FS_I(inode)->cow_inode : inode;
-	struct f2fs_folio_state *ffs = NULL;
-	u64 folio_start = folio_pos(folio);
-	pgoff_t start_idx = (*pos - folio_start) >> PAGE_SHIFT;
-	pgoff_t end_idx = (*pos - folio_start + len - 1) >> PAGE_SHIFT;
+	u64 pos = folio_pos(folio);
+	pgoff_t start_idx = (start - pos) >> sbi->log_blocksize;
+	pgoff_t end_idx = (end - 1 - pos) >> sbi->log_blocksize;
+	pgoff_t last_idx = 0;
+	pgoff_t i;
+	int local_submitted = 0;
 	int err = 0;
 
-	for (pgoff_t i = start_idx; i <= end_idx && !err; i++) {
+	for (i = start_idx; i <= end_idx; i++) {
 		struct dnode_of_data dn;
 		struct node_info ni;
-		pgoff_t data_idx = folio->index + i;
+		pgoff_t data_idx = f2fs_folio_lblk(sbi, folio) + i;
 		bool ipu_force = false;
-		bool dn_held = false;
-		bool submitted_blk = false;
 		struct f2fs_io_info fio = {
 			.sbi = sbi,
 			.ino = inode->i_ino,
@@ -3983,7 +3959,12 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 		};
 
 		if (f2fs_folio_has_ffs(folio)) {
-			ffs = (struct f2fs_folio_state *)folio->private;
+			struct f2fs_folio_state *ffs =
+				(struct f2fs_folio_state *)folio->private;
+
+			/* Write only dirty blocks */
+			if (!f2fs_ffs_test_blk_dirty(folio, data_idx))
+				continue;
 			atomic_inc(&ffs->write_blocks_pending);
 		}
 
@@ -3995,7 +3976,7 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 			if (!f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
 						   DATA_GENERIC_ENHANCE)) {
 				err = -EFSCORRUPTED;
-				goto block_done;
+				goto skip_block;
 			}
 			ipu_force = true;
 			goto got_it;
@@ -4015,24 +3996,22 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 						     LOOKUP_NODE);
 		}
 		if (err && err != -ENOENT)
-			goto block_done;
-		dn_held = true;
+			goto skip_block;
 
-		fio.old_blkaddr = dn.data_blkaddr;
-
-		/* This page is already truncated */
-		if (err == -ENOENT || fio.old_blkaddr == NULL_ADDR) {
-			f2fs_clear_truncated_page_state(folio, i);
+		/* This block is already truncated */
+		if (err || dn.data_blkaddr == NULL_ADDR) {
 			err = 0;
-			goto block_done;
+			f2fs_clear_truncated_page_state(folio, i);
+			goto skip_block;
 		}
 
+		fio.old_blkaddr = dn.data_blkaddr;
 got_it:
 		if (__is_valid_data_blkaddr(fio.old_blkaddr) &&
 		    !f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
 					   DATA_GENERIC_ENHANCE)) {
 			err = -EFSCORRUPTED;
-			goto block_done;
+			goto skip_block;
 		}
 
 		if (fio.meta_gc)
@@ -4042,61 +4021,109 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 		    (__is_valid_data_blkaddr(fio.old_blkaddr) &&
 					    need_inplace_update(&fio))) {
 			f2fs_put_dnode(&dn);
-			dn_held = false;
 			err = f2fs_inplace_write_data(&fio);
-			trace_f2fs_do_write_data_page(folio, IPU);
 			if (err)
-				goto block_done;
+				goto skip_block_no_dnode;
 
-			if (submitted)
-				(*submitted)++;
-			submitted_blk = true;
+			local_submitted++;
+			last_idx = data_idx;
 			set_inode_flag(inode, FI_UPDATE_WRITE);
-			goto block_done;
+			trace_f2fs_do_write_data_page(folio, IPU);
+			continue;
 		}
 
 		err = f2fs_get_node_info(sbi, dn.nid, &ni, false);
 		if (err)
-			goto block_done;
+			goto skip_block;
 
 		fio.version = ni.version;
 
 		f2fs_outplace_write_data(&dn, &fio);
-		/*
-		 * The outplace write path failed to submit this block.
-		 */
+		f2fs_put_dnode(&dn);
+		/* The outplace write path failed to submit this block. */
 		if (!fio.submitted) {
 			err = -EIO;
-			goto block_done;
+			goto skip_block_no_dnode;
 		}
-		if (submitted)
-			(*submitted)++;
-		submitted_blk = true;
+		local_submitted++;
+		last_idx = data_idx;
 		set_inode_flag(inode, FI_APPEND_WRITE);
 		trace_f2fs_do_write_data_page(folio, OPU);
-block_done:
-		if (dn_held)
-			f2fs_put_dnode(&dn);
+		continue;
+
+skip_block:
+		f2fs_put_dnode(&dn);
+skip_block_no_dnode:
+		if (f2fs_folio_has_ffs(folio))
+			f2fs_ffs_put_write_pending(folio, 1);
+		if (err)
+			break;
+	}
+
+	if (err) {
 		/*
-		 * If this block was not submitted, roll back its
-		 * write pages pending.
+		 * The blocks before the failed one were written or skipped, so
+		 * keep only the failed block and the ones after it dirty.
 		 */
-		if (!submitted_blk && ffs)
-			f2fs_ffs_put_write_pending(folio, 1);
-		if (!err) {
-			*pos = ((loff_t)data_idx + 1) << PAGE_SHIFT;
-			spin_lock(&F2FS_I(inode)->i_size_lock);
-			if (F2FS_I(inode)->last_disk_size < *pos)
-				F2FS_I(inode)->last_disk_size = *pos;
-			spin_unlock(&F2FS_I(inode)->i_size_lock);
-		} else {
-			file_set_keep_isize(inode);
+		if (i > start_idx) {
+			size_t len = F2FS_BLK_TO_BYTES(sbi, i - start_idx);
+
+			f2fs_ffs_clear_subrange_dirty_and_test(folio,
+							       start - pos, len);
 		}
+		file_set_keep_isize(inode);
+	} else if (local_submitted) {
+		loff_t psize = (loff_t)(last_idx + 1) << sbi->log_blocksize;
+
+		if (psize > i_size_read(inode))
+			psize = i_size_read(inode);
+
+		spin_lock(&F2FS_I(inode)->i_size_lock);
+		if (F2FS_I(inode)->last_disk_size < psize)
+			F2FS_I(inode)->last_disk_size = psize;
+		spin_unlock(&F2FS_I(inode)->i_size_lock);
 	}
 
+	if (submitted)
+		*submitted = local_submitted;
 	return err;
 }
 
+/* Dentry and quota blocks are controlled by checkpoint. */
+static bool f2fs_cp_controlled_inode(struct inode *inode)
+{
+	return S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode);
+}
+
+enum f2fs_wb_action {
+	F2FS_WB_WRITE,		/* write back the folio */
+	F2FS_WB_REDIRTY,	/* keep the folio dirty */
+	F2FS_WB_DROP,		/* drop the dirty data */
+};
+
+/* Decide what to do with a dirty data folio before writing it back. */
+static enum f2fs_wb_action f2fs_wb_folio_action(struct f2fs_sb_info *sbi,
+						struct inode *inode)
+{
+	/* we should bypass data pages to proceed the kworker jobs */
+	if (unlikely(f2fs_cp_error(sbi))) {
+		mapping_set_error(inode->i_mapping, -EIO);
+		/*
+		 * Keep dirty dentry folios for the latest directory structure,
+		 * and keep data folios in remount-ro mode.
+		 */
+		if ((S_ISDIR(inode->i_mode) &&
+		     !is_sbi_flag_set(sbi, SBI_IS_CLOSE)) ||
+		    F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY)
+			return F2FS_WB_REDIRTY;
+		return F2FS_WB_DROP;
+	}
+
+	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
+		return F2FS_WB_REDIRTY;
+	return F2FS_WB_WRITE;
+}
+
 int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				struct bio **bio,
 				sector_t *last_block,
@@ -4137,26 +4164,15 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 
 	trace_f2fs_writepage(folio, DATA);
 
-	/* we should bypass data pages to proceed the kworker jobs */
-	if (unlikely(f2fs_cp_error(sbi))) {
-		mapping_set_error(folio->mapping, -EIO);
-		/*
-		 * don't drop any dirty dentry pages for keeping lastest
-		 * directory structure.
-		 */
-		if (S_ISDIR(inode->i_mode) &&
-				!is_sbi_flag_set(sbi, SBI_IS_CLOSE))
-			goto redirty_out;
-
-		/* keep data pages in remount-ro mode */
-		if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY)
-			goto redirty_out;
+	switch (f2fs_wb_folio_action(sbi, inode)) {
+	case F2FS_WB_REDIRTY:
+		goto redirty_out;
+	case F2FS_WB_DROP:
 		goto out;
+	case F2FS_WB_WRITE:
+		break;
 	}
 
-	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
-		goto redirty_out;
-
 	if (folio->index < end_index ||
 			f2fs_verity_in_progress(inode) ||
 			compr_blocks)
@@ -4172,8 +4188,7 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 
 	folio_zero_segment(folio, offset, folio_size(folio));
 write:
-	/* Dentry/quota blocks are controlled by checkpoint */
-	if (S_ISDIR(inode->i_mode) || quota_inode) {
+	if (f2fs_cp_controlled_inode(inode)) {
 		struct f2fs_lock_context lc;
 
 		/*
@@ -4224,14 +4239,14 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 		goto redirty_out;
 
 out:
-	inode_dec_dirty_block(inode);
+	inode_sub_dirty_blocks(inode, f2fs_blocks_per_folio(sbi, folio));
 	if (err) {
 		folio_clear_uptodate(folio);
 		folio_clear_f2fs_gcing(folio);
 	}
 	folio_unlock(folio);
-	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode) &&
-			!F2FS_I(inode)->wb_task && allow_balance)
+	if (!f2fs_cp_controlled_inode(inode) &&
+	    !F2FS_I(inode)->wb_task && allow_balance)
 		f2fs_balance_fs(sbi, need_balance_fs);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
@@ -4560,6 +4575,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 	int submitted = 0;
 	int nwritten = 0;
 	bool op_locked = false;
+	bool node_locked = false;
 	bool retry = false;
 
 	if (get_dirty_blocks(inode) <= SM_I(sbi)->min_hot_blocks)
@@ -4571,20 +4587,15 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		struct f2fs_folio_state *ffs = NULL;
 		u64 isize;
 		size_t poff;
-		size_t clear_len;
 		pgoff_t end_index;
 		bool verity_in_progress;
 		int folio_submitted = 0;
 		bool bias_added = false;
 
 		submitted = 0;
+		err = 0;
 		retry = false;
 
-		if (err) {
-			folio_redirty_for_writepage(wbc, folio);
-			goto retry_out;
-		}
-
 		if (atomic_read(&sbi->wb_sync_req[DATA]) &&
 		    wbc->sync_mode == WB_SYNC_NONE) {
 			folio_redirty_for_writepage(wbc, folio);
@@ -4597,11 +4608,22 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 			goto retry_out;
 		}
 
+		if (f2fs_has_subpage_blocks(sbi) &&
+		    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode))) {
+			WARN_ON_ONCE(1);
+			mapping_set_error(mapping, -EOPNOTSUPP);
+			folio_clear_dirty_for_io(folio);
+			inode_sub_dirty_blocks(inode, f2fs_blocks_per_folio(sbi, folio));
+			err = -EOPNOTSUPP;
+			goto retry_out;
+		}
+
 		/*
 		 * Writing back one large folio performs multiple block allocations, so
 		 * best-effort balance the filesystem before writing it back.
 		 */
-		if (!F2FS_I(inode)->wb_task && has_not_enough_free_secs(sbi, 0, 0)) {
+		if (!f2fs_cp_controlled_inode(inode) &&
+		    !F2FS_I(inode)->wb_task && has_not_enough_free_secs(sbi, 0, 0)) {
 			folio_redirty_for_writepage(wbc, folio);
 			retry = true;
 			folio_unlock(folio);
@@ -4636,31 +4658,39 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		}
 
 		/*
-		 * If cp_error is set, all subpages of this folio are not
-		 * written back unless the filesystem is mounted with
-		 * errors=remount-ro.  The check is placed after the retry
-		 * block so it also covers cp_error being set while the folio
-		 * lock was dropped for f2fs_balance_fs() or for the trylock_op()
-		 * backoff.  PG_dirty is clear at this point, so both the
-		 * redirty and the drop below leave a coherent state.
+		 * Checked after the retry block, so that it also covers cp_error
+		 * being set while the folio lock was dropped for f2fs_balance_fs()
+		 * or for the trylock_op() backoff.
 		 */
-		if (unlikely(f2fs_cp_error(sbi))) {
-			mapping_set_error(mapping, -EIO);
-			if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY) {
-				folio_redirty_for_writepage(wbc, folio);
-				goto retry_out;
-			}
-			goto out;
+		switch (f2fs_wb_folio_action(sbi, inode)) {
+		case F2FS_WB_REDIRTY:
+			folio_redirty_for_writepage(wbc, folio);
+			goto retry_out;
+		case F2FS_WB_DROP:
+			f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
+						folio_size(folio));
+			inode_sub_dirty_blocks(inode, f2fs_blocks_per_folio(sbi, folio));
+			goto retry_out;
+		case F2FS_WB_WRITE:
+			break;
 		}
 
-		/* To avoid dealing with the complexity for one subrange is in bio
-		 * while we trylock_op failed before writing another subrange.
-		 * Try to lock_op before any subrange write for the folio.
-		 */
-		if (!op_locked) {
+		if (f2fs_cp_controlled_inode(inode)) {
+			/*
+			 * Quota writes need node_write to avoid block
+			 * allocation during checkpoint.
+			 */
+			if (IS_NOQUOTA(inode)) {
+				f2fs_down_read_trace(&sbi->node_write, &lc);
+				node_locked = true;
+			}
+		} else {
+			/* To avoid dealing with the complexity for one subrange is in bio
+			 * while we trylock_op failed before writing another subrange.
+			 * Try to lock_op before any subrange write for the folio.
+			 */
 			if (!f2fs_trylock_op(sbi, &lc)) {
 				folio_redirty_for_writepage(wbc, folio);
-				err = 0;
 				if (wbc->sync_mode != WB_SYNC_ALL)
 					goto retry_out;
 
@@ -4690,59 +4720,34 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		folio_start_writeback(folio);
 
 		/*
-		 * PG_dirty was already cleared by writeback_iter(), and a
-		 * single-block folio has no ffs dirty bitmap, so the dirty
-		 * range cannot be derived. Write the whole folio.
+		 * PG_dirty was already cleared by writeback_iter(). A single-block
+		 * folio has no ffs, so its whole folio is written.
 		 */
-		if (!folio_test_large(folio)) {
-			err = f2fs_write_folio_dirty_range(folio, &submitted,
-					wbc, io_type, &pos, end_pos - pos);
-			folio_submitted += submitted;
-			if (err)
-				goto out;
-			nwritten += submitted;
-			goto written;
-		}
-
-		if (!f2fs_folio_has_ffs(folio)) {
-			ffs = f2fs_ffs_find_or_alloc(folio);
-			f2fs_ffs_mark_subrange_dirty(folio, 0, end_pos - pos);
-		} else {
+		if (f2fs_is_multiblock_folio(sbi, folio)) {
+			if (!f2fs_folio_has_ffs(folio))
+				f2fs_ffs_mark_subrange_dirty(folio, 0, end_pos - pos);
 			ffs = (struct f2fs_folio_state *)folio->private;
+			/*
+			 * Multiblock folios can be submitted as multiple bios,
+			 * which may complete while we are still submitting the
+			 * remaining dirty ranges.  Hold a bias on
+			 * write_blocks_pending to prevent folio_end_writeback()
+			 * from being called early.
+			 */
+			if (!bias_added) {
+				WARN_ON_ONCE(atomic_read(&ffs->write_blocks_pending) != 0);
+				atomic_inc(&ffs->write_blocks_pending);
+				bias_added = true;
+			}
 		}
-		/*
-		 * Large folios can be submitted as multiple bios, which may
-		 * complete while we are still submitting the remaining dirty
-		 * ranges.  Hold a bias on write_blocks_pending to prevent
-		 * folio_end_writeback() from being called early.
-		 */
-		if (f2fs_folio_has_ffs(folio) && !bias_added) {
-			WARN_ON_ONCE(atomic_read(&ffs->write_blocks_pending) != 0);
-			atomic_inc(&ffs->write_blocks_pending);
-			bias_added = true;
-		}
-
-		unsigned int from = 0, start, count;
-		unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
-		unsigned int to_blk = min_t(unsigned int,
-				F2FS_BLK_ALIGN(sbi, end_pos - folio_pos(folio)),
-				nr_blocks);
 
-		while (f2fs_ffs_dirty_blk_range(folio, from, to_blk,
-						&start, &count)) {
-			submitted = 0;
-			pos = folio_pos(folio) + F2FS_BLK_TO_BYTES(sbi, start);
-			err = f2fs_write_folio_dirty_range(folio, &submitted,
-					wbc, io_type, &pos,
-					F2FS_BLK_TO_BYTES(sbi, count));
-			folio_submitted += submitted;
-			nwritten += submitted;
-			if (err)
-				goto out;
-			from = start + count;
-		}
+		err = f2fs_write_folio_dirty_range(folio, &submitted, wbc, io_type,
+						   pos, end_pos);
+		folio_submitted += submitted;
+		nwritten += submitted;
+		if (err)
+			goto out;
 
-written:
 		/* If none of the subpages of a folio is submitted, keep the atomic flag */
 		if (folio_submitted &&
 		    f2fs_is_atomic_file(inode) &&
@@ -4750,26 +4755,12 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 			folio_clear_f2fs_atomic(folio);
 
 out:
-		/*
-		 * Clear the dirty state of the subranges that were written back.
-		 * If some subranges are still dirty (e.g. the folio was only
-		 * partially written back), or if the writeback failed, the
-		 * folio must stay dirty so that the remaining subranges are
-		 * written back later.
-		 *
-		 * On success, clear dirty bits of the whole folio rather than
-		 * up to isize: subpages beyond EOF can still carry dirty bits
-		 * (e.g. fill_zero() w/ FALLOC_FL_KEEP_SIZE, BG_GC on blocks
-		 * beyond EOF, or f2fs_ffs_find_or_alloc() on a dirty folio),
-		 * they will never be written back, and would keep the folio
-		 * redirtied forever.
-		 */
-		clear_len = err ? pos - folio_pos(folio) : folio_size(folio);
-		if (f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
-						clear_len) || err) {
+		if (!err) {
+			f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
+						folio_size(folio));
+			inode_sub_dirty_blocks(inode, f2fs_blocks_per_folio(sbi, folio));
+		} else {
 			folio_redirty_for_writepage(wbc, folio);
-		} else if (!f2fs_folio_has_ffs(folio)) {
-			inode_dec_dirty_block(inode);
 		}
 
 		/*
@@ -4780,7 +4771,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 			f2fs_ffs_put_write_pending(folio, 1);
 		} else if (!folio_submitted && folio_test_writeback(folio)) {
 			/*
-			 * Order-0 folios take no bias, so end the writeback
+			 * Single-block folios take no bias, so end the writeback
 			 * if nothing was submitted.
 			 */
 			folio_end_writeback(folio);
@@ -4792,6 +4783,11 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 			op_locked = false;
 		}
 
+		if (node_locked) {
+			f2fs_up_read_trace(&sbi->node_write, &lc);
+			node_locked = false;
+		}
+
 		folio_unlock(folio);
 	}
 
@@ -4872,10 +4868,10 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto skip_write;
 
-	if ((S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) &&
-			wbc->sync_mode == WB_SYNC_NONE &&
-			get_dirty_blocks(inode) < nr_caches_to_skip(sbi, DATA) &&
-			f2fs_available_free_memory(sbi, DIRTY_DENTS))
+	if (f2fs_cp_controlled_inode(inode) &&
+	    wbc->sync_mode == WB_SYNC_NONE &&
+	    get_dirty_blocks(inode) < nr_caches_to_skip(sbi, DATA) &&
+	    f2fs_available_free_memory(sbi, DIRTY_DENTS))
 		goto skip_write;
 
 	/* skip writing in file defragment preparing stage */
@@ -4902,7 +4898,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	account_writeback(inode, true);
 
 	blk_start_plug(&plug);
-	if (mapping_large_folio_support(inode->i_mapping) &&
+	if (f2fs_has_multiblock_folios(inode) &&
 	    !f2fs_has_inline_data(inode))
 		ret = f2fs_write_cache_folios(mapping, wbc, io_type);
 	else
@@ -5136,7 +5132,7 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 	int err = 0;
 	block_t ori_blk_addr = NULL_ADDR;
 	bool cow_has_reserved_block = false;
-	bool append = ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode);
+	bool append = F2FS_BLK_TO_BYTES(sbi, index) >= i_size_read(inode);
 
 	/*
 	 * On the first attempt, an append write can skip the COW lookup and
@@ -5226,7 +5222,7 @@ static bool f2fs_balance_fs_folio_locked(struct folio *folio,
 
 static int prepare_large_folio_write_begin(struct inode *inode,
 					  struct folio *folio, loff_t pos,
-					  unsigned int len)
+					  unsigned int len, bool *need_balance)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_folio_state *ffs;
@@ -5234,9 +5230,13 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	size_t need_off = ori_off;
 	int err = 0;
 
+	if (f2fs_has_subpage_blocks(sbi) &&
+	    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode)))
+		return -EOPNOTSUPP;
+
 	/*
-	 * when the write did not come through f2fs_write_iter, we preallocate all
-	 * blocks in the write range here.
+	 * Reserve blocks without f2fs_balance_fs() since the folio is locked;
+	 * the caller balances after unlocking it if *need_balance is set.
 	 */
 	if (!is_inode_flag_set(inode, FI_PREALLOCATED_ALL) &&
 	    !IS_DEVICE_ALIASING(inode)) {
@@ -5252,9 +5252,7 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 						   &node_changed);
 			if (err)
 				return err;
-			if (f2fs_balance_fs_folio_locked(folio, folio->mapping,
-						   node_changed))
-				return -EAGAIN;
+			*need_balance |= node_changed;
 		}
 	}
 
@@ -5266,8 +5264,12 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	if (folio_test_uptodate(folio) || len == folio_size(folio))
 		return 0;
 
+	/*
+	 * Skip read if the write starts at a block boundary and reaches EOF,
+	 * and zero the rest of the folio instead.
+	 */
 	if (!f2fs_verity_in_progress(inode) &&
-	    !(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode)) {
+	    !(pos & (F2FS_BLKSIZE(sbi) - 1)) && (pos + len) >= i_size_read(inode)) {
 		size_t zoff = ori_off + len;
 
 		if (zoff < folio_size(folio))
@@ -5281,7 +5283,8 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	while (find_next_valid_block(folio, ori_off,
 				     &need_off, len)) {
 		struct dnode_of_data dn;
-		pgoff_t index = folio->index + (need_off >> PAGE_SHIFT);
+		pgoff_t index = f2fs_folio_lblk(sbi, folio) +
+				F2FS_BYTES_TO_BLK(sbi, need_off);
 		block_t blkaddr;
 
 		if (!f2fs_lookup_read_extent_cache_block(inode, index,
@@ -5297,12 +5300,13 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 			f2fs_put_dnode(&dn);
 
 			if (blkaddr == NEW_ADDR) {
-				size_t off = offset_in_folio(folio,
-							     (loff_t)index << PAGE_SHIFT);
+				size_t off = f2fs_folio_byte_offset(sbi,
+								folio, index);
 
-				folio_zero_segment(folio, off, off + PAGE_SIZE);
+				folio_zero_segment(folio, off,
+						   off + F2FS_BLKSIZE(sbi));
 				f2fs_ffs_mark_subrange_uptodate(folio, off,
-							       PAGE_SIZE);
+							       F2FS_BLKSIZE(sbi));
 				continue;
 			}
 		}
@@ -5401,12 +5405,18 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 		goto fail;
 	}
 
+	if (f2fs_has_subpage_blocks(sbi) &&
+	    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode))) {
+		err = -EOPNOTSUPP;
+		goto fail;
+	}
+
 	/*
 	 * We should check this at this moment to avoid deadlock on inode page
 	 * and #0 page. The locking rule for inline_data conversion should be:
 	 * folio_lock(folio #0) -> folio_lock(inode_page)
 	 */
-	if (index != 0) {
+	if (index != 0 || f2fs_has_subpage_blocks(sbi)) {
 		err = f2fs_convert_inline_inode(inode);
 		if (err)
 			goto fail;
@@ -5469,17 +5479,19 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 */
 	f2fs_folio_wait_writeback(folio, false, true);
 
-	if (f2fs_is_atomic_file(inode) && !folio_test_large(folio))
+	if (f2fs_is_atomic_file(inode) && !f2fs_is_multiblock_folio(sbi, folio)) {
 		err = prepare_atomic_write_begin(sbi, inode, folio->index,
 					&blkaddr, &need_balance, retried);
-	else if (!folio_test_large(folio))
+	} else if (!f2fs_is_multiblock_folio(sbi, folio)) {
 		err = prepare_write_begin(sbi, folio, pos, blen,
 					&blkaddr, &need_balance);
-	else if (f2fs_is_atomic_file(inode))
+	} else if (f2fs_is_atomic_file(inode)) {
 		err = prepare_large_folio_atomic_write_begin(inode,
 					mapping, folio, pos, len, retried);
-	else
-		err = prepare_large_folio_write_begin(inode, folio, pos, blen);
+	} else {
+		err = prepare_large_folio_write_begin(inode, folio, pos, blen,
+						      &need_balance);
+	}
 	if (err) {
 		if (err == -EAGAIN) {
 			retried = true;
@@ -5495,7 +5507,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 		goto repeat;
 	}
 
-	if (folio_test_large(folio))
+	if (f2fs_is_multiblock_folio(sbi, folio))
 		return 0;
 
 	if (blen == folio_size(folio) || folio_test_uptodate(folio))
@@ -5565,7 +5577,7 @@ static int f2fs_write_end(const struct kiocb *iocb,
 	if (!folio_test_uptodate(folio)) {
 		if (unlikely(copied != len)) {
 			copied = 0;
-		} else if (folio_test_large(folio)) {
+		} else if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio)) {
 			f2fs_ffs_mark_subrange_uptodate(folio,
 					offset_in_folio(folio, pos), len);
 		} else {
@@ -5590,7 +5602,7 @@ static int f2fs_write_end(const struct kiocb *iocb,
 	if (!copied)
 		goto unlock_out;
 
-	if (folio_test_large(folio))
+	if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio))
 		f2fs_ffs_mark_subrange_dirty(folio, offset_in_folio(folio, pos),
 								   copied);
 	folio_mark_dirty(folio);
@@ -5642,6 +5654,9 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 		 * dirty state.
 		 */
 		if (!dirty && folio_test_dirty(folio)) {
+			inode_sub_dirty_blocks(inode,
+					f2fs_blocks_per_folio(sbi, folio));
+			f2fs_remove_dirty_inode(inode);
 			f2fs_clear_page_cache_dirty_tag(folio);
 			folio_cancel_dirty(folio);
 		}
@@ -5650,11 +5665,8 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 		return;
 	}
 
-	if (f2fs_folio_has_ffs(folio)) {
-		f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
-							folio_size(folio));
-	} else if (folio_test_dirty(folio)) {
-		inode_dec_dirty_block(inode);
+	if (folio_test_dirty(folio)) {
+		inode_sub_dirty_blocks(inode, f2fs_blocks_per_folio(sbi, folio));
 		f2fs_remove_dirty_inode(inode);
 	}
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index aa3511c6f8fe..7f5dc2354a27 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -979,9 +979,9 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, void *dentry_block,
 		if (!f2fs_has_subpage_blocks(sbi)) {
 			folio_clear_uptodate(folio);
 			folio_detach_private(folio);
-			inode_dec_dirty_block(dir);
 		}
 
+		inode_sub_dirty_blocks(dir, f2fs_blocks_per_folio(sbi, folio));
 		f2fs_remove_dirty_inode(dir);
 	}
 keep_dirty:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cf7294068415..aab1095ad5ff 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4457,7 +4457,6 @@ void f2fs_remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino);
 int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi);
 int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi);
 void f2fs_update_dirty_folio(struct inode *inode, struct folio *folio);
-void f2fs_account_dirty_blocks(struct inode *inode, int nr);
 void f2fs_remove_dirty_inode(struct inode *inode);
 int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
 								bool from_cp);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1ce4553b1d01..be548f39e33e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5561,12 +5561,13 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 			return ret;
 	}
 
-	if (!dio && mapping_large_folio_support(inode->i_mapping)) {
+	if (!dio && f2fs_has_multiblock_folios(inode)) {
 		/*
-		 * Preallocate all blocks touched by a large-folio buffered write so
-		 * the regular write_begin path does not need to unlock the folio for
-		 * f2fs_balance_fs().  Rechecking large-folio state after unlock is
-		 * unreliable since partial truncation can split the folio.
+		 * Preallocate all blocks touched by a multiblock-folio buffered
+		 * write so the regular write_begin path does not need to unlock
+		 * the folio for f2fs_balance_fs().  Rechecking large-folio
+		 * state after unlock is unreliable since partial truncation can
+		 * split the folio.
 		 */
 		map.m_lblk = F2FS_BYTES_TO_BLK(sbi, pos);
 		map.m_len = F2FS_BLK_ALIGN(sbi, pos + count);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6c24001325b2..f041a036836e 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1608,13 +1608,12 @@ static int move_data_cache_block(struct inode *inode, block_t bidx, int gc_type,
 			f2fs_ffs_mark_subrange_dirty(folio, foff, F2FS_BLKSIZE(sbi));
 		folio_mark_dirty(folio);
 		if (folio_clear_dirty_for_io(folio)) {
-			if (!has_ffs) {
-				inode_dec_dirty_block(inode);
-				f2fs_remove_dirty_inode(inode);
-			} else if (f2fs_ffs_clear_subrange_dirty_and_test(folio,
-						foff, F2FS_BLKSIZE(sbi))) {
+			inode_sub_dirty_blocks(inode, f2fs_blocks_per_folio(sbi, folio));
+			f2fs_remove_dirty_inode(inode);
+			if (has_ffs &&
+			    f2fs_ffs_clear_subrange_dirty_and_test(folio, foff,
+							F2FS_BLKSIZE(sbi)))
 				folio_mark_dirty(folio);
-			}
 		}
 
 		folio_set_f2fs_gcing(folio);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index ba0aff8e5643..757be9f8d069 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -196,10 +196,15 @@ int f2fs_convert_inline_folio(struct dnode_of_data *dn, struct folio *folio)
 	folio_start_writeback(folio);
 	fio.old_blkaddr = dn->data_blkaddr;
 	set_inode_flag(dn->inode, FI_HOT_DATA);
+	if (f2fs_is_multiblock_folio(fio.sbi, folio)) {
+		struct f2fs_folio_state *ffs = f2fs_ffs_find_or_alloc(folio);
+
+		atomic_inc(&ffs->write_blocks_pending);
+	}
 	f2fs_outplace_write_data(dn, &fio);
 	f2fs_folio_wait_writeback(folio, true, true);
 	if (dirty) {
-		inode_dec_dirty_block(dn->inode);
+		inode_sub_dirty_blocks(dn->inode, f2fs_blocks_per_folio(fio.sbi, folio));
 		f2fs_remove_dirty_inode(dn->inode);
 	}
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c48b12208e20..b95bb5c27b0b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1700,7 +1700,7 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 		goto folio_out;
 
 	ret = f2fs_write_inline_data(inode, folio);
-	inode_dec_dirty_block(inode);
+	inode_sub_dirty_blocks(inode, f2fs_blocks_per_folio(sbi, folio));
 	f2fs_remove_dirty_inode(inode);
 	if (ret)
 		folio_mark_dirty(folio);
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
