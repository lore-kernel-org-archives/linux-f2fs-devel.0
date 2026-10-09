Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28942CA6015
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rhHw0ANiOok4v2lThOXzpXV6oF8CTkEe/qbIFq4qkoo=; b=bE8m2RnRuejZ6J5clkRljxxdoy
	7WuxKObU3S7eBZ/FMW7cWycLcYPrd7numqSsJfwD1k0UuhZ8YGTvGrLCHpYrg+q2rqgVKTk1W10kE
	IpsjSw38P1861tDRrYS7AntttRLeT302v1+Ggmz2AjB6nm8O5NkgAVz9szMQXCF59gzY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFDEo-0002QV-IO;
	Fri, 09 Oct 2026 16:14:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xFDEH-0002Ow-Rh
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:13:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C4a/l3yrYI9vY3qGLxFYskI52QYPBdqgzoc8OFX8U/w=; b=PDhMyv/lz4+17u1T0LEIGPjNJA
 lzK2IylQhm3lrXxQYivSE2yw4/mQmbWvDzQr0Fj2aiDcN7iB/bh+MkhkeA3ZJcOnFWoACz5tsoOAu
 QitXvQ7uFNDGH3HsHtGgoNex1xSrxC7t9NYqtfFo0XsKKtbdh4lfa4ycX3dBbAazZjvI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C4a/l3yrYI9vY3qGLxFYskI52QYPBdqgzoc8OFX8U/w=; b=eMrhfnizTJAWOtZtfWPPW9YfXR
 L79uGRMh+vvmZuy5sVWpY9rU0kMvm33sdlObxvICNv99zpQA+4QeXMWKo0grZlpgv75sOXs9pZj+N
 mOug8jW2eNv8rzD3TJhio3VuEKpuL+PkXNijEenzqMaud7pzpT4vOLb406KpoxCDL7zo=;
Received: from m16.mail.126.com ([220.197.31.6])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFDEC-00055e-Rg for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:13:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=C4
 a/l3yrYI9vY3qGLxFYskI52QYPBdqgzoc8OFX8U/w=; b=bdUnVZNnvEBBhNewLO
 jKAlugX0GeIuxDgTd+2+YnirZfauYP2mEbpR3Luy4p/M/EZNdnsDPUuQWXRYgQd/
 U8oqzRaVJRI5zHZgPyDTt9MAa9whnSy64sWSFmQsbqkhT/Ysg5UzMTJ9FprAvd/Y
 TqveuNMzaTZ/XrR4H2hvhOOUM=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wD3V46AEslqHAsZBA--.38226S7; 
 Sat, 10 Oct 2026 00:13:12 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Sat, 10 Oct 2026 00:12:12 +0800
Message-ID: <20261009161224.4163796-6-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3V46AEslqHAsZBA--.38226S7
X-Coremail-Antispam: 1Uf129KBjvAXoW3KFWrWw1kAF18WFW5GF45Wrg_yoW8GrW5Ao
 WfXw4qqr18Kr17ArWj9w12qFyUuan8AF95CF4fur4DZ3ZFq3s09ws7Kws8X3W7Xr1Ykr1x
 uryxK3ZxJrWxAFn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7FksDUUUU
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBoxi3h2rJEpjySAAA3Y
X-Headers-End: 1xFDEC-00055e-Rg
Subject: [f2fs-dev] [PATCH v3 05/17] f2fs: support large folio writeback
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

Large folio can contain multiple dirty ranges.
Add a folio-based writeback path for large-folio mapping files
and keep the legacy f2fs_write_cache_pages() path unchanged for
non large-folio mapping files.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 427 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 422 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 315506e394ed..da388ed9cccc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -334,7 +334,9 @@ static void f2fs_write_end_bio(struct bio *bio)
 
 	bio_for_each_folio_all(fi, bio) {
 		struct folio *folio = fi.folio;
+		unsigned int nr_pages = fi.length >> PAGE_SHIFT;
 		enum count_type type;
+		bool finished = true;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		if (f2fs_is_compressed_page(folio)) {
@@ -353,7 +355,16 @@ static void f2fs_write_end_bio(struct bio *bio)
 			}
 		}
 
