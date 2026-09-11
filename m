Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163FFC88E4D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UOGIwkwlPn18znt7i5AC7cEQE/8oMtUQpuruLjJD4zw=; b=KgXjetVQ9sZRphs5xAgmWSC0qN
	b8Fq6V4cHNL2mjUwKNCMJoOUJgiE8YQmSjVUEK915WjbiZx8F0IJK6kHVAEyCxDcy7a8cyePQ4Ei0
	8goxvRrb5jM8Hn8phms1DG8c5DpmBHl/6utcAlq/2QPqopl2hMb1O+xNflseovjWLZ0o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x5Acz-0004nZ-UJ;
	Fri, 11 Sep 2026 23:25:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x5Acb-0004il-1d
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 23:25:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IfBhh/xD8RaIfcp1LCXY25svOTdhf9jZEQ4IuVy75DQ=; b=Q6c6SeeSKkQ4vWvQLDCpkT8tIu
 uVg+GrJFIx80pvObHdQijDlIoGGfd4r2mJ5qF2HJAt+FMHpq27PsyCFnYkNTS+F8ZLiXFeaQQ0aDG
 zj32b90UVH/g2d3V3TUJaPxfEyYM+bgJkbn8U+6gWKjHiMsVOIGYaMM9ERaSHC5Ejp3s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IfBhh/xD8RaIfcp1LCXY25svOTdhf9jZEQ4IuVy75DQ=; b=S
 vPBZtyyI5P5Wj/pm6VvIwBVWCt80UuoONhKDn36j6vcN3o6Yusoyioma6yeLuBOMyKycPFngEyCRN
 v942cNwF9a4IM8xs54xmFVLVpQ1fp/CRuy9MQScVl+8KfXCEp4U0IGLQ4WgSzZ4nO5jLjU09Th5tW
 teV/BxTorVMim/Js=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5AcU-0005VX-2N for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 23:25:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D7B8601EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 23:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1371F00893;
 Fri, 11 Sep 2026 23:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789169115;
 bh=IfBhh/xD8RaIfcp1LCXY25svOTdhf9jZEQ4IuVy75DQ=;
 h=From:To:Cc:Subject:Date;
 b=nv3xmiGM14WGC64CsygkcK1p9J/j+s50hd/c7H4jvA1mXp1V+BZuhm5cfr0SBPtbJ
 k84O9xjYVpR9+7nS26DwMwLocD88bs8AZYik1GwZTu+i65xrvx4wA8ux/op6rB+bN7
 RSofODGSx7n13ZqCsuOs0zE93Oouz7MTyzHolfUSod/t36vTEHbW3VnX6c+zmTTa/j
 p3Iwk7kPeDUWmTUlzsxqeceb4Yhkdl8UnQbC/iOjXv9pq7B7LjX7z0kQk03WpoU3Do
 VQ14RhdUyYemQn5FykbjIkO2U8sEe0kaMqmV5HHnTzA08143Ixw0Ua854wWwIt46Jx
 qQlm2IE1I6chQ==
To: jaegeuk@kernel.org
Date: Sat, 12 Sep 2026 07:25:09 +0800
Message-ID: <20260911232510.1816298-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
MIME-Version: 1.0
X-Headers-End: 1x5AcU-0005VX-2N
Subject: [f2fs-dev] [PATCH 1/2] f2fs: rename page_count with cache_count
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

From: Jaegeuk Kim <jaegeuk@kernel.org>

The count does not indicate the number of pages anymore.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/cache.c      |  4 ++--
 fs/f2fs/checkpoint.c | 30 ++++++++++++-------------
 fs/f2fs/compress.c   |  8 +++----
 fs/f2fs/data.c       | 32 +++++++++++++--------------
 fs/f2fs/debug.c      | 26 +++++++++++-----------
 fs/f2fs/f2fs.h       | 41 ++++++++++++++++++----------------
 fs/f2fs/file.c       | 14 ++++++------
 fs/f2fs/gc.c         | 14 ++++++------
 fs/f2fs/node.c       | 10 ++++-----
 fs/f2fs/segment.c    | 10 ++++-----
 fs/f2fs/segment.h    | 10 ++++-----
 fs/f2fs/super.c      | 52 ++++++++++++++++++++++----------------------
 12 files changed, 127 insertions(+), 124 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 33da3f243783..16b47dd559cb 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -78,7 +78,7 @@ bool f2fs_mark_cache_dirty(struct f2fs_cached_block *entry)
 				IS_META_CACHE(cache) ? META : NODE);
 		f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_NONE,
 						F2FS_CACHE_TAG_DIRTY);
-		inc_page_count(cache->sbi, type);
+		inc_cache_count(cache->sbi, type);
 		return true;
 	}
 
@@ -99,7 +99,7 @@ void f2fs_drop_cache_dirty(struct f2fs_cached_block *entry)
 
 	f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_DIRTY,
 					F2FS_CACHE_TAG_NONE);
