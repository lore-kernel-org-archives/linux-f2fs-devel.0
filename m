Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B020CA6019
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vsvXltaIRIzIA0vVpGmIu9MCu0yFZ/JLwEhSz1IPRII=; b=YLWHUHd11UU+1wziwB/Vlh+VlW
	R2sxvkKaIsXI7zDyeR3wpKiLq/7Ob1OtM+0tbMo8f6LkVx+tECUFbkNQC2bscKPslRDJeKbJVRtTz
	kAOEPfCk19AdupIMjS/K5Dk4TBnXRJVur9eE0WmHPPsUDiEY4dJ8ksFD9qHUcwYv77HE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFDE9-0008AG-Oh;
	Fri, 09 Oct 2026 16:13:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xFDE8-0008A8-1R
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:13:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q2VRG6oKgHJGSEiyjBYUgxks4/k5G6IStldatbDgZNQ=; b=MdwjsYCUlI8OyWB/+MScVTeClW
 n5fG7pUZladZgJqXgsbuSNrGQEM67DXpm8aHgzbaW7oa/iMlN50VX1NG6pm7RNULZV9RBxOcLMzAn
 ew5AbuvkMEN4YpspHRPD6SuXv/Iaag31LFRP+NJpRJYTJnfekLcGWaSQcSMwJPx9x5zk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q2VRG6oKgHJGSEiyjBYUgxks4/k5G6IStldatbDgZNQ=; b=So2b9BQA/VDsSOv2uwFnKc9nBy
 3vvk49V+xUxn0eH/Ra4HMN0CsDj9PCr5vTZtlEJFPrcvCVKRP8MLS4sra582A5RO1oI67xfSeSg9F
 fqng9l5OLVl/68hiJJoHLd5j1kKYTMPbYEGdPv1PtFUQchtGSDF7YcRBZy/vSpMDexRc=;
Received: from m16.mail.126.com ([117.135.210.6])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFDE3-0003lU-7T for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:13:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=q2
 VRG6oKgHJGSEiyjBYUgxks4/k5G6IStldatbDgZNQ=; b=nW39GsgdGU4/8DTuJl
 Xb9TxfxujXmickfIiZI0um5KTbPaJzsKHo38v1EOgU5n1wyYIaAvTvHWgyDvtO/D
 bDRAUITGqgby+7aZ38TL726ALdlzsggT/t0a6Fno0vGwXmm7k4ASPQCjHpUudS7+
 4Orxa7gyFbx5NTjAm/TzI25KU=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wD3V46AEslqHAsZBA--.38226S5; 
 Sat, 10 Oct 2026 00:13:07 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Sat, 10 Oct 2026 00:12:10 +0800
Message-ID: <20261009161224.4163796-4-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3V46AEslqHAsZBA--.38226S5
X-Coremail-Antispam: 1Uf129KBjvAXoW3ZFWxZw17ZF48GFyrJFWkZwb_yoW8WF18Xo
 WfJws0qw4rJr17WrWjkw17KFyUuan8Cr95JFs3ursxuFnrX3s09w47Kwn8XayxWr15GF17
 CryxJa13WrW7Jr1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcXo2UUUUU
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBoxO1hWrJEpPyMQAA3h
X-Headers-End: 1xFDE3-0003lU-7T
Subject: [f2fs-dev] [PATCH v3 03/17] f2fs: support regular file buffered
 writes on large folios
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Juan Yescas <jyescas@google.com>, Daeho Jeong <daehojeong@google.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-kernel@vger.kernel.org, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

To avoid the complexity of unlocking a large folio in write_begin,
preallocate partial blocks for inodes that can use large folios.
During write_begin, read only the partial head and tail 4K subpages
that need read-before-write, and skip read I/O for the full middle
subpages covered by the write.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 369 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/f2fs/f2fs.h |   1 +
 fs/f2fs/file.c |  17 ++-
 3 files changed, 370 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6b8bee06a4f3..af2bb02e301f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -93,6 +93,20 @@ struct bio_post_read_ctx {
 	block_t fs_blkaddr;
 };
 