-		dec_cache_count(sbi, type);
+		if (f2fs_folio_has_ffs(folio)) {
+			struct f2fs_folio_state *ffs =
+				(struct f2fs_folio_state *)folio->private;
+
+			finished = atomic_sub_and_test(nr_pages,
+					&ffs->write_pages_pending);
+		}
+
+		while (nr_pages--)
+			dec_cache_count(sbi, type);
 
 		/*
 		 * we should access sbi before folio_end_writeback() to
@@ -363,8 +374,10 @@ static void f2fs_write_end_bio(struct bio *bio)
 				wq_has_sleeper(&sbi->cp_wait))
 			wake_up(&sbi->cp_wait);
 
-		folio_clear_f2fs_gcing(folio);
-		folio_end_writeback(folio);
+		if (finished) {
+			folio_clear_f2fs_gcing(folio);
+			folio_end_writeback(folio);
+		}
 	}
 
 	bio_put(bio);
@@ -2885,7 +2898,7 @@ static unsigned int __ffs_mark_subrange_dirty(struct folio *folio,
 	return bitmap_weight(ffs->state, 2 * nr_subpages) - before;
 }
 
-static void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
+void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
 				    size_t offset, size_t len)
 {
 	struct f2fs_folio_state *ffs;
@@ -2903,6 +2916,99 @@ static void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
 	spin_unlock_irqrestore(&ffs->state_lock, flags);
 }
 
+static bool __ffs_clear_subrange_dirty(struct folio *folio,
+			struct f2fs_folio_state *ffs, size_t offset, size_t len)
+{
+	unsigned int nr_subpages = folio_nr_pages(folio);
+	unsigned int start, end;
+
+	start = offset >> PAGE_SHIFT;
+	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	end = min(end, nr_subpages);
+
+	bitmap_clear(ffs->state, nr_subpages + start, end - start);
+	return find_next_bit(ffs->state, 2 * nr_subpages, nr_subpages) <
+			2 * nr_subpages;
+}
+
+/**
+ * f2fs_ffs_clear_subrange_dirty_and_test - clear dirty bits and test remaining
+ * @folio: the large folio
+ * @offset: start byte offset within the folio
+ * @len: byte length of the subrange
+ *
+ * Clear the dirty bits of the 4K subpages covered by [offset, offset + len),
+ * and return whether the folio still has any dirty subpage left.
+ */
+bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
+					    size_t len)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned long flags;
+	bool dirty;
+
+	if (!f2fs_folio_has_ffs(folio))
+		return false;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	dirty = __ffs_clear_subrange_dirty(folio, ffs, offset, len);
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+
+	return dirty;
+}
+
+static unsigned int ffs_next_dirty_subpage(struct f2fs_folio_state *ffs,
+			const struct folio *folio, unsigned int start,
+			unsigned int end)
+{
+	unsigned int nr_subpages = folio_nr_pages(folio);
+
+	return find_next_bit(ffs->state, nr_subpages + end + 1,
+			nr_subpages + start) - nr_subpages;
+}
+
+static unsigned int ffs_next_clean_subpage(struct f2fs_folio_state *ffs,
+			const struct folio *folio, unsigned int start,
+			unsigned int end)
+{
+	unsigned int nr_subpages = folio_nr_pages(folio);
+
+	return find_next_zero_bit(ffs->state, nr_subpages + end + 1,
+			nr_subpages + start) - nr_subpages;
+}
+
+static unsigned int ffs_find_dirty_range(struct folio *folio,
+					u64 *range_start, u64 range_end)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned int start, end, nr_pages;
+
+	if (*range_start >= range_end)
+		return 0;
+
+	if (!f2fs_folio_has_ffs(folio))
+		return range_end - *range_start;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	start = offset_in_folio(folio, *range_start) >> PAGE_SHIFT;
+	end = DIV_ROUND_UP(min_not_zero(offset_in_folio(folio, range_end),
+					folio_size(folio)), PAGE_SIZE) - 1;
+
+	start = ffs_next_dirty_subpage(ffs, folio, start, end);
+	if (start > end)
+		return 0;
+
+	if (start == end)
+		nr_pages = 1;
+	else
+		nr_pages = ffs_next_clean_subpage(ffs, folio,
+						 start + 1, end) - start;
+
+	*range_start = folio_pos(folio) + ((u64)start << PAGE_SHIFT);
+	return (u64)nr_pages << PAGE_SHIFT;
+}
+
 static bool find_next_valid_block(const struct folio *folio,
 				  size_t orig_off, size_t *need_off,
 				  size_t len)