-	dec_page_count(cache->sbi, type);
+	dec_cache_count(cache->sbi, type);
 }
 
 void f2fs_start_cache_writeback(struct f2fs_cached_block *entry)
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2542b1a29989..1ff9f241085a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -555,7 +555,7 @@ static bool __f2fs_write_meta_cache(struct f2fs_cached_block *entry,
 	if (unlikely(f2fs_cp_error(sbi))) {
 		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
 			f2fs_cache_clear_uptodate(entry);
-			dec_page_count(sbi, F2FS_DIRTY_META);
+			dec_cache_count(sbi, F2FS_DIRTY_META);
 			f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_DIRTY,
 						F2FS_CACHE_TAG_NONE);
 			f2fs_unlock_cache(entry);
@@ -567,7 +567,7 @@ static bool __f2fs_write_meta_cache(struct f2fs_cached_block *entry,
 		goto redirty_out;
 
 	f2fs_do_write_meta_cache(sbi, entry, io_type);
-	dec_page_count(sbi, F2FS_DIRTY_META);
+	dec_cache_count(sbi, F2FS_DIRTY_META);
 
 	f2fs_unlock_cache(entry);
 
@@ -590,7 +590,7 @@ void f2fs_write_meta_caches(struct f2fs_sb_info *sbi)
 		return;
 
 	/* collect a number of dirty meta caches and write together */
-	if (get_pages(sbi, F2FS_DIRTY_META) <
+	if (get_nr_caches(sbi, F2FS_DIRTY_META) <
 			nr_pages_to_skip(sbi, META))
 		return;
 
@@ -1359,12 +1359,12 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
 	unsigned long ino = 0;
 
 	trace_f2fs_sync_dirty_inodes_enter(sbi->sb, is_dir,
-				get_pages(sbi, is_dir ?
+				get_nr_caches(sbi, is_dir ?
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA));
 retry:
 	if (unlikely(f2fs_cp_error(sbi))) {
 		trace_f2fs_sync_dirty_inodes_exit(sbi->sb, is_dir,
-				get_pages(sbi, is_dir ?
+				get_nr_caches(sbi, is_dir ?
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA));
 		return -EIO;
 	}
@@ -1375,7 +1375,7 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
 	if (list_empty(head)) {
 		spin_unlock(&sbi->inode_lock[type]);
 		trace_f2fs_sync_dirty_inodes_exit(sbi->sb, is_dir,
-				get_pages(sbi, is_dir ?
+				get_nr_caches(sbi, is_dir ?
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA));
 		return 0;
 	}
@@ -1413,7 +1413,7 @@ static int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
 	struct list_head *head = &sbi->inode_list[DIRTY_META];
 	struct inode *inode;
 	struct f2fs_inode_info *fi;
-	s64 total = get_pages(sbi, F2FS_DIRTY_IMETA);
+	s64 total = get_nr_caches(sbi, F2FS_DIRTY_IMETA);
 
 	while (total--) {
 		if (unlikely(f2fs_cp_error(sbi)))
@@ -1477,7 +1477,7 @@ static bool __need_flush_quota(struct f2fs_sb_info *sbi)
 	} else if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH)) {
 		clear_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
 		ret = true;
-	} else if (get_pages(sbi, F2FS_DIRTY_QDATA)) {
+	} else if (get_nr_caches(sbi, F2FS_DIRTY_QDATA)) {
 		ret = true;
 	}
 	f2fs_up_write(&sbi->quota_sem);
@@ -1521,7 +1521,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 
 retry_flush_dents:
 	/* write all the dirty dentry pages */
-	if (get_pages(sbi, F2FS_DIRTY_DENTS)) {
+	if (get_nr_caches(sbi, F2FS_DIRTY_DENTS)) {
 		f2fs_unlock_all(sbi);
 		err = f2fs_sync_dirty_inodes(sbi, DIR_INODE, true);
 		if (err)
@@ -1536,7 +1536,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	 */
 	f2fs_down_write(&sbi->node_change);
 
-	if (get_pages(sbi, F2FS_DIRTY_IMETA)) {
+	if (get_nr_caches(sbi, F2FS_DIRTY_IMETA)) {
 		f2fs_up_write(&sbi->node_change);
 		f2fs_unlock_all(sbi);
 		err = f2fs_sync_inode_meta(sbi);
@@ -1549,7 +1549,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 retry_flush_nodes:
 	f2fs_down_write(&sbi->node_write);
 
-	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
+	if (get_nr_caches(sbi, F2FS_DIRTY_NODES)) {
 		f2fs_up_write(&sbi->node_write);
 		atomic_inc(&sbi->wb_sync_req[NODE]);
 		err = f2fs_writeback_node_caches(sbi, LONG_MAX,
@@ -1584,7 +1584,7 @@ void f2fs_sync_dirty_data(struct f2fs_sb_info *sbi, int type)
 	DEFINE_WAIT(wait);
 
 	for (;;) {
-		if (!get_pages(sbi, type))
+		if (!get_nr_caches(sbi, type))
 			break;
 
 		if (unlikely(f2fs_cp_error(sbi) &&
@@ -1906,11 +1906,11 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * redirty superblock if metadata like node page or inode cache is
 	 * updated during writing checkpoint.
 	 */
-	if (get_pages(sbi, F2FS_DIRTY_NODES) ||
-			get_pages(sbi, F2FS_DIRTY_IMETA))
+	if (get_nr_caches(sbi, F2FS_DIRTY_NODES) ||
+			get_nr_caches(sbi, F2FS_DIRTY_IMETA))
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
 
-	f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_DENTS));
+	f2fs_bug_on(sbi, get_nr_caches(sbi, F2FS_DIRTY_DENTS));
 
 	return unlikely(f2fs_cp_error(sbi)) ? -EIO : 0;
 }
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index b053fd188d3c..34b1983e7a90 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -807,7 +807,7 @@ void f2fs_end_read_compressed_page(struct folio *folio, bool failed,
 	struct decompress_io_ctx *dic = folio->private;
 	struct f2fs_sb_info *sbi = dic->sbi;
 
-	dec_page_count(sbi, F2FS_RD_DATA);
+	dec_cache_count(sbi, F2FS_RD_DATA);
 
 	if (failed)
 		WRITE_ONCE(dic->failed, true);
@@ -1471,7 +1471,7 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 	f2fs_compress_free_page(page);
 
 	if (atomic_dec_return(&cic->pending_pages)) {
-		dec_page_count(sbi, type);
+		dec_cache_count(sbi, type);
 		return;
 	}
 
@@ -1485,12 +1485,12 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 	kmem_cache_free(cic_entry_slab, cic);
 
 	/*
-	 * Make sure dec_page_count() is the last access to sbi.
+	 * Make sure dec_cache_count() is the last access to sbi.
 	 * Once it drops the F2FS_WB_CP_DATA counter to zero, the
 	 * unmount thread can proceed to destroy sbi and
 	 * sbi->page_array_slab.
 	 */
-	dec_page_count(sbi, type);
+	dec_cache_count(sbi, type);
 }
 
 static int f2fs_write_raw_pages(struct compress_ctx *cc,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9a1d31df5f4f..49fe48ae823d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -143,7 +143,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 		}
 
 		while (nr_pages--)
-			dec_page_count(F2FS_F_SB(folio), F2FS_RD_DATA);
+			dec_cache_count(F2FS_F_SB(folio), F2FS_RD_DATA);
 
 		if (finished)
 			folio_end_read(folio, bio->bi_status == BLK_STS_OK);
@@ -327,13 +327,13 @@ static void f2fs_write_end_bio(struct bio *bio)
 			}
 		}
 
-		dec_page_count(sbi, type);
+		dec_cache_count(sbi, type);
 
 		/*
 		 * we should access sbi before folio_end_writeback() to
 		 * avoid racing w/ kill_f2fs_super()
 		 */
-		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
+		if (type == F2FS_WB_CP_DATA && !get_nr_caches(sbi, type) &&
 				wq_has_sleeper(&sbi->cp_wait))
 			wake_up(&sbi->cp_wait);
 
@@ -396,7 +396,7 @@ static void f2fs_cache_read_end_io(struct bio *bio)
 		if (bio->bi_status == BLK_STS_OK)
 			f2fs_cache_set_uptodate(entry);
 
-		dec_page_count(sbi, io_type);
+		dec_cache_count(sbi, io_type);
 
 		f2fs_unlock_cache(entry);
 		entry = next;
@@ -431,9 +431,9 @@ static void f2fs_cache_write_end_io(struct bio *bio)
 		if (f2fs_in_warm_node_list(sbi, entry))
 			f2fs_del_fsync_node_entry(sbi, entry);
 
-		dec_page_count(sbi, F2FS_WB_CP_DATA);
+		dec_cache_count(sbi, F2FS_WB_CP_DATA);
 
-		if (!get_pages(sbi, F2FS_WB_CP_DATA) &&
+		if (!get_nr_caches(sbi, F2FS_WB_CP_DATA) &&
 				wq_has_sleeper(&sbi->cp_wait))
 			wake_up(&sbi->cp_wait);
 
@@ -874,7 +874,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	if (fio->io_wbc && !is_read_io(fio->op))
 		wbc_account_cgroup_owner(fio->io_wbc, fio_folio, PAGE_SIZE);
 
-	inc_page_count(fio->sbi, is_read_io(fio->op) ?
+	inc_cache_count(fio->sbi, is_read_io(fio->op) ?
 			F2FS_RD_DATA : WB_DATA_TYPE(fio->folio, false));
 
 	if (is_read_io(bio_op(bio)))
@@ -1107,7 +1107,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	if (fio->io_wbc)
 		wbc_account_cgroup_owner(fio->io_wbc, folio, folio_size(folio));
 
-	inc_page_count(fio->sbi, WB_DATA_TYPE(folio, false));
+	inc_cache_count(fio->sbi, WB_DATA_TYPE(folio, false));
 
 	*fio->last_block = fio->new_blkaddr;
 	*fio->bio = bio;
@@ -1205,7 +1205,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	fio->submitted = 1;
 
 	type = WB_DATA_TYPE(bio_folio, fio->compressed_page);
-	inc_page_count(sbi, type);
+	inc_cache_count(sbi, type);
 
 	if (io->bio &&
 	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
@@ -1273,7 +1273,7 @@ int f2fs_submit_cache_read(struct f2fs_io_info *fio)
 
 	bio_add_virt_nofail(bio, cache_address(entry), sbi->blocksize);
 	f2fs_bio_add_cache(fio, bio);
-	inc_page_count(sbi, io_type);
+	inc_cache_count(sbi, io_type);
 
 	f2fs_submit_read_bio(sbi, bio, fio->type);
 	return 0;
@@ -1309,7 +1309,7 @@ void f2fs_submit_cache_write(struct f2fs_io_info *fio)
 	verify_fio_blkaddr(fio);
 
 	fio->submitted = 1;
-	inc_page_count(sbi, F2FS_WB_CP_DATA);
+	inc_cache_count(sbi, F2FS_WB_CP_DATA);
 
 	if (io->bio &&
 	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
@@ -1409,7 +1409,7 @@ static void f2fs_submit_page_read(struct inode *inode, struct fsverity_info *vi,
 	if (!bio_add_folio(bio, folio, PAGE_SIZE, 0))
 		f2fs_bug_on(sbi, 1);
 
-	inc_page_count(sbi, F2FS_RD_DATA);
+	inc_cache_count(sbi, F2FS_RD_DATA);
 	f2fs_update_iostat(sbi, NULL, FS_DATA_READ_IO, F2FS_BLKSIZE(sbi));
 	f2fs_submit_read_bio(sbi, bio, DATA);
 }
@@ -2525,7 +2525,7 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 	if (!bio_add_folio(bio, folio, blocksize, 0))
 		goto submit_and_realloc;
 
-	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
+	inc_cache_count(F2FS_I_SB(inode), F2FS_RD_DATA);
 	f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
 					F2FS_BLKSIZE(F2FS_I_SB(inode)));
 	*last_block_in_bio = block_nr;
@@ -2677,7 +2677,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		ctx->enabled_steps |= STEP_DECOMPRESS;
 		refcount_inc(&dic->refcnt);
 
-		inc_page_count(sbi, F2FS_RD_DATA);
+		inc_cache_count(sbi, F2FS_RD_DATA);
 		f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO,
 				   F2FS_BLKSIZE(sbi));
 		*last_block_in_bio = blkaddr;
@@ -2858,7 +2858,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 			goto submit_and_realloc;
 
 		folio_in_bio = true;
-		inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
+		inc_cache_count(F2FS_I_SB(inode), F2FS_RD_DATA);
 		f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
 				F2FS_BLKSIZE(F2FS_I_SB(inode)));
 		last_block_in_bio = block_nr;
@@ -3774,7 +3774,7 @@ static inline void update_skipped_write(struct f2fs_sb_info *sbi,
 
 	if (is_sbi_flag_set(sbi, SBI_ENABLE_CHECKPOINT) && skipped &&
 		wbc->sync_mode == WB_SYNC_ALL)
-		atomic_add(skipped, &sbi->nr_pages[F2FS_SKIPPED_WRITE]);
+		atomic_add(skipped, &sbi->nr_caches[F2FS_SKIPPED_WRITE]);
 }
 
 static int __f2fs_write_data_pages(struct address_space *mapping,
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 8c0cffde2457..6fe606e2c70d 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -156,12 +156,12 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->allocated_data_blocks = atomic64_read(&sbi->allocated_data_blocks);
 
 	/* validation check of the segment numbers */
-	si->ndirty_node = get_pages(sbi, F2FS_DIRTY_NODES);
-	si->ndirty_dent = get_pages(sbi, F2FS_DIRTY_DENTS);
-	si->ndirty_meta = get_pages(sbi, F2FS_DIRTY_META);
-	si->ndirty_data = get_pages(sbi, F2FS_DIRTY_DATA);
-	si->ndirty_qdata = get_pages(sbi, F2FS_DIRTY_QDATA);
-	si->ndirty_imeta = get_pages(sbi, F2FS_DIRTY_IMETA);
+	si->ndirty_node = get_nr_caches(sbi, F2FS_DIRTY_NODES);
+	si->ndirty_dent = get_nr_caches(sbi, F2FS_DIRTY_DENTS);
+	si->ndirty_meta = get_nr_caches(sbi, F2FS_DIRTY_META);
+	si->ndirty_data = get_nr_caches(sbi, F2FS_DIRTY_DATA);
+	si->ndirty_qdata = get_nr_caches(sbi, F2FS_DIRTY_QDATA);
+	si->ndirty_imeta = get_nr_caches(sbi, F2FS_DIRTY_IMETA);
 	si->ndirty_dirs = sbi->ndirty_inode[DIR_INODE];
 	si->ndirty_files = sbi->ndirty_inode[FILE_INODE];
 	si->ndonate_files = sbi->donate_files;
@@ -169,13 +169,13 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
 	si->aw_cnt = atomic_read(&sbi->atomic_files);
 	si->max_aw_cnt = atomic_read(&sbi->max_aw_cnt);
-	si->nr_dio_read = get_pages(sbi, F2FS_DIO_READ);
-	si->nr_dio_write = get_pages(sbi, F2FS_DIO_WRITE);
-	si->nr_wb_cp_data = get_pages(sbi, F2FS_WB_CP_DATA);
-	si->nr_wb_data = get_pages(sbi, F2FS_WB_DATA);
-	si->nr_rd_data = get_pages(sbi, F2FS_RD_DATA);
-	si->nr_rd_node = get_pages(sbi, F2FS_RD_NODE);
-	si->nr_rd_meta = get_pages(sbi, F2FS_RD_META);
+	si->nr_dio_read = get_nr_caches(sbi, F2FS_DIO_READ);
+	si->nr_dio_write = get_nr_caches(sbi, F2FS_DIO_WRITE);
+	si->nr_wb_cp_data = get_nr_caches(sbi, F2FS_WB_CP_DATA);
+	si->nr_wb_data = get_nr_caches(sbi, F2FS_WB_DATA);
+	si->nr_rd_data = get_nr_caches(sbi, F2FS_RD_DATA);
+	si->nr_rd_node = get_nr_caches(sbi, F2FS_RD_NODE);
+	si->nr_rd_meta = get_nr_caches(sbi, F2FS_RD_META);
 	if (SM_I(sbi)->fcc_info) {
 		si->nr_flushed =
 			atomic_read(&SM_I(sbi)->fcc_info->issued_flush);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 34878d99a2f0..c5168d6b584f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1905,8 +1905,8 @@ struct f2fs_sb_info {
 	struct f2fs_rwsem quota_sem;		/* blocking cp for flags */
 	struct task_struct *umount_lock_holder;	/* s_umount lock holder */
 
-	/* # of pages, see count_type */
-	atomic_t nr_pages[NR_COUNT_TYPE];
+	/* # of cache entries, see count_type */
+	atomic_t nr_caches[NR_COUNT_TYPE];
 	/* # of allocated blocks */
 	struct percpu_counter alloc_valid_block_count;
 	/* # of node block writes as roll forward recovery */
@@ -2871,9 +2871,9 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 	f2fs_i_blocks_write(inode, count, false, true);
 }
 
-static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
+static inline void inc_cache_count(struct f2fs_sb_info *sbi, int count_type)
 {
-	atomic_inc(&sbi->nr_pages[count_type]);
+	atomic_inc(&sbi->nr_caches[count_type]);
 
 	if (count_type == F2FS_DIRTY_DENTS ||
 			count_type == F2FS_DIRTY_NODES ||
@@ -2886,15 +2886,15 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
 static inline void inode_inc_dirty_pages(struct inode *inode)
 {
 	atomic_inc(&F2FS_I(inode)->dirty_pages);
-	inc_page_count(F2FS_I_SB(inode), S_ISDIR(inode->i_mode) ?
+	inc_cache_count(F2FS_I_SB(inode), S_ISDIR(inode->i_mode) ?
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA);
 	if (IS_NOQUOTA(inode))
-		inc_page_count(F2FS_I_SB(inode), F2FS_DIRTY_QDATA);
+		inc_cache_count(F2FS_I_SB(inode), F2FS_DIRTY_QDATA);
 }
 
-static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
+static inline void dec_cache_count(struct f2fs_sb_info *sbi, int count_type)
 {
-	atomic_dec(&sbi->nr_pages[count_type]);
+	atomic_dec(&sbi->nr_caches[count_type]);
 }
 
 static inline void inode_dec_dirty_pages(struct inode *inode)
@@ -2904,10 +2904,10 @@ static inline void inode_dec_dirty_pages(struct inode *inode)
 		return;
 
 	atomic_dec(&F2FS_I(inode)->dirty_pages);
-	dec_page_count(F2FS_I_SB(inode), S_ISDIR(inode->i_mode) ?
+	dec_cache_count(F2FS_I_SB(inode), S_ISDIR(inode->i_mode) ?
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA);
 	if (IS_NOQUOTA(inode))
-		dec_page_count(F2FS_I_SB(inode), F2FS_DIRTY_QDATA);
+		dec_cache_count(F2FS_I_SB(inode), F2FS_DIRTY_QDATA);
 }
 
 static inline void inc_atomic_write_cnt(struct inode *inode)
@@ -2932,9 +2932,9 @@ static inline void release_atomic_write_cnt(struct inode *inode)
 	fi->atomic_write_cnt = 0;
 }
 
-static inline s64 get_pages(struct f2fs_sb_info *sbi, int count_type)
+static inline s64 get_nr_caches(struct f2fs_sb_info *sbi, int count_type)
 {
-	return atomic_read(&sbi->nr_pages[count_type]);
+	return atomic_read(&sbi->nr_caches[count_type]);
 }
 
 static inline int get_dirty_pages(struct inode *inode)
@@ -2944,7 +2944,7 @@ static inline int get_dirty_pages(struct inode *inode)
 
 static inline int get_blocktype_secs(struct f2fs_sb_info *sbi, int block_type)
 {
-	return div_u64(get_pages(sbi, block_type) + BLKS_PER_SEC(sbi) - 1,
+	return div_u64(get_nr_caches(sbi, block_type) + BLKS_PER_SEC(sbi) - 1,
 							BLKS_PER_SEC(sbi));
 }
 
@@ -3304,11 +3304,13 @@ static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
 
 static inline bool is_inflight_io(struct f2fs_sb_info *sbi, int type)
 {
-	if (get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_RD_NODE) ||
-		get_pages(sbi, F2FS_RD_META) || get_pages(sbi, F2FS_WB_DATA) ||
-		get_pages(sbi, F2FS_WB_CP_DATA) ||
-		get_pages(sbi, F2FS_DIO_READ) ||
-		get_pages(sbi, F2FS_DIO_WRITE))
+	if (get_nr_caches(sbi, F2FS_RD_DATA) ||
+	    get_nr_caches(sbi, F2FS_RD_NODE) ||
+	    get_nr_caches(sbi, F2FS_RD_META) ||
+	    get_nr_caches(sbi, F2FS_WB_DATA) ||
+	    get_nr_caches(sbi, F2FS_WB_CP_DATA) ||
+	    get_nr_caches(sbi, F2FS_DIO_READ) ||
+	    get_nr_caches(sbi, F2FS_DIO_WRITE))
 		return true;
 
 	if (type != DISCARD_TIME && SM_I(sbi) && SM_I(sbi)->dcc_info &&
@@ -3323,7 +3325,8 @@ static inline bool is_inflight_io(struct f2fs_sb_info *sbi, int type)
 
 static inline bool is_inflight_read_io(struct f2fs_sb_info *sbi)
 {
-	return get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_DIO_READ);
+	return get_nr_caches(sbi, F2FS_RD_DATA) ||
+	       get_nr_caches(sbi, F2FS_DIO_READ);
 }
 
 static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6f4287fe180d..ef4d218e694b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5177,7 +5177,7 @@ static int f2fs_dio_read_end_io(struct kiocb *iocb, ssize_t size, int error,
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(iocb->ki_filp));
 
-	dec_page_count(sbi, F2FS_DIO_READ);
+	dec_cache_count(sbi, F2FS_DIO_READ);
 	if (error)
 		return error;
 	f2fs_update_iostat(sbi, NULL, APP_DIRECT_READ_IO, size);
@@ -5235,13 +5235,13 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	 * the higher-level function iomap_dio_rw() in order to ensure that the
 	 * F2FS_DIO_READ counter will be decremented correctly in all cases.
 	 */
-	inc_page_count(sbi, F2FS_DIO_READ);
+	inc_cache_count(sbi, F2FS_DIO_READ);
 	dio = __iomap_dio_rw(iocb, to, &f2fs_iomap_ops,
 			     &f2fs_iomap_dio_read_ops, 0, NULL, 0);
 	if (IS_ERR_OR_NULL(dio)) {
 		ret = PTR_ERR_OR_ZERO(dio);
 		if (ret != -EIOCBQUEUED)
-			dec_page_count(sbi, F2FS_DIO_READ);
+			dec_cache_count(sbi, F2FS_DIO_READ);
 	} else {
 		ret = iomap_dio_complete(dio);
 	}
@@ -5294,7 +5294,7 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	/* In LFS mode, if there is inflight dio, wait for its completion */
 	if (f2fs_lfs_mode(F2FS_I_SB(inode)) &&
-	    get_pages(F2FS_I_SB(inode), F2FS_DIO_WRITE) &&
+	    get_nr_caches(F2FS_I_SB(inode), F2FS_DIO_WRITE) &&
 		(!f2fs_is_pinned_file(inode) || !dio))
 		inode_dio_wait(inode);
 
@@ -5460,7 +5460,7 @@ static int f2fs_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(iocb->ki_filp));
 
-	dec_page_count(sbi, F2FS_DIO_WRITE);
+	dec_cache_count(sbi, F2FS_DIO_WRITE);
 	if (error)
 		return error;
 	f2fs_update_time(sbi, REQ_TIME);
@@ -5571,7 +5571,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	 * the higher-level function iomap_dio_rw() in order to ensure that the
 	 * F2FS_DIO_WRITE counter will be decremented correctly in all cases.
 	 */
-	inc_page_count(sbi, F2FS_DIO_WRITE);
+	inc_cache_count(sbi, F2FS_DIO_WRITE);
 	dio_flags = 0;
 	if (pos + count > inode->i_size)
 		dio_flags |= IOMAP_DIO_FORCE_WAIT;
@@ -5582,7 +5582,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		if (ret == -ENOTBLK)
 			ret = 0;
 		if (ret != -EIOCBQUEUED)
-			dec_page_count(sbi, F2FS_DIO_WRITE);
+			dec_cache_count(sbi, F2FS_DIO_WRITE);
 	} else {
 		ret = iomap_dio_complete(dio);
 	}
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a35d15b97d5b..926e6976bc22 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1473,7 +1473,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 
 	f2fs_mark_cache_dirty(tentry);
 	if (f2fs_cache_test_and_clear_dirty(tentry))
-		dec_page_count(fio.sbi, F2FS_DIRTY_META);
+		dec_cache_count(fio.sbi, F2FS_DIRTY_META);
 
 	f2fs_start_cache_writeback(tentry);
 
@@ -1979,9 +1979,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 
 	trace_f2fs_gc_begin(sbi->sb, gc_type, gc_control->no_bg_gc,
 				gc_control->nr_free_secs,
-				get_pages(sbi, F2FS_DIRTY_NODES),
-				get_pages(sbi, F2FS_DIRTY_DENTS),
-				get_pages(sbi, F2FS_DIRTY_IMETA),
+				get_nr_caches(sbi, F2FS_DIRTY_NODES),
+				get_nr_caches(sbi, F2FS_DIRTY_DENTS),
+				get_nr_caches(sbi, F2FS_DIRTY_IMETA),
 				free_sections(sbi),
 				free_segments(sbi),
 				reserved_segments(sbi),
@@ -2105,9 +2105,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		f2fs_unpin_all_sections(sbi, true);
 
 	trace_f2fs_gc_end(sbi->sb, ret, total_freed, total_sec_freed,
-				get_pages(sbi, F2FS_DIRTY_NODES),
-				get_pages(sbi, F2FS_DIRTY_DENTS),
-				get_pages(sbi, F2FS_DIRTY_IMETA),
+				get_nr_caches(sbi, F2FS_DIRTY_NODES),
+				get_nr_caches(sbi, F2FS_DIRTY_DENTS),
+				get_nr_caches(sbi, F2FS_DIRTY_IMETA),
 				free_sections(sbi),
 				free_segments(sbi),
 				reserved_segments(sbi),
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fe5e4c4eff23..a185b794b7b5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -85,7 +85,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 	} else if (type == DIRTY_DENTS) {
 		if (bdi_wb_dirty_exceeded(sbi->sb->s_bdi))
 			return false;
-		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
+		mem_size = get_nr_caches(sbi, F2FS_DIRTY_DENTS);
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
 	} else if (type == INO_ENTRIES) {
 		int i;
@@ -1771,7 +1771,7 @@ static bool __write_node_cache(struct f2fs_cached_block *entry,
 		f2fs_cache_clear_uptodate(entry);
 		f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_DIRTY,
 					F2FS_CACHE_TAG_NONE);
-		dec_page_count(entry->cache->sbi, F2FS_DIRTY_NODES);
+		dec_cache_count(entry->cache->sbi, F2FS_DIRTY_NODES);
 		f2fs_unlock_cache(entry);
 		return true;
 	}
@@ -1803,7 +1803,7 @@ static bool __write_node_cache(struct f2fs_cached_block *entry,
 		f2fs_cache_clear_uptodate(entry);
 		f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_DIRTY,
 					F2FS_CACHE_TAG_NONE);
-		dec_page_count(entry->cache->sbi, F2FS_DIRTY_NODES);
+		dec_cache_count(entry->cache->sbi, F2FS_DIRTY_NODES);
 		f2fs_up_read_trace(&sbi->node_write, &lc);
 		f2fs_unlock_cache(entry);
 		return true;
@@ -1837,7 +1837,7 @@ static bool __write_node_cache(struct f2fs_cached_block *entry,
 	fio.old_blkaddr = ni.blk_addr;
 	f2fs_do_write_node_cache(nid, &fio);
 	set_node_addr(sbi, &ni, fio.new_blkaddr, is_fsync_dnode(sbi, entry));
-	dec_page_count(sbi, F2FS_DIRTY_NODES);
+	dec_cache_count(sbi, F2FS_DIRTY_NODES);
 	f2fs_up_read_trace(&sbi->node_write, &lc);
 
 	f2fs_unlock_cache(entry);
@@ -2269,7 +2269,7 @@ int f2fs_write_node_caches(struct f2fs_sb_info *sbi)
 	f2fs_balance_fs_bg(sbi, true);
 
 	/* collect a number of dirty node caches and write together */
-	if (get_pages(sbi, F2FS_DIRTY_NODES) <
+	if (get_nr_caches(sbi, F2FS_DIRTY_NODES) <
 					nr_pages_to_skip(sbi, NODE))
 		return -EAGAIN;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 15cffbb5b407..794e0d99fc7c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -479,11 +479,11 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 static inline bool excess_dirty_threshold(struct f2fs_sb_info *sbi)
 {
 	int factor = f2fs_rwsem_is_locked(&sbi->cp_rwsem) ? 3 : 2;
-	unsigned int dents = get_pages(sbi, F2FS_DIRTY_DENTS);
-	unsigned int qdata = get_pages(sbi, F2FS_DIRTY_QDATA);
-	unsigned int nodes = get_pages(sbi, F2FS_DIRTY_NODES);
-	unsigned int meta = get_pages(sbi, F2FS_DIRTY_META);
-	unsigned int imeta = get_pages(sbi, F2FS_DIRTY_IMETA);
+	unsigned int dents = get_nr_caches(sbi, F2FS_DIRTY_DENTS);
+	unsigned int qdata = get_nr_caches(sbi, F2FS_DIRTY_QDATA);
+	unsigned int nodes = get_nr_caches(sbi, F2FS_DIRTY_NODES);
+	unsigned int meta = get_nr_caches(sbi, F2FS_DIRTY_META);
+	unsigned int imeta = get_nr_caches(sbi, F2FS_DIRTY_IMETA);
 	unsigned int threshold =
 		SEGS_TO_BLKS(sbi, (factor * DEFAULT_DIRTY_THRESHOLD));
 	unsigned int global_threshold = threshold * 3 / 2;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b11461acc520..b77fc79907f8 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -656,15 +656,15 @@ static inline void get_additional_blocks_required(struct f2fs_sb_info *sbi,
  */
 static inline int __get_secs_required(struct f2fs_sb_info *sbi)
 {
-	unsigned int total_node_blocks = get_pages(sbi, F2FS_DIRTY_NODES) +
-					get_pages(sbi, F2FS_DIRTY_DENTS) +
-					get_pages(sbi, F2FS_DIRTY_IMETA);
-	unsigned int total_dent_blocks = get_pages(sbi, F2FS_DIRTY_DENTS);
+	unsigned int total_node_blocks = get_nr_caches(sbi, F2FS_DIRTY_NODES) +
+					get_nr_caches(sbi, F2FS_DIRTY_DENTS) +
+					get_nr_caches(sbi, F2FS_DIRTY_IMETA);
+	unsigned int total_dent_blocks = get_nr_caches(sbi, F2FS_DIRTY_DENTS);
 	unsigned int total_data_blocks = 0;
 	bool separate_dent = true;
 
 	if (f2fs_lfs_mode(sbi))
-		total_data_blocks = get_pages(sbi, F2FS_DIRTY_DATA);
+		total_data_blocks = get_nr_caches(sbi, F2FS_DIRTY_DATA);
 
 	/*
 	 * When active_logs != 4, dentry blocks and data blocks can be
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9f6a6a6ebaff..f9f005755acd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1930,7 +1930,7 @@ int f2fs_inode_dirtied(struct inode *inode, bool sync)
 	if (sync && list_empty(&F2FS_I(inode)->gdirty_list)) {
 		list_add_tail(&F2FS_I(inode)->gdirty_list,
 				&sbi->inode_list[DIRTY_META]);
-		inc_page_count(sbi, F2FS_DIRTY_IMETA);
+		inc_cache_count(sbi, F2FS_DIRTY_IMETA);
 	}
 	spin_unlock(&sbi->inode_lock[DIRTY_META]);
 
@@ -1953,7 +1953,7 @@ void f2fs_inode_synced(struct inode *inode)
 	}
 	if (!list_empty(&F2FS_I(inode)->gdirty_list)) {
 		list_del_init(&F2FS_I(inode)->gdirty_list);
-		dec_page_count(sbi, F2FS_DIRTY_IMETA);
+		dec_cache_count(sbi, F2FS_DIRTY_IMETA);
 	}
 	clear_inode_flag(inode, FI_DIRTY_INODE);
 	clear_inode_flag(inode, FI_AUTO_RECOVER);
@@ -2075,11 +2075,11 @@ static void f2fs_put_super(struct super_block *sb)
 
 	/* Should check the page counts after dropping all node/meta pages */
 	for (i = 0; i < NR_COUNT_TYPE; i++) {
-		if (!get_pages(sbi, i))
+		if (!get_nr_caches(sbi, i))
 			continue;
 		f2fs_err(sbi, "detect filesystem reference count leak during "
 			"umount, type: %d, count: %lld, err: %d, cp_err: %d",
-			i, get_pages(sbi, i), err, f2fs_cp_error(sbi));
+			i, get_nr_caches(sbi, i), err, f2fs_cp_error(sbi));
 		f2fs_bug_on(sbi, 1);
 	}
 
@@ -2693,9 +2693,9 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 	f2fs_info(sbi, "%s: call sync_filesystem() to persist meta: %lld, node: %lld, data: %lld",
 			__func__,
-			get_pages(sbi, F2FS_DIRTY_META),
-			get_pages(sbi, F2FS_DIRTY_NODES),
-			get_pages(sbi, F2FS_DIRTY_DATA));
+			get_nr_caches(sbi, F2FS_DIRTY_META),
+			get_nr_caches(sbi, F2FS_DIRTY_NODES),
+			get_nr_caches(sbi, F2FS_DIRTY_DATA));
 
 	ret = sync_filesystem(sbi->sb);
 	if (ret || err) {
@@ -2712,9 +2712,9 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 skip_gc:
 	f2fs_info(sbi, "%s: call f2fs_write_checkpoint(), meta: %lld, node: %lld, data: %lld",
 			__func__,
-			get_pages(sbi, F2FS_DIRTY_META),
-			get_pages(sbi, F2FS_DIRTY_NODES),
-			get_pages(sbi, F2FS_DIRTY_DATA));
+			get_nr_caches(sbi, F2FS_DIRTY_META),
+			get_nr_caches(sbi, F2FS_DIRTY_NODES),
+			get_nr_caches(sbi, F2FS_DIRTY_DATA));
 
 	f2fs_down_write_trace(&sbi->gc_lock, &lc);
 	cpc.reason = CP_PAUSE;
@@ -2746,9 +2746,9 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	long long skipped_write, dirty_data;
 
 	f2fs_info(sbi, "f2fs_enable_checkpoint() starts, meta: %lld, node: %lld, data: %lld",
-					get_pages(sbi, F2FS_DIRTY_META),
-					get_pages(sbi, F2FS_DIRTY_NODES),
-					get_pages(sbi, F2FS_DIRTY_DATA));
+					get_nr_caches(sbi, F2FS_DIRTY_META),
+					get_nr_caches(sbi, F2FS_DIRTY_NODES),
+					get_nr_caches(sbi, F2FS_DIRTY_DATA));
 
 	start = ktime_get();
 
@@ -2756,26 +2756,26 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 
 	/* we should flush all the data to keep data consistency */
 	do {
-		skipped_write = get_pages(sbi, F2FS_SKIPPED_WRITE);
-		dirty_data = get_pages(sbi, F2FS_DIRTY_DATA);
+		skipped_write = get_nr_caches(sbi, F2FS_SKIPPED_WRITE);
+		dirty_data = get_nr_caches(sbi, F2FS_DIRTY_DATA);
 
 		sync_inodes_sb(sbi->sb);
 		f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 
 		f2fs_info(sbi, "sync_inode_sb done, dirty_data: %lld, %lld, "
 				"skipped write: %lld, %lld, retry: %d",
-				get_pages(sbi, F2FS_DIRTY_DATA),
+				get_nr_caches(sbi, F2FS_DIRTY_DATA),
 				dirty_data,
-				get_pages(sbi, F2FS_SKIPPED_WRITE),
+				get_nr_caches(sbi, F2FS_SKIPPED_WRITE),
 				skipped_write, retry);
 
 		/*
 		 * sync_inodes_sb() has retry logic, so let's check dirty_data
 		 * in prior to skipped_write in case there is no dirty data.
 		 */
-		if (!get_pages(sbi, F2FS_DIRTY_DATA))
+		if (!get_nr_caches(sbi, F2FS_DIRTY_DATA))
 			break;
-		if (get_pages(sbi, F2FS_SKIPPED_WRITE) == skipped_write)
+		if (get_nr_caches(sbi, F2FS_SKIPPED_WRITE) == skipped_write)
 			break;
 	} while (retry--);
 
@@ -2783,14 +2783,14 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 
 	writeback = ktime_get();
 
-	if (unlikely(get_pages(sbi, F2FS_DIRTY_DATA) ||
-			get_pages(sbi, F2FS_SKIPPED_WRITE)))
+	if (unlikely(get_nr_caches(sbi, F2FS_DIRTY_DATA) ||
+			get_nr_caches(sbi, F2FS_SKIPPED_WRITE)))
 		f2fs_warn(sbi, "checkpoint=enable unwritten data: %lld, skipped data: %lld, retry: %d",
-				get_pages(sbi, F2FS_DIRTY_DATA),
-				get_pages(sbi, F2FS_SKIPPED_WRITE), retry);
+				get_nr_caches(sbi, F2FS_DIRTY_DATA),
+				get_nr_caches(sbi, F2FS_SKIPPED_WRITE), retry);
 
-	if (get_pages(sbi, F2FS_SKIPPED_WRITE))
-		atomic_set(&sbi->nr_pages[F2FS_SKIPPED_WRITE], 0);
+	if (get_nr_caches(sbi, F2FS_SKIPPED_WRITE))
+		atomic_set(&sbi->nr_caches[F2FS_SKIPPED_WRITE], 0);
 
 	f2fs_down_write_trace(&sbi->gc_lock, &lc);
 	f2fs_dirty_to_prefree(sbi);
@@ -4465,7 +4465,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	clear_sbi_flag(sbi, SBI_NEED_FSCK);
 
 	for (i = 0; i < NR_COUNT_TYPE; i++)
-		atomic_set(&sbi->nr_pages[i], 0);
+		atomic_set(&sbi->nr_caches[i], 0);
 
 	for (i = 0; i < META; i++)
 		atomic_set(&sbi->wb_sync_req[i], 0);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