+static bool __ffs_mark_subrange_uptodate(struct folio *folio,
+		struct f2fs_folio_state *ffs, size_t offset, size_t len)
+{
+	unsigned int nr_subpages = folio_nr_pages(folio);
+	unsigned int start, end;
+
+	start = offset >> PAGE_SHIFT;
+	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	end = min(end, nr_subpages);
+
+	bitmap_set(ffs->state, start, end - start);
+	return bitmap_full(ffs->state, nr_subpages);
+}
+
 /*
  * Update and unlock a bio's pages, and free the bio.
  *
@@ -107,6 +121,23 @@ struct bio_post_read_ctx {
  * called (i.e., I/O error or decryption error, but *not* verity error), and
  * release the bio's reference to the decompress_io_ctx of the page's cluster.
  */
+/*
+ * Update read_pages_pending.
+ */
+static inline void f2fs_update_read_folio_pending(struct folio *folio, int nr)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned long flags;
+
+	if (!f2fs_folio_has_ffs(folio))
+		return;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	ffs->read_pages_pending += nr;
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+}
+
 static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 {
 	struct folio_iter fi;
@@ -128,7 +159,8 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 		}
 
 		if (folio_test_large(folio)) {
-			struct f2fs_folio_state *ffs = folio->private;
+			struct f2fs_folio_state *ffs =
+				(struct f2fs_folio_state *)folio->private;
 
 			spin_lock_irqsave(&ffs->state_lock, flags);
 			ffs->read_pages_pending -= nr_pages;
@@ -1430,6 +1462,36 @@ static void f2fs_submit_page_read(struct inode *inode, struct fsverity_info *vi,
 	f2fs_submit_read_bio(sbi, bio, DATA);
 }
 
+/*
+ * Synchronously read a single 4K subpage by reusing f2fs_submit_page_read()
+ * so that iostat, trace, blk-crypto and post-read handling are all preserved.
+ * The caller must have already allocated ffs for the folio.
+ */
+static int f2fs_submit_page_read_sync(struct inode *inode, struct folio *folio,
+				      pgoff_t index, block_t blkaddr)
+{
+	struct f2fs_folio_state *ffs =
+		(struct f2fs_folio_state *)folio->private;
+
+	/* Add bias so end_io does not call folio_end_read(). */
+	f2fs_update_read_folio_pending(folio, 1);
+
+	f2fs_submit_page_read(inode, NULL, folio, index, blkaddr,
+			      REQ_OP_READ, false);
+
+	/* Wait until all bios have completed (pending drops back to our bias). */
+	while (READ_ONCE(ffs->read_pages_pending) != 1)
+		f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
+
+	/* Remove the bias. */
+	f2fs_update_read_folio_pending(folio, -1);
+
+	if (!f2fs_ffs_test_blk_uptodate(folio, index))
+		return -EIO;
+
+	return 0;
+}
+
 static void __set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 {
 	__le32 *addr = get_dnode_addr(dn->inode, dn->node_entry);
@@ -2767,6 +2829,110 @@ static void ffs_detach_free(struct folio *folio)
 	kfree(ffs);
 }
 
+bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned int idx;
+
+	f2fs_bug_on(F2FS_F_SB(folio), !folio_contains(folio, index));
+
+	if (folio_test_uptodate(folio))
+		return true;
+
+	if (!f2fs_folio_has_ffs(folio))
+		return false;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	idx = index - folio->index;
+	return test_bit(idx, ffs->state);
+}
+
+static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
+				       size_t len)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned long flags;
+	bool mark_uptodate = false;
+
+	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
+
+	if (!f2fs_folio_has_ffs(folio)) {
+		folio_mark_uptodate(folio);
+		return;
+	}
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	mark_uptodate = __ffs_mark_subrange_uptodate(folio, ffs, offset, len) &&
+			!ffs->read_pages_pending;
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+	if (mark_uptodate)
+		folio_mark_uptodate(folio);
+}
+
+static unsigned int __ffs_mark_subrange_dirty(struct folio *folio,
+			struct f2fs_folio_state *ffs, size_t offset, size_t len)
+{
+	unsigned int nr_subpages = folio_nr_pages(folio);
+	unsigned int start, end, before;
+
+	start = offset >> PAGE_SHIFT;
+	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	end = min(end, nr_subpages);
+
+	before = bitmap_weight(ffs->state, 2 * nr_subpages);
+	bitmap_set(ffs->state, nr_subpages + start, end - start);
+	return bitmap_weight(ffs->state, 2 * nr_subpages) - before;
+}
+
+static void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
+				    size_t offset, size_t len)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned long flags;
+
+	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
+
+	if (!f2fs_folio_has_ffs(folio))
+		return;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	__ffs_mark_subrange_dirty(folio, ffs, offset, len);
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+}
+
+static bool find_next_valid_block(const struct folio *folio,
+				  size_t orig_off, size_t *need_off,
+				  size_t len)
+{
+	size_t start = orig_off;
+	size_t end = start + len;
+	size_t head, tail;
+	pgoff_t index;
+
+	if (start & (PAGE_SIZE - 1)) {
+		head = round_down(start, PAGE_SIZE);
+		index = folio->index + (head >> PAGE_SHIFT);
+		if (!f2fs_ffs_test_blk_uptodate(folio, index)) {
+			*need_off = head;
+			return true;
+		}
+	}
+
+	if (end & (PAGE_SIZE - 1)) {
+		tail = round_down(end, PAGE_SIZE);
+		index = folio->index + (tail >> PAGE_SHIFT);
+		if (!f2fs_ffs_test_blk_uptodate(folio, index)) {
+			*need_off = tail;
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static int f2fs_read_data_large_folio(struct inode *inode,
 		struct fsverity_info *vi,
 		struct readahead_control *rac, struct folio *folio)
@@ -4128,6 +4294,135 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 	return 0;
 }
 
+/*
+ * Drop the folio lock when a node was changed, then balance the
+ * filesystem and reacquire the lock.
+ *
+ * Return: true if the folio became unusable while unlocked (being
+ * truncated), false if the folio is still usable.
+ */
+static bool f2fs_folio_may_unlock_balance_fs(struct folio *folio,
+		struct address_space *mapping, bool node_changed)
+{
+	struct inode *inode = folio->mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int orig_order;
+
+	if (!node_changed || IS_NOQUOTA(inode) ||
+			!has_not_enough_free_secs(sbi, 0, 0))
+		return false;
+
+	orig_order = folio_order(folio);
+	folio_unlock(folio);
+	f2fs_balance_fs(sbi, true);
+	folio_lock(folio);
+
+	if (folio->mapping != mapping)
+		return true;
+
+	if (folio_order(folio) != orig_order)
+		return true;
+
+	return false;
+}
+
+static int prepare_large_folio_write_begin(struct inode *inode,
+					  struct folio *folio, loff_t pos,
+					  unsigned int len)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_folio_state *ffs;
+	size_t ori_off = offset_in_folio(folio, pos);
+	size_t need_off = ori_off;
+	int err = 0;
+
+	/*
+	 * when the write did not come through f2fs_write_iter, we preallocate all
+	 * blocks in the write range here.
+	 */
+	if (!is_inode_flag_set(inode, FI_PREALLOCATED_ALL) &&
+	    !IS_DEVICE_ALIASING(inode)) {
+		pgoff_t first = F2FS_BYTES_TO_BLK(sbi, pos);
+		pgoff_t last = F2FS_BLK_ALIGN(sbi, pos + len);
+		pgoff_t idx;
+
+		for (idx = first; idx < last; idx++) {
+			block_t blkaddr = NULL_ADDR;
+			bool node_changed = false;
+
+			err = __reserve_data_block(inode, idx, &blkaddr,
+						   &node_changed);
+			if (err)
+				return err;
+			if (f2fs_folio_may_unlock_balance_fs(folio, folio->mapping,
+						   node_changed))
+				return -EAGAIN;
+		}
+	}
+
+	ffs = f2fs_ffs_find_or_alloc(folio);
+	if (!ffs)
+		return -ENOMEM;
+
+	/* Skip read if the folio is already fully uptodate or the write
+	 * covers the entire folio.
+	 */
+	if (folio_test_uptodate(folio) || len == folio_size(folio))
+		return 0;
+
+	if (!f2fs_verity_in_progress(inode) &&
+	    !(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode)) {
+		size_t zoff = ori_off + len;
+
+		if (zoff < folio_size(folio))
+			folio_zero_segment(folio, zoff, folio_size(folio));
+		return 0;
+	}
+
+	/* Inline data must have been converted before reaching here. */
+	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
+
+	while (find_next_valid_block(folio, ori_off,
+				     &need_off, len)) {
+		struct dnode_of_data dn;
+		pgoff_t index = folio->index + (need_off >> PAGE_SHIFT);
+		block_t blkaddr;
+
+		if (!f2fs_lookup_read_extent_cache_block(inode, index,
+							&blkaddr)) {
+			if (IS_DEVICE_ALIASING(inode))
+				return -ENODATA;
+
+			set_new_dnode(&dn, inode, NULL, NULL, 0);
+			err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
+			if (err)
+				return err;
+			blkaddr = dn.data_blkaddr;
+			f2fs_put_dnode(&dn);
+
+			if (blkaddr == NEW_ADDR) {
+				size_t off = offset_in_folio(folio,
+							     index << PAGE_SHIFT);
+
+				folio_zero_segment(folio, off, off + PAGE_SIZE);
+				f2fs_ffs_mark_subrange_uptodate(folio, off,
+							       PAGE_SIZE);
+				continue;
+			}
+
+			if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
+						  DATA_GENERIC_ENHANCE_READ))
+				return -EFSCORRUPTED;
+		}
+
+		err = f2fs_submit_page_read_sync(inode, folio, index, blkaddr);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int f2fs_write_begin(const struct kiocb *iocb,
 			    struct address_space *mapping,
 			    loff_t pos, unsigned len, struct folio **foliop,
@@ -4139,6 +4434,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	pgoff_t index = pos >> PAGE_SHIFT;
 	bool need_balance = false;
 	block_t blkaddr = NULL_ADDR;
+	fgf_t fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT;
+	unsigned int blen;
 	int err = 0;
 
 	trace_f2fs_write_begin(inode, pos, len);
@@ -4186,9 +4483,15 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 * Do not use FGP_STABLE to avoid deadlock.
 	 * Will wait that below with our IO control.
 	 */
-	folio = f2fs_filemap_get_folio(mapping, index,
-				FGP_LOCK | FGP_WRITE | FGP_CREAT,
-				mapping_gfp_mask(mapping));
+	/*
+	 * Inline data is carried in the first subpage.  Keep the index #0
+	 * folio order-0 so that the existing inline read/convert paths
+	 * (prepare_write_begin()) still apply; large folios are used from
+	 * the second folio on.
+	 */
+	fgp |= fgf_set_order(f2fs_has_inline_data(inode) ? PAGE_SIZE : len);
+	folio = f2fs_filemap_get_folio(mapping, index, fgp,
+				      mapping_gfp_mask(mapping));
 	if (IS_ERR(folio)) {
 		err = PTR_ERR(folio);
 		goto fail;
@@ -4198,11 +4501,15 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 
 	*foliop = folio;
 
+	/* Clamp the write length to the folio size. */
+	blen = min_t(unsigned int, len,
+		     folio_size(folio) - offset_in_folio(folio, pos));
+
 	if (f2fs_is_atomic_file(inode))
 		err = prepare_atomic_write_begin(sbi, folio, pos, len,
 					&blkaddr, &need_balance);
-	else
-		err = prepare_write_begin(sbi, folio, pos, len,
+	else if (!folio_test_large(folio))
+		err = prepare_write_begin(sbi, folio, pos, blen,
 					&blkaddr, &need_balance);
 	if (err)
 		goto put_folio;
@@ -4222,7 +4529,19 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 
 	f2fs_folio_wait_writeback(folio, false, true);
 
-	if (len == folio_size(folio) || folio_test_uptodate(folio))
+	if (folio_test_large(folio)) {
+		err = prepare_large_folio_write_begin(inode,
+					folio, pos, blen);
+		if (!err)
+			return 0;
+		if (err == -EAGAIN) {
+			f2fs_folio_put(folio, true);
+			goto repeat;
+		}
+		goto put_folio;
+	}
+
+	if (blen == folio_size(folio) || folio_test_uptodate(folio))
 		return 0;
 
 	if (!(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode) &&
@@ -4282,15 +4601,20 @@ static int f2fs_write_end(const struct kiocb *iocb,
 	trace_f2fs_write_end(inode, pos, len, copied);
 
 	/*
-	 * This should be come from len == PAGE_SIZE, and we expect copied
-	 * should be PAGE_SIZE. Otherwise, we treat it with zero copied and
-	 * let generic_perform_write() try to copy data again through copied=0.
+	 * If a short copy happens on a folio that isn't uptodate, we treat
+	 * it with zero copied and let generic_perform_write() try to copy
+	 * data again through copied=0.
 	 */
 	if (!folio_test_uptodate(folio)) {
-		if (unlikely(copied != len))
+		if (unlikely(copied != len)) {
 			copied = 0;
-		else
+		} else if (folio_test_large(folio)) {
+			f2fs_ffs_mark_subrange_uptodate(folio,
+					offset_in_folio(folio, pos), len);
+		} else {
+			/* This should be come from len == PAGE_SIZE */
 			folio_mark_uptodate(folio);
+		}
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -4309,6 +4633,9 @@ static int f2fs_write_end(const struct kiocb *iocb,
 	if (!copied)
 		goto unlock_out;
 
+	if (folio_test_large(folio))
+		f2fs_ffs_mark_subrange_dirty(folio, offset_in_folio(folio, pos),
+								   copied);
 	folio_mark_dirty(folio);
 
 	if (f2fs_is_atomic_file(inode))
@@ -4365,8 +4692,22 @@ static bool f2fs_dirty_data_folio(struct address_space *mapping,
 
 	trace_f2fs_set_page_dirty(folio, DATA);
 
-	if (!folio_test_uptodate(folio))
-		folio_mark_uptodate(folio);
+	if (!folio_test_uptodate(folio)) {
+		bool uptodate = true;
+
+		if (f2fs_folio_has_ffs(folio)) {
+			struct f2fs_folio_state *ffs =
+				(struct f2fs_folio_state *)folio->private;
+			unsigned long flags;
+
+			spin_lock_irqsave(&ffs->state_lock, flags);
+			uptodate = bitmap_full(ffs->state, folio_nr_pages(folio)) &&
+				   !ffs->read_pages_pending;
+			spin_unlock_irqrestore(&ffs->state_lock, flags);
+		}
+		if (uptodate)
+			folio_mark_uptodate(folio);
+	}
 	BUG_ON(folio_test_swapcache(folio));
 
 	if (filemap_dirty_folio(mapping, folio)) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 20b7de55b2bf..e14275f98fe7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4450,6 +4450,7 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				struct writeback_control *wbc,
 				enum iostat_type io_type,
 				int compr_blocks, bool allow_balance);
+bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index);
 void f2fs_write_failed(struct inode *inode, loff_t to);
 void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 bool f2fs_release_folio(struct folio *folio, gfp_t wait);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ef4d218e694b..aade9a04d8f3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5408,9 +5408,20 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 			return ret;
 	}
 
-	/* Do not preallocate blocks that will be written partially in 4KB. */
-	map.m_lblk = F2FS_BLK_ALIGN(sbi, pos);
-	map.m_len = F2FS_BYTES_TO_BLK(sbi, pos + count);
+	if (!dio && mapping_large_folio_support(inode->i_mapping)) {
+		/*
+		 * Preallocate all blocks touched by a large-folio buffered write so
+		 * the regular write_begin path does not need to unlock the folio for
+		 * f2fs_balance_fs().  Rechecking large-folio state after unlock is
+		 * unreliable since partial truncation can split the folio.
+		 */
+		map.m_lblk = F2FS_BYTES_TO_BLK(sbi, pos);
+		map.m_len = F2FS_BLK_ALIGN(sbi, pos + count);
+	} else {
+		/* Do not preallocate blocks that will be written partially in 4KB. */
+		map.m_lblk = F2FS_BLK_ALIGN(sbi, pos);
+		map.m_len = F2FS_BYTES_TO_BLK(sbi, pos + count);
+	}
 	if (map.m_len > map.m_lblk)
 		map.m_len -= map.m_lblk;
 	else
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