@@ -3486,6 +3592,143 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	return err;
 }
 
+static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
+					struct writeback_control *wbc,
+					enum iostat_type io_type,
+					u64 *pos, u64 len)
+{
+	struct inode *inode = folio->mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	bool atomic_commit = f2fs_is_atomic_file(inode) &&
+				folio_test_f2fs_atomic(folio);
+	struct inode *dn_inode = atomic_commit ?
+				F2FS_I(inode)->cow_inode : inode;
+	struct f2fs_folio_state *ffs = NULL;
+	u64 folio_start = folio_pos(folio);
+	pgoff_t start_idx = (*pos - folio_start) >> PAGE_SHIFT;
+	pgoff_t end_idx = (*pos - folio_start + len - 1) >> PAGE_SHIFT;
+	int err = 0;
+
+	for (pgoff_t i = start_idx; i <= end_idx && !err; i++) {
+		struct dnode_of_data dn;
+		struct node_info ni;
+		pgoff_t data_idx = folio->index + i;
+		bool ipu_force = false;
+		bool dn_held = false;
+		bool submitted_blk = false;
+		struct f2fs_io_info fio = {
+			.sbi = sbi,
+			.ino = inode->i_ino,
+			.type = DATA,
+			.op = REQ_OP_WRITE,
+			.op_flags = wbc_to_write_flags(wbc),
+			.old_blkaddr = NULL_ADDR,
+			.folio = folio,
+			.folio_offset = i,
+			.folio_blkcnt = 1,
+			.encrypted_page = NULL,
+			.submitted = 0,
+			.need_lock = LOCK_DONE,
+			.meta_gc = f2fs_meta_inode_gc_required(inode) ? 1 : 0,
+			.io_type = io_type,
+			.io_wbc = wbc,
+		};
+
+		if (f2fs_folio_has_ffs(folio)) {
+			ffs = (struct f2fs_folio_state *)folio->private;
+			atomic_inc(&ffs->write_pages_pending);
+		}
+
+		set_new_dnode(&dn, dn_inode, NULL, NULL, 0);
+
+		if (need_inplace_update(&fio) &&
+		    f2fs_lookup_read_extent_cache_block(inode, data_idx,
+							&fio.old_blkaddr)) {
+			if (!f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
+						   DATA_GENERIC_ENHANCE)) {
+				err = -EFSCORRUPTED;
+				goto block_done;
+			}
+			ipu_force = true;
+			goto got_it;
+		}
+
+		err = f2fs_get_dnode_of_data(&dn, data_idx, LOOKUP_NODE);
+
+		if (err)
+			goto block_done;
+		dn_held = true;
+
+		fio.old_blkaddr = dn.data_blkaddr;
+
+got_it:
+		if (__is_valid_data_blkaddr(fio.old_blkaddr) &&
+		    !f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
+					   DATA_GENERIC_ENHANCE)) {
+			err = -EFSCORRUPTED;
+			goto block_done;
+		}
+
+		if (fio.meta_gc)
+			f2fs_wait_on_block_writeback(inode, fio.old_blkaddr);
+
+		if (ipu_force ||
+		    (__is_valid_data_blkaddr(fio.old_blkaddr) &&
+					    need_inplace_update(&fio))) {
+			f2fs_put_dnode(&dn);
+			dn_held = false;
+			err = f2fs_inplace_write_data(&fio);
+			trace_f2fs_do_write_data_page(folio, IPU);
+			if (err)
+				goto block_done;
+
+			if (submitted)
+				(*submitted)++;
+			submitted_blk = true;
+			set_inode_flag(inode, FI_UPDATE_WRITE);
+			goto block_done;
+		}
+
+		err = f2fs_get_node_info(sbi, dn.nid, &ni, false);
+		if (err)
+			goto block_done;
+
+		fio.version = ni.version;
+
+		f2fs_outplace_write_data(&dn, &fio);
+		/*
+		 * The outplace write path failed to submit this block.
+		 */
+		if (!fio.submitted)
+			goto block_done;
+		if (submitted)
+			(*submitted)++;
+		submitted_blk = true;
+		set_inode_flag(inode, FI_APPEND_WRITE);
+		trace_f2fs_do_write_data_page(folio, OPU);
+block_done:
+		if (dn_held)
+			f2fs_put_dnode(&dn);
+		/*
+		 * If this block was not submitted, roll back its
+		 * write pages pending.
+		 */
+		if (!submitted_blk && ffs)
+			atomic_dec(&ffs->write_pages_pending);
+		if (!err) {
+			*pos = (data_idx + 1) << PAGE_SHIFT;
+			spin_lock(&F2FS_I(inode)->i_size_lock);
+			if (F2FS_I(inode)->last_disk_size < *pos)
+				F2FS_I(inode)->last_disk_size = *pos;
+			spin_unlock(&F2FS_I(inode)->i_size_lock);
+		} else {
+			file_set_keep_isize(inode);
+		}
+	}
+
+	return err;
+}
+
 int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				struct bio **bio,
 				sector_t *last_block,
@@ -3935,6 +4178,176 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	return ret;
 }
 
+static int f2fs_write_cache_folios(struct address_space *mapping,
+				   struct writeback_control *wbc,
+				   enum iostat_type io_type)
+{
+	struct folio *folio = NULL;
+	struct inode *inode = mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_lock_context lc;
+	u64 pos = 0;
+	u64 end_pos = 0;
+	u32 r_len = 0;
+	int err = 0;
+	int submitted = 0;
+	int nwritten = 0;
+	bool op_locked = false;
+	bool next = false;
+	bool retry = false;
+
+	if (get_dirty_pages(inode) <= SM_I(sbi)->min_hot_blocks)
+		set_inode_flag(inode, FI_HOT_DATA);
+	else
+		clear_inode_flag(inode, FI_HOT_DATA);
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
+		struct f2fs_folio_state *ffs = NULL;
+		u64 isize;
+		size_t poff;
+		pgoff_t end_index;
+		bool verity_in_progress;
+		int folio_submitted = 0;
+		bool bias_added = false;
+
+		submitted = 0;
+		next = true;
+		retry = false;
+
+		if (err) {
+			folio_redirty_for_writepage(wbc, folio);
+			goto retry_out;
+		}
+
+		if (atomic_read(&sbi->wb_sync_req[DATA]) &&
+		    wbc->sync_mode == WB_SYNC_NONE) {
+			folio_redirty_for_writepage(wbc, folio);
+			next = false;
+			goto retry_out;
+		}
+retry:
+		pos = folio_pos(folio);
+		end_pos = pos + folio_size(folio);
+		isize = i_size_read(inode);
+		verity_in_progress = f2fs_verity_in_progress(inode);
+		poff = 0;
+		end_index = 0;
+
+		if (retry) {
+
+			if (unlikely(folio->mapping != mapping))
+				goto retry_out;
+
+			if (!folio_test_dirty(folio))
+				goto retry_out;
+
+			if (folio_test_writeback(folio)) {
+				if (wbc->sync_mode == WB_SYNC_NONE)
+					goto retry_out;
+				f2fs_folio_wait_writeback(folio, true, true);
+			}
+
+			if (!folio_clear_dirty_for_io(folio))
+				goto retry_out;
+		}
+
+		/* To avoid dealing with the complexity for one subrange is in bio
+		 * while we trylock_op failed before writing another subrange.
+		 * Try to lock_op before any subrange write for the folio.
+		 */
+		if (!op_locked) {
+			if (!f2fs_trylock_op(sbi, &lc)) {
+				folio_redirty_for_writepage(wbc, folio);
+				err = 0;
+				if (wbc->sync_mode != WB_SYNC_ALL)
+					goto retry_out;
+
+				retry = true;
+				folio_unlock(folio);
+				f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
+				folio_lock(folio);
+				goto retry;
+			}
+			op_locked = true;
+		}
+
+		if (!verity_in_progress) {
+			poff = offset_in_folio(folio, isize);
+			end_index = isize >> PAGE_SHIFT;
+
+			if (folio->index > end_index ||
+			    (folio->index == end_index && poff == 0))
+				goto out;
+
+			if (end_pos > isize) {
+				folio_zero_segment(folio, poff, folio_size(folio));
+				end_pos = isize;
+			}
+		}
+
+		folio_start_writeback(folio);
+
+		if (!bias_added && f2fs_folio_has_ffs(folio)) {
+			ffs = (struct f2fs_folio_state *)folio->private;
+			WARN_ON_ONCE(atomic_read(&ffs->write_pages_pending) != 0);
+			atomic_inc(&ffs->write_pages_pending);
+			bias_added = true;
+		}
+
+		while ((r_len = ffs_find_dirty_range(folio, &pos, end_pos))) {
+			err = f2fs_write_folio_dirty_range(folio, &submitted,
+					wbc, io_type, &pos, r_len);
+			folio_submitted += submitted;
+			if (err)
+				goto out;
+
+			nwritten += submitted;
+		}
+
+		if (!err && folio_submitted &&
+		    f2fs_is_atomic_file(inode) &&
+		    folio_test_f2fs_atomic(folio))
+			folio_clear_f2fs_atomic(folio);
+
+out:
+		/*
+		 * Clear the dirty state of the subranges that were written back.
+		 * If some subranges are still dirty (e.g. the folio was only
+		 * partially written back), the folio must stay dirty so that
+		 * the remaining subranges are written back later.
+		 */
+		if (f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
+					(err ? pos : end_pos) - folio_pos(folio)))
+			folio_redirty_for_writepage(wbc, folio);
+		else
+			inode_dec_dirty_pages(inode);
+
+		if (bias_added) {
+			if (atomic_dec_and_test(&ffs->write_pages_pending))
+				folio_end_writeback(folio);
+		} else if (!folio_submitted && folio_test_writeback(folio)) {
+			folio_end_writeback(folio);
+		}
+
+retry_out:
+		folio_unlock(folio);
+
+		if (op_locked) {
+			f2fs_unlock_op(sbi, &lc);
+			op_locked = false;
+		}
+
+		if (!next)
+			wbc->nr_to_write = 0;
+	}
+
+	if (nwritten)
+		f2fs_submit_merged_write_cond(F2FS_M_SB(mapping), mapping->host,
+					       NULL);
+
+	return err;
+}
+
 static inline bool __should_serialize_io(struct inode *inode,
 					struct writeback_control *wbc)
 {
@@ -4029,7 +4442,11 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	account_writeback(inode, true);
 
 	blk_start_plug(&plug);
-	ret = f2fs_write_cache_pages(mapping, wbc, io_type);
+	if (mapping_large_folio_support(inode->i_mapping) &&
+	    !f2fs_has_inline_data(inode))
+		ret = f2fs_write_cache_folios(mapping, wbc, io_type);
+	else
+		ret = f2fs_write_cache_pages(mapping, wbc, io_type);
 	blk_finish_plug(&plug);
 
 	account_writeback(inode, false);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
