Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29F2C79FB6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vIuKoWnDzkooxeicnXfK6pQ/Fy/H7WMbLoh+RfOiY2g=; b=XpXb1K52jDmshu7E7KmfCPsi2g
	nEoRtNb3CY6+CqvpXhD7f9DMx4AA8Y2wEUCw+i5G1HRC/QB38EzDqwkFqcE1twkuaGHZXRHDN+/Pz
	VxeFe/+PlhkyQ+MCYjGM9vXEgXRxwc9Aiv0SGLFjRfj5C5oJDaCCBdTljNvZPMAoz/eA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x47FF-0002t0-Q2;
	Wed, 09 Sep 2026 01:37:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x47FD-0002rN-RC
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 01:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IjKYiSMVj8orNdCIN8nsFTuCcOfck1h9kUxhYvmkIIc=; b=c81Q1kSFv/PW/gq6w5gfOCJJnA
 MVN0Ex9a+1OZ2ZHB3T1812bED+doUCbd8VJjDhyS/bMnqdFPLqdJkZZyr1EXEXG7K579YbHJx8a1e
 QWDkjFfCHnWrmoiUSFWgRrMA7Ayqsz46F0x6+DzhRrjvqqX8q6KPOUXY/97oMo2aGNOM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IjKYiSMVj8orNdCIN8nsFTuCcOfck1h9kUxhYvmkIIc=; b=Qjitm8eEbhtR5DFm1bhXJy/wRT
 UqoCW1i7jJ5TRplC691Kg9AKWrtbBxoUZWqhPa1K/uEUEIUNcwiPnnh2/+9v6qGn5/lYPI2gDKHnf
 m8lUC03nPk634MIsvDASOqi17SZJVl1qvlM0a1SicWc6bA3AFfrrl+Id/IImNrYZsNjs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x47Ey-0006xO-1k for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 01:36:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D0F160207
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  9 Sep 2026 01:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B191F00A3D;
 Wed,  9 Sep 2026 01:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788917797;
 bh=IjKYiSMVj8orNdCIN8nsFTuCcOfck1h9kUxhYvmkIIc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iuGY0UQruDiGPx6S7wJVUgbZTUBDV7IFqc0C6cywTa4ltYWrAx9HPE1PJm3DwG0Vp
 2sgzf6BqYKw/AcuKYhX2ouxI9p+QPmhRYOQpqgkPgBfHGYg/nWh/0wz5mDoPBqGEzT
 VLi5xhHRsNfkuR0SkQCfzKIUi1UslirwTCQ45DrD/0H2tpjcJtX6TwLhDRj7z9NZhZ
 XwTGKbifFGArXegVHK5n5TcHzB8Dcnxezvsr1WYVlUpkna96125NAyHMtXfunFK1rP
 MEFjD2rFOSjCYb+UuvZMSsOYFjsZJSvcv53eXyyhDI9DI2U7IyuFPKD9lOFTI7uDb+
 rAWtcGA72dF3w==
To: jaegeuk@kernel.org
Date: Wed,  9 Sep 2026 09:36:04 +0800
Message-ID: <20260909013611.3418568-6-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260909013611.3418568-1-chao@kernel.org>
References: <20260909013611.3418568-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x47Ey-0006xO-1k
Subject: [f2fs-dev] [PATCH v6 05/12] f2fs: cache: use meta cache
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

From: Chao Yu <chao@kernel.org>

This patch migrates F2FS meta block caching from the fake VFS inode
page cache (sbi->meta_inode) to meta cache (sbi->meta_blocks).

It converts CP, SIT, NAT, SSA, recovery, and GC metadata I/O paths to
operate on struct f2fs_cached_block instead of folio, and removes
sbi->meta_inode.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c         |   2 +
 fs/f2fs/cache.h         |   2 +-
 fs/f2fs/checkpoint.c    | 388 ++++++++++++++++++----------------------
 fs/f2fs/compress.c      |   4 +-
 fs/f2fs/data.c          |  14 +-
 fs/f2fs/debug.c         |  12 +-
 fs/f2fs/f2fs.h          |  82 +++------
 fs/f2fs/file.c          |   4 +-
 fs/f2fs/gc.c            | 135 +++++++-------
 fs/f2fs/inline.c        |   9 +-
 fs/f2fs/inode.c         |   9 +-
 fs/f2fs/node.c          | 125 +++++++------
 fs/f2fs/recovery.c      | 196 ++++++++++----------
 fs/f2fs/segment.c       | 201 +++++++++++----------
 fs/f2fs/segment.h       |  29 ++-
 fs/f2fs/super.c         |  31 +---
 include/linux/f2fs_fs.h |   1 -
 17 files changed, 591 insertions(+), 653 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 7faedcab11f5..772fe0ad0f90 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -641,6 +641,8 @@ static int f2fs_cache_writeback_kthread(void *data)
 			break;
 		if (f2fs_cp_error(sbi))
 			continue;
+
+		f2fs_write_meta_caches(sbi);
 	}
 	return 0;
 }
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 0786d375b159..57c6147c82da 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -199,7 +199,7 @@ void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
 #define META_CACHE(sbi)		(&(sbi)->meta_blocks)
 
 #define f2fs_find_meta_cache(sbi, blkaddr)		\
-	f2fs_find_cache(META_CACHE(sbi), blkaddr)
+	f2fs_find_cache(META_CACHE(sbi), blkaddr, 0)
 #define f2fs_invalidate_meta_caches(sbi, start, len)	\
 	f2fs_drop_cache_range(META_CACHE(sbi), start, len, false)
 #define f2fs_truncate_meta_caches(sbi, start, len)	\
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 712c4508f38c..c70d7b03f96e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -17,6 +17,7 @@
 #include <linux/delayacct.h>
 #include <linux/ioprio.h>
 #include <linux/math64.h>
+#include <linux/freezer.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -236,27 +237,27 @@ struct kmem_cache *f2fs_inode_entry_slab;
 /*
  * We guarantee no failure on the returned page.
  */
-struct folio *f2fs_grab_meta_folio(struct f2fs_sb_info *sbi, pgoff_t index)
+struct f2fs_cached_block *f2fs_grab_meta_cache(struct f2fs_sb_info *sbi,
+							pgoff_t index)
 {
-	struct address_space *mapping = META_MAPPING(sbi);
-	struct folio *folio;
+	struct f2fs_cached_block *entry;
 repeat:
-	folio = f2fs_grab_cache_folio(mapping, index, false);
-	if (IS_ERR(folio)) {
+	entry = f2fs_grab_cache(META_CACHE(sbi), index,
+					F2FS_CACHE_LOCK_CREATE);
+	if (IS_ERR(entry)) {
 		cond_resched();
 		goto repeat;
 	}
-	f2fs_folio_wait_writeback(folio, META, true, true);
-	if (!folio_test_uptodate(folio))
-		folio_mark_uptodate(folio);
-	return folio;
+	f2fs_cache_wait_writeback(entry);
+	if (!f2fs_cache_test_uptodate(entry))
+		f2fs_cache_set_uptodate(entry);
+	return entry;
 }
 
-static struct folio *__get_meta_folio(struct f2fs_sb_info *sbi, pgoff_t index,
-							bool is_meta)
+static struct f2fs_cached_block *__get_meta_cache(struct f2fs_sb_info *sbi,
+					pgoff_t index, bool is_meta)
 {
-	struct address_space *mapping = META_MAPPING(sbi);
-	struct folio *folio;
+	struct f2fs_cached_block *entry;
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
 		.type = META,
@@ -266,70 +267,75 @@ static struct folio *__get_meta_folio(struct f2fs_sb_info *sbi, pgoff_t index,
 		.new_blkaddr = index,
 		.encrypted_page = NULL,
 		.is_por = !is_meta ? 1 : 0,
+		.is_cache = 1,
 	};
 	int err;
 
 	if (unlikely(!is_meta))
 		fio.op_flags &= ~REQ_META;
 repeat:
-	folio = f2fs_grab_cache_folio(mapping, index, false);
-	if (IS_ERR(folio)) {
+	entry = f2fs_grab_cache(META_CACHE(sbi), index,
+					F2FS_CACHE_LOCK_CREATE);
+	if (IS_ERR(entry)) {
 		cond_resched();
 		goto repeat;
 	}
-	if (folio_test_uptodate(folio))
+	if (f2fs_cache_test_uptodate(entry))
 		goto out;
 
-	fio.folio = folio;
+	fio.cache_entry = entry;
 
-	err = f2fs_submit_page_bio(&fio);
+	err = f2fs_submit_cache_read(&fio);
 	if (err) {
-		f2fs_folio_put(folio, true);
+		f2fs_put_cache(entry, true);
 		return ERR_PTR(err);
 	}
 
 	f2fs_update_iostat(sbi, NULL, FS_META_READ_IO, F2FS_BLKSIZE(sbi));
 
-	folio_lock(folio);
-	if (unlikely(!is_meta_folio(folio))) {
-		f2fs_folio_put(folio, true);
+	f2fs_lock_cache(entry);
+	if (unlikely(!f2fs_is_meta_cache(entry))) {
+		f2fs_put_cache(entry, true);
 		goto repeat;
 	}
 
-	if (unlikely(!folio_test_uptodate(folio))) {
-		f2fs_handle_page_eio(sbi, folio, META);
-		f2fs_folio_put(folio, true);
+	if (unlikely(!f2fs_cache_test_uptodate(entry))) {
+		f2fs_handle_page_eio(sbi, entry->index, META);
+		f2fs_put_cache(entry, true);
 		return ERR_PTR(-EIO);
 	}
 out:
-	return folio;
+	return entry;
 }
 
-struct folio *f2fs_get_meta_folio(struct f2fs_sb_info *sbi, pgoff_t index)
+struct f2fs_cached_block *f2fs_get_meta_cache(struct f2fs_sb_info *sbi,
+							pgoff_t index)
 {
-	return __get_meta_folio(sbi, index, true);
+	return __get_meta_cache(sbi, index, true);
 }
 
-struct folio *f2fs_get_meta_folio_retry(struct f2fs_sb_info *sbi, pgoff_t index)
+struct f2fs_cached_block *f2fs_get_meta_cache_retry(struct f2fs_sb_info *sbi,
+							pgoff_t index)
 {
-	struct folio *folio;
+	struct f2fs_cached_block *entry;
 	int count = 0;
 
 retry:
-	folio = __get_meta_folio(sbi, index, true);
-	if (IS_ERR(folio)) {
-		if (PTR_ERR(folio) == -EIO &&
+	entry = __get_meta_cache(sbi, index, true);
+	if (IS_ERR(entry)) {
+		if (PTR_ERR(entry) == -EIO &&
 				++count <= DEFAULT_RETRY_IO_COUNT)
 			goto retry;
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_META_PAGE);
 	}
-	return folio;
+	return entry;
 }
 
 /* for POR only */
-struct folio *f2fs_get_tmp_folio(struct f2fs_sb_info *sbi, pgoff_t index)
+struct f2fs_cached_block *f2fs_get_tmp_cache(struct f2fs_sb_info *sbi,
+							pgoff_t index)
 {
-	return __get_meta_folio(sbi, index, false);
+	return __get_meta_cache(sbi, index, false);
 }
 
 static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
@@ -447,9 +453,10 @@ bool f2fs_is_valid_blkaddr_raw(struct f2fs_sb_info *sbi,
 /*
  * Readahead CP/NAT/SIT/SSA/POR pages
  */
-int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
-							int type, bool sync)
+int f2fs_ra_meta_caches(struct f2fs_sb_info *sbi, block_t start,
+				int nrpages, int type, bool sync)
 {
+	struct f2fs_cached_block_list *cache = META_CACHE(sbi);
 	block_t blkno = start;
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
@@ -459,6 +466,7 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		.encrypted_page = NULL,
 		.in_list = 0,
 		.is_por = (type == META_POR) ? 1 : 0,
+		.is_cache = 1,
 	};
 	struct blk_plug plug;
 	int err;
@@ -468,7 +476,7 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 
 	blk_start_plug(&plug);
 	for (; nrpages-- > 0; blkno++) {
-		struct folio *folio;
+		struct f2fs_cached_block *entry;
 
 		if (!f2fs_is_valid_blkaddr(sbi, blkno, type))
 			goto out;
@@ -495,21 +503,21 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 			fio.new_blkaddr = blkno;
 			break;
 		default:
-			BUG();
+			f2fs_bug_on(sbi, 1);
 		}
 
-		folio = f2fs_grab_cache_folio(META_MAPPING(sbi),
-						fio.new_blkaddr, false);
-		if (IS_ERR(folio))
+		entry = f2fs_grab_cache(cache, fio.new_blkaddr,
+						F2FS_CACHE_LOCK_CREATE);
+		if (IS_ERR(entry))
 			continue;
-		if (folio_test_uptodate(folio)) {
-			f2fs_folio_put(folio, true);
+		if (f2fs_cache_test_uptodate(entry)) {
+			f2fs_put_cache(entry, true);
 			continue;
 		}
 
-		fio.folio = folio;
-		err = f2fs_submit_page_bio(&fio);
-		f2fs_folio_put(folio, err ? true : false);
+		fio.cache_entry = entry;
+		err = f2fs_submit_cache_read(&fio);
+		f2fs_put_cache(entry, err ? true : false);
 
 		if (!err)
 			f2fs_update_iostat(sbi, NULL, FS_META_READ_IO,
@@ -520,37 +528,36 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 	return blkno - start;
 }
 
-void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index,
-							unsigned int ra_blocks)
+void f2fs_ra_meta_caches_cond(struct f2fs_sb_info *sbi, pgoff_t index,
+						unsigned int ra_blocks)
 {
-	struct folio *folio;
+	struct f2fs_cached_block *entry;
 	bool readahead = false;
 
 	if (ra_blocks == RECOVERY_MIN_RA_BLOCKS)
 		return;
 
-	folio = filemap_get_folio(META_MAPPING(sbi), index);
-	if (IS_ERR(folio) || !folio_test_uptodate(folio))
+	entry = f2fs_find_cache(META_CACHE(sbi), index, 0);
+	if (IS_ERR(entry) || !f2fs_cache_test_uptodate(entry))
 		readahead = true;
-	f2fs_folio_put(folio, false);
+	f2fs_put_cache(entry, false);
 
 	if (readahead)
-		f2fs_ra_meta_pages(sbi, index, ra_blocks, META_POR, true);
+		f2fs_ra_meta_caches(sbi, index, ra_blocks, META_POR, true);
 }
 
-static bool __f2fs_write_meta_folio(struct folio *folio,
-				struct writeback_control *wbc,
+static bool __f2fs_write_meta_cache(struct f2fs_cached_block *entry,
 				enum iostat_type io_type)
 {
-	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
-
-	trace_f2fs_writepage(folio, META);
+	struct f2fs_sb_info *sbi = entry->cache->sbi;
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
-			folio_clear_uptodate(folio);
+			f2fs_cache_clear_uptodate(entry);
 			dec_page_count(sbi, F2FS_DIRTY_META);
-			folio_unlock(folio);
+			f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_DIRTY,
+						F2FS_CACHE_TAG_NONE);
+			f2fs_unlock_cache(entry);
 			return true;
 		}
 		goto redirty_out;
@@ -558,10 +565,10 @@ static bool __f2fs_write_meta_folio(struct folio *folio,
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
 
-	f2fs_do_write_meta_page(sbi, folio, io_type);
+	f2fs_do_write_meta_cache(sbi, entry, io_type);
 	dec_page_count(sbi, F2FS_DIRTY_META);
 
-	folio_unlock(folio);
+	f2fs_unlock_cache(entry);
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		f2fs_submit_merged_write(sbi, META);
@@ -569,101 +576,89 @@ static bool __f2fs_write_meta_folio(struct folio *folio,
 	return true;
 
 redirty_out:
-	folio_redirty_for_writepage(wbc, folio);
+	f2fs_cache_set_dirty(entry);
 	return false;
 }
 
-static int f2fs_write_meta_pages(struct address_space *mapping,
-				struct writeback_control *wbc)
+void f2fs_write_meta_caches(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
 	struct f2fs_lock_context lc;
-	long diff, written;
+	long nr_to_write = LONG_MAX;
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
-		goto skip_write;
+		return;
 
-	/* collect a number of dirty meta pages and write together */
-	if (wbc->sync_mode != WB_SYNC_ALL &&
-			get_pages(sbi, F2FS_DIRTY_META) <
-					nr_pages_to_skip(sbi, META))
-		goto skip_write;
+	/* collect a number of dirty meta caches and write together */
+	if (get_pages(sbi, F2FS_DIRTY_META) <
+			nr_pages_to_skip(sbi, META))
+		return;
 
-	/* if locked failed, cp will flush dirty pages instead */
+	/* if locked failed, cp will flush dirty caches instead */
 	if (!f2fs_down_write_trylock_trace(&sbi->cp_global_sem, &lc))
-		goto skip_write;
+		return;
 
-	trace_f2fs_writepages(mapping->host, wbc, META);
-	diff = nr_pages_to_write(sbi, META, wbc);
-	written = f2fs_sync_meta_pages(sbi, wbc->nr_to_write, FS_META_IO);
+	nr_to_write = adjust_flush_cache_number(sbi, META);
+	f2fs_sync_meta_caches(sbi, nr_to_write, false, FS_META_IO);
 	f2fs_up_write_trace(&sbi->cp_global_sem, &lc);
-	wbc->nr_to_write = max((long)0, wbc->nr_to_write - written - diff);
-	return 0;
-
-skip_write:
-	wbc->pages_skipped += get_pages(sbi, F2FS_DIRTY_META);
-	trace_f2fs_writepages(mapping->host, wbc, META);
-	return 0;
 }
 
-long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, long nr_to_write,
-				enum iostat_type io_type)
+long f2fs_sync_meta_caches(struct f2fs_sb_info *sbi, long nr_to_write,
+				bool sync, enum iostat_type io_type)
 {
-	struct address_space *mapping = META_MAPPING(sbi);
 	pgoff_t index = 0, prev = ULONG_MAX;
-	struct folio_batch fbatch;
+	struct f2fs_cached_block *entries[F2FS_ONSTACK_CACHES];
 	long nwritten = 0;
-	int nr_folios;
-	struct writeback_control wbc = {};
+	int nr;
 	struct blk_plug plug;
-
-	folio_batch_init(&fbatch);
+	bool background = nr_to_write != LONG_MAX;
 
 	blk_start_plug(&plug);
 
-	while ((nr_folios = filemap_get_folios_tag(mapping, &index,
-					(pgoff_t)-1,
-					PAGECACHE_TAG_DIRTY, &fbatch))) {
+	while ((nr = f2fs_cache_gang_lookup_tag(META_CACHE(sbi), entries,
+			&index, F2FS_ONSTACK_CACHES, F2FS_CACHE_TAG_DIRTY))) {
 		int i;
 
-		for (i = 0; i < nr_folios; i++) {
-			struct folio *folio = fbatch.folios[i];
+		for (i = 0; i < nr; i++) {
+			struct f2fs_cached_block *entry = entries[i];
+
+			if (background && unlikely(freezing(current))) {
+				f2fs_cache_gang_release(entries, nr);
+				goto stop;
+			}
 
-			if (nr_to_write != LONG_MAX && i != 0 &&
-					folio->index != prev +
-					folio_nr_pages(fbatch.folios[i-1])) {
-				folio_batch_release(&fbatch);
+			if (background && i != 0 &&
+					entry->index != prev + 1) {
+				f2fs_cache_gang_release(entries, nr);
 				goto stop;
 			}
 
-			folio_lock(folio);
+			f2fs_lock_cache(entry);
 
-			if (unlikely(!is_meta_folio(folio))) {
+			if (unlikely(!f2fs_is_meta_cache(entry))) {
 continue_unlock:
-				folio_unlock(folio);
+				f2fs_unlock_cache(entry);
 				continue;
 			}
-			if (!folio_test_dirty(folio)) {
+			if (!f2fs_cache_test_dirty(entry)) {
 				/* someone wrote it for us */
 				goto continue_unlock;
 			}
 
-			f2fs_folio_wait_writeback(folio, META, true, true);
+			f2fs_cache_wait_writeback(entry);
 
-			if (!folio_clear_dirty_for_io(folio))
+			if (!f2fs_cache_test_and_clear_dirty(entry))
 				goto continue_unlock;
 
-			if (!__f2fs_write_meta_folio(folio, &wbc,
-						io_type)) {
-				folio_unlock(folio);
+			if (!__f2fs_write_meta_cache(entry, io_type)) {
+				f2fs_unlock_cache(entry);
 				break;
 			}
-			nwritten += folio_nr_pages(folio);
-			prev = folio->index;
+			nwritten++;
+			prev = entry->index;
 			if (unlikely(nwritten >= nr_to_write))
 				break;
 		}
-		folio_batch_release(&fbatch);
+		f2fs_cache_gang_release(entries, nr);
 		cond_resched();
 	}
 stop:
@@ -675,29 +670,6 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, long nr_to_write,
 	return nwritten;
 }
 
-static bool f2fs_dirty_meta_folio(struct address_space *mapping,
-		struct folio *folio)
-{
-	trace_f2fs_set_page_dirty(folio, META);
-
-	if (!folio_test_uptodate(folio))
-		folio_mark_uptodate(folio);
-	if (filemap_dirty_folio(mapping, folio)) {
-		inc_page_count(F2FS_M_SB(mapping), F2FS_DIRTY_META);
-		folio_set_f2fs_reference(folio);
-		return true;
-	}
-	return false;
-}
-
-const struct address_space_operations f2fs_meta_aops = {
-	.writepages	= f2fs_write_meta_pages,
-	.dirty_folio	= f2fs_dirty_meta_folio,
-	.invalidate_folio = f2fs_invalidate_folio,
-	.release_folio	= f2fs_release_folio,
-	.migrate_folio	= filemap_migrate_folio,
-};
-
 static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
 						unsigned int devidx, int type)
 {
@@ -1029,21 +1001,21 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
 	orphan_blocks = __start_sum_addr(sbi) - 1 - __cp_payload(sbi);
 
-	f2fs_ra_meta_pages(sbi, start_blk, orphan_blocks, META_CP, true);
+	f2fs_ra_meta_caches(sbi, start_blk, orphan_blocks, META_CP, true);
 
 	for (i = 0; i < orphan_blocks; i++) {
-		struct folio *folio;
+		struct f2fs_cached_block *entry;
 		struct f2fs_orphan_block *orphan_blk;
 		struct f2fs_orphan_footer *footer;
 		unsigned int entry_count;
 
-		folio = f2fs_get_meta_folio(sbi, start_blk + i);
-		if (IS_ERR(folio)) {
-			err = PTR_ERR(folio);
+		entry = f2fs_get_meta_cache(sbi, start_blk + i);
+		if (IS_ERR(entry)) {
+			err = PTR_ERR(entry);
 			goto out;
 		}
 
-		orphan_blk = folio_address(folio);
+		orphan_blk = cache_address(entry);
 		footer = f2fs_orphan_footer(orphan_blk, sbi);
 		entry_count = le32_to_cpu(footer->entry_count);
 		if (entry_count > F2FS_ORPHANS_PER_BLOCK(sbi)) {
@@ -1052,7 +1024,7 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_handle_error(sbi, ERROR_INCONSISTENT_ORPHAN);
 			err = -EFSCORRUPTED;
-			f2fs_folio_put(folio, true);
+			f2fs_put_cache(entry, true);
 			goto out;
 		}
 
@@ -1061,11 +1033,11 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 
 			err = recover_orphan_inode(sbi, ino);
 			if (err) {
-				f2fs_folio_put(folio, true);
+				f2fs_put_cache(entry, true);
 				goto out;
 			}
 		}
-		f2fs_folio_put(folio, true);
+		f2fs_put_cache(entry, true);
 	}
 	/* clear Orphan Flag */
 	clear_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
@@ -1083,9 +1055,9 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	unsigned int nentries = 0;
 	unsigned short index = 1;
 	unsigned short orphan_blocks;
-	struct folio *folio = NULL;
 	struct ino_entry *orphan = NULL;
 	struct inode_management *im = &sbi->im[ORPHAN_INO];
+	struct f2fs_cached_block *entry = NULL;
 
 	orphan_blocks = GET_ORPHAN_BLOCKS(sbi, im->ino_num);
 
@@ -1098,9 +1070,9 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 
 	/* loop for each orphan inode entry and write them in journal block */
 	list_for_each_entry(orphan, head, list) {
-		if (!folio) {
-			folio = f2fs_grab_meta_folio(sbi, start_blk++);
-			orphan_blk = folio_address(folio);
+		if (!entry) {
+			entry = f2fs_grab_meta_cache(sbi, start_blk++);
+			orphan_blk = cache_address(entry);
 			footer = f2fs_orphan_footer(orphan_blk, sbi);
 			memset(orphan_blk, 0, sbi->blocksize);
 		}
@@ -1116,20 +1088,20 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 			footer->blk_addr = cpu_to_le16(index);
 			footer->blk_count = cpu_to_le16(orphan_blocks);
 			footer->entry_count = cpu_to_le32(nentries);
-			folio_mark_dirty(folio);
-			f2fs_folio_put(folio, true);
+			f2fs_mark_cache_dirty(entry);
+			f2fs_put_cache(entry, true);
 			index++;
 			nentries = 0;
-			folio = NULL;
+			entry = NULL;
 		}
 	}
 
-	if (folio) {
+	if (entry) {
 		footer->blk_addr = cpu_to_le16(index);
 		footer->blk_count = cpu_to_le16(orphan_blocks);
 		footer->entry_count = cpu_to_le32(nentries);
-		folio_mark_dirty(folio);
-		f2fs_folio_put(folio, true);
+		f2fs_mark_cache_dirty(entry);
+		f2fs_put_cache(entry, true);
 	}
 }
 
@@ -1149,29 +1121,29 @@ static __u32 f2fs_checkpoint_chksum(struct f2fs_sb_info *sbi,
 }
 
 static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
-		struct f2fs_checkpoint **cp_block, struct folio **cp_folio,
+		struct f2fs_checkpoint **cp_block, struct f2fs_cached_block **cp_entry,
 		unsigned long long *version)
 {
 	size_t crc_offset = 0;
 	__u32 crc;
 
-	*cp_folio = f2fs_get_meta_folio(sbi, cp_addr);
-	if (IS_ERR(*cp_folio))
-		return PTR_ERR(*cp_folio);
+	*cp_entry = f2fs_get_meta_cache(sbi, cp_addr);
+	if (IS_ERR(*cp_entry))
+		return PTR_ERR(*cp_entry);
 
-	*cp_block = folio_address(*cp_folio);
+	*cp_block = cache_address(*cp_entry);
 
 	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
 	if (crc_offset < CP_MIN_CHKSUM_OFFSET ||
 			crc_offset > CP_CHKSUM_OFFSET(sbi)) {
-		f2fs_folio_put(*cp_folio, true);
+		f2fs_put_cache(*cp_entry, true);
 		f2fs_warn(sbi, "invalid crc_offset: %zu", crc_offset);
 		return -EINVAL;
 	}
 
 	crc = f2fs_checkpoint_chksum(sbi, *cp_block);
 	if (crc != cur_cp_crc(*cp_block)) {
-		f2fs_folio_put(*cp_folio, true);
+		f2fs_put_cache(*cp_entry, true);
 		f2fs_warn(sbi, "invalid crc value");
 		return -EINVAL;
 	}
@@ -1180,17 +1152,17 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
 	return 0;
 }
 
-static struct folio *validate_checkpoint(struct f2fs_sb_info *sbi,
+static struct f2fs_cached_block *validate_checkpoint(struct f2fs_sb_info *sbi,
 				block_t cp_addr, unsigned long long *version)
 {
-	struct folio *cp_folio_1 = NULL, *cp_folio_2 = NULL;
+	struct f2fs_cached_block *cp_entry_1 = NULL, *cp_entry_2 = NULL;
 	struct f2fs_checkpoint *cp_block = NULL;
 	unsigned long long cur_version = 0, pre_version = 0;
 	unsigned int cp_blocks;
 	int err;
 
 	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
-					&cp_folio_1, version);
+					&cp_entry_1, version);
 	if (err)
 		return NULL;
 
@@ -1205,19 +1177,19 @@ static struct folio *validate_checkpoint(struct f2fs_sb_info *sbi,
 
 	cp_addr += cp_blocks - 1;
 	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
-					&cp_folio_2, version);
+					&cp_entry_2, version);
 	if (err)
 		goto invalid_cp;
 	cur_version = *version;
 
 	if (cur_version == pre_version) {
 		*version = cur_version;
-		f2fs_folio_put(cp_folio_2, true);
-		return cp_folio_1;
+		f2fs_put_cache(cp_entry_2, true);
+		return cp_entry_1;
 	}
-	f2fs_folio_put(cp_folio_2, true);
+	f2fs_put_cache(cp_entry_2, true);
 invalid_cp:
-	f2fs_folio_put(cp_folio_1, true);
+	f2fs_put_cache(cp_entry_1, true);
 	return NULL;
 }
 
@@ -1225,7 +1197,7 @@ int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *cp_block;
 	struct f2fs_super_block *fsb = sbi->raw_super;
-	struct folio *cp1, *cp2, *cur_folio;
+	struct f2fs_cached_block *cp1 = NULL, *cp2 = NULL, *cur_entry;
 	unsigned long blk_size = sbi->blocksize;
 	unsigned long long cp1_version = 0, cp2_version = 0;
 	unsigned long long cp_start_blk_no;
@@ -1252,22 +1224,22 @@ int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi)
 
 	if (cp1 && cp2) {
 		if (ver_after(cp2_version, cp1_version))
-			cur_folio = cp2;
+			cur_entry = cp2;
 		else
-			cur_folio = cp1;
+			cur_entry = cp1;
 	} else if (cp1) {
-		cur_folio = cp1;
+		cur_entry = cp1;
 	} else if (cp2) {
-		cur_folio = cp2;
+		cur_entry = cp2;
 	} else {
 		err = -EFSCORRUPTED;
 		goto fail_no_cp;
 	}
 
-	cp_block = folio_address(cur_folio);
+	cp_block = cache_address(cur_entry);
 	memcpy(sbi->ckpt, cp_block, blk_size);
 
-	if (cur_folio == cp1)
+	if (cur_entry == cp1)
 		sbi->cur_cp_pack = 1;
 	else
 		sbi->cur_cp_pack = 2;
@@ -1282,30 +1254,31 @@ int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi)
 		goto done;
 
 	cp_blk_no = le32_to_cpu(fsb->cp_blkaddr);
-	if (cur_folio == cp2)
+	if (cur_entry == cp2)
 		cp_blk_no += BIT(le32_to_cpu(fsb->log_blocks_per_seg));
 
 	for (i = 1; i < cp_blks; i++) {
+		struct f2fs_cached_block *cur_entry_payload;
 		void *sit_bitmap_ptr;
 		unsigned char *ckpt = (unsigned char *)sbi->ckpt;
 
-		cur_folio = f2fs_get_meta_folio(sbi, cp_blk_no + i);
-		if (IS_ERR(cur_folio)) {
-			err = PTR_ERR(cur_folio);
+		cur_entry_payload = f2fs_get_meta_cache(sbi, cp_blk_no + i);
+		if (IS_ERR(cur_entry_payload)) {
+			err = PTR_ERR(cur_entry_payload);
 			goto free_fail_no_cp;
 		}
-		sit_bitmap_ptr = folio_address(cur_folio);
+		sit_bitmap_ptr = cache_address(cur_entry_payload);
 		memcpy(ckpt + i * blk_size, sit_bitmap_ptr, blk_size);
-		f2fs_folio_put(cur_folio, true);
+		f2fs_put_cache(cur_entry_payload, true);
 	}
 done:
-	f2fs_folio_put(cp1, true);
-	f2fs_folio_put(cp2, true);
+	f2fs_put_cache(cp1, true);
+	f2fs_put_cache(cp2, true);
 	return 0;
 
 free_fail_no_cp:
-	f2fs_folio_put(cp1, true);
-	f2fs_folio_put(cp2, true);
+	f2fs_put_cache(cp1, true);
+	f2fs_put_cache(cp2, true);
 fail_no_cp:
 	kvfree(sbi->ckpt);
 	return err;
@@ -1618,7 +1591,7 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
 			break;
 
 		if (type == F2FS_DIRTY_META)
-			f2fs_sync_meta_pages(sbi, LONG_MAX, FS_CP_META_IO);
+			f2fs_sync_meta_caches(sbi, LONG_MAX, true, FS_META_IO);
 		else if (type == F2FS_WB_CP_DATA)
 			f2fs_submit_merged_write(sbi, DATA);
 
@@ -1697,31 +1670,24 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 static void commit_checkpoint(struct f2fs_sb_info *sbi,
 	void *src, block_t blk_addr)
 {
-	struct writeback_control wbc = {};
-
-	/*
-	 * filemap_get_folios_tag and folio_lock again will take
-	 * some extra time. Therefore, f2fs_update_meta_pages and
-	 * f2fs_sync_meta_pages are combined in this function.
-	 */
-	struct folio *folio = f2fs_grab_meta_folio(sbi, blk_addr);
+	struct f2fs_cached_block *entry = f2fs_grab_meta_cache(sbi, blk_addr);
 
-	memcpy(folio_address(folio), src, F2FS_BLKSIZE(sbi));
+	memcpy(cache_address(entry), src, F2FS_BLKSIZE(sbi));
 
-	folio_mark_dirty(folio);
-	if (unlikely(!folio_clear_dirty_for_io(folio)))
+	f2fs_mark_cache_dirty(entry);
+	if (unlikely(!f2fs_cache_test_and_clear_dirty(entry)))
 		f2fs_bug_on(sbi, 1);
 
 	/* writeout cp pack 2 page */
-	if (unlikely(!__f2fs_write_meta_folio(folio, &wbc, FS_CP_META_IO))) {
+	if (unlikely(!__f2fs_write_meta_cache(entry, FS_CP_META_IO))) {
 		if (f2fs_cp_error(sbi)) {
-			f2fs_folio_put(folio, true);
+			f2fs_put_cache(entry, true);
 			return;
 		}
 		f2fs_bug_on(sbi, true);
 	}
 
-	f2fs_folio_put(folio, false);
+	f2fs_put_cache(entry, false);
 
 	/* submit checkpoint (with barrier if NOBARRIER is not set) */
 	f2fs_submit_merged_write(sbi, META_FLUSH);
@@ -1790,7 +1756,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	int err;
 
 	/* Flush all the NAT/SIT pages */
-	f2fs_sync_meta_pages(sbi, LONG_MAX, FS_CP_META_IO);
+	f2fs_sync_meta_caches(sbi, LONG_MAX, true, FS_CP_META_IO);
 
 	stat_cp_time(cpc, CP_TIME_SYNC_META);
 
@@ -1889,7 +1855,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	}
 
 	/* Here, we have one bio having CP pack except cp pack 2 page */
-	f2fs_sync_meta_pages(sbi, LONG_MAX, FS_CP_META_IO);
+	f2fs_sync_meta_caches(sbi, LONG_MAX, true, FS_CP_META_IO);
 	stat_cp_time(cpc, CP_TIME_SYNC_CP_META);
 
 	/* Wait for all dirty meta pages to be submitted for IO */
@@ -1916,10 +1882,10 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * used for migration of encrypted, verity or compressed inode's blocks.
 	 */
 	if (f2fs_sb_has_encrypt(sbi) || f2fs_sb_has_verity(sbi) ||
-		f2fs_sb_has_compression(sbi))
-		f2fs_bug_on(sbi,
-			invalidate_inode_pages2_range(META_MAPPING(sbi),
-				MAIN_BLKADDR(sbi), MAX_BLKADDR(sbi) - 1));
+		f2fs_sb_has_compression(sbi)) {
+		f2fs_truncate_meta_caches(sbi, MAIN_BLKADDR(sbi),
+				MAX_BLKADDR(sbi) - MAIN_BLKADDR(sbi));
+	}
 
 	f2fs_release_ino_entry(sbi, false);
 
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ce88092d9ce2..991b7738c645 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1150,7 +1150,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		f2fs_compress_ctx_add_page(cc, folio);
 
 		if (!folio_test_uptodate(folio)) {
-			f2fs_handle_page_eio(sbi, folio, DATA);
+			f2fs_handle_page_eio(sbi, folio->index, DATA);
 release_and_retry:
 			f2fs_put_rpages(cc);
 			f2fs_unlock_rpages(cc, i + 1);
@@ -1357,7 +1357,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		fio.old_blkaddr = data_blkaddr(dn.inode, dn.node_folio,
 						dn.ofs_in_node + i + 1);
 
-		/* wait for GCed page writeback via META_MAPPING */
+		/* wait for GCed page writeback via generic cache */
 		f2fs_wait_on_block_writeback(inode, fio.old_blkaddr);
 	}
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7b7f7be3f0ed..adccbc7f3283 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -63,8 +63,7 @@ bool f2fs_is_cp_guaranteed(const struct folio *folio)
 	inode = mapping->host;
 	sbi = F2FS_I_SB(inode);
 
-	if (inode->i_ino == F2FS_META_INO(sbi) ||
-			inode->i_ino == F2FS_NODE_INO(sbi) ||
+	if (inode->i_ino == F2FS_NODE_INO(sbi) ||
 			S_ISDIR(inode->i_mode))
 		return true;
 
@@ -82,9 +81,6 @@ static enum count_type __read_io_type(struct folio *folio)
 		struct inode *inode = mapping->host;
 		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
-		if (inode->i_ino == F2FS_META_INO(sbi))
-			return F2FS_RD_META;
-
 		if (inode->i_ino == F2FS_NODE_INO(sbi))
 			return F2FS_RD_NODE;
 	}
@@ -1417,7 +1413,7 @@ static void f2fs_submit_page_read(struct inode *inode, struct fsverity_info *vi,
 	bio = f2fs_grab_read_bio(inode, vi, blkaddr, 1, op_flags, folio->index,
 				 for_write);
 
-	/* wait for GCed page writeback via META_MAPPING */
+	/* wait for GCed page writeback via generic cache */
 	f2fs_wait_on_block_writeback(inode, blkaddr);
 
 	if (!bio_add_folio(bio, folio, PAGE_SIZE, 0))
@@ -3238,7 +3234,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		goto out_writepage;
 	}
 
-	/* wait for GCed page writeback via META_MAPPING */
+	/* wait for GCed page writeback via generic cache */
 	if (fio->meta_gc)
 		f2fs_wait_on_block_writeback(inode, fio->old_blkaddr);
 
@@ -4310,9 +4306,7 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 		return;
 
 	if (folio_test_dirty(folio)) {
-		if (inode->i_ino == F2FS_META_INO(sbi)) {
-			dec_page_count(sbi, F2FS_DIRTY_META);
-		} else if (inode->i_ino == F2FS_NODE_INO(sbi)) {
+		if (inode->i_ino == F2FS_NODE_INO(sbi)) {
 			dec_page_count(sbi, F2FS_DIRTY_NODES);
 		} else {
 			inode_dec_dirty_pages(inode);
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index a6cfceafe2fe..24819d4c0d55 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -224,8 +224,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->dirty_count = dirty_segments(sbi);
 	if (sbi->node_inode)
 		si->node_pages = NODE_MAPPING(sbi)->nrpages;
-	if (sbi->meta_inode)
-		si->meta_pages = META_MAPPING(sbi)->nrpages;
+	si->meta_caches = META_CACHE(sbi)->num_entries;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (sbi->compress_inode) {
 		si->compress_pages = COMPRESS_MAPPING(sbi)->nrpages;
@@ -388,11 +387,8 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 
 		si->page_mem += (unsigned long long)npages << PAGE_SHIFT;
 	}
-	if (sbi->meta_inode) {
-		unsigned long npages = META_MAPPING(sbi)->nrpages;
-
-		si->page_mem += (unsigned long long)npages << PAGE_SHIFT;
-	}
+	si->page_mem += (unsigned long long)META_CACHE(sbi)->num_entries << PAGE_SHIFT;
+	si->cache_mem += META_CACHE(sbi)->num_entries * sizeof(struct f2fs_cached_block);
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (sbi->compress_inode) {
 		unsigned long npages = COMPRESS_MAPPING(sbi)->nrpages;
@@ -708,7 +704,7 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - quota data: %4d in quota files:%4d\n",
 			   si->ndirty_qdata, si->nquota_files);
 		seq_printf(s, "  - meta: %4d in %4d\n",
-			   si->ndirty_meta, si->meta_pages);
+			   si->ndirty_meta, si->meta_caches);
 		seq_printf(s, "  - imeta: %4d\n",
 			   si->ndirty_imeta);
 		seq_printf(s, "  - fsync mark: %4lld\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c8e93dd2fc4f..cceb14077b42 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1820,7 +1820,6 @@ struct f2fs_sb_info {
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
 	int cur_cp_pack;			/* remain current cp pack */
 	spinlock_t cp_lock;			/* for flag in ckpt */
-	struct inode *meta_inode;		/* cache meta blocks */
 	struct f2fs_rwsem cp_global_sem;	/* checkpoint procedure lock */
 	struct f2fs_rwsem cp_rwsem;		/* blocking FS operations */
 	struct f2fs_rwsem node_write;		/* locking node writes */
@@ -1874,7 +1873,6 @@ struct f2fs_sb_info {
 	unsigned int dentry_reserved_size;	/* dentry reserved bytes */
 	unsigned int root_ino_num;		/* root inode number*/
 	unsigned int node_ino_num;		/* node inode number*/
-	unsigned int meta_ino_num;		/* meta inode number*/
 	unsigned int log_blocks_per_seg;	/* log2 blocks per segment */
 	unsigned int blocks_per_seg;		/* blocks per segment */
 	unsigned int segs_per_sec;		/* segments per section */
@@ -2377,9 +2375,9 @@ static inline struct dirty_seglist_info *DIRTY_I(struct f2fs_sb_info *sbi)
 	return (struct dirty_seglist_info *)(SM_I(sbi)->dirty_info);
 }
 
-static inline struct address_space *META_MAPPING(struct f2fs_sb_info *sbi)
+static inline bool f2fs_is_meta_cache(struct f2fs_cached_block *entry)
 {
-	return sbi->meta_inode->i_mapping;
+	return entry->cache && entry->cache == META_CACHE(entry->cache->sbi);
 }
 
 static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
@@ -2387,11 +2385,6 @@ static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
 	return sbi->node_inode->i_mapping;
 }
 
-static inline bool is_meta_folio(struct folio *folio)
-{
-	return folio->mapping == META_MAPPING(F2FS_F_SB(folio));
-}
-
 static inline bool is_node_folio(struct folio *folio)
 {
 	return folio->mapping == NODE_MAPPING(F2FS_F_SB(folio));
@@ -4130,9 +4123,9 @@ bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid);
 void f2fs_alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
 void f2fs_alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid);
 int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink);
-int f2fs_recover_inline_xattr(struct inode *inode, struct folio *folio);
-int f2fs_recover_xattr_data(struct inode *inode, struct folio *folio);
-int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct folio *folio);
+int f2fs_recover_inline_xattr(struct inode *inode, struct f2fs_cached_block *entry);
+int f2fs_recover_xattr_data(struct inode *inode, struct f2fs_cached_block *entry);
+int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry);
 int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum);
 int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
@@ -4184,11 +4177,13 @@ int f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
 bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
 					struct cp_control *cpc);
-struct folio *f2fs_get_sum_folio(struct f2fs_sb_info *sbi, unsigned int segno);
+struct f2fs_cached_block *f2fs_get_sum_cache(struct f2fs_sb_info *sbi,
+		unsigned int segno);
 void f2fs_update_meta_page(struct f2fs_sb_info *sbi, void *src,
 					block_t blk_addr);
-void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct folio *folio,
-						enum iostat_type io_type);
+void f2fs_do_write_meta_cache(struct f2fs_sb_info *sbi,
+			struct f2fs_cached_block *entry,
+			enum iostat_type io_type);
 void f2fs_do_write_node_page(unsigned int nid, struct f2fs_io_info *fio);
 void f2fs_outplace_write_data(struct dnode_of_data *dn,
 			struct f2fs_io_info *fio);
@@ -4211,8 +4206,6 @@ void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
 					block_t blkaddr, unsigned int blkcnt);
 void f2fs_folio_wait_writeback(struct folio *folio, enum page_type type,
 		bool ordered, bool locked);
-#define f2fs_wait_on_page_writeback(page, type, ordered, locked)	\
-		f2fs_folio_wait_writeback(page_folio(page), type, ordered, locked)
 void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr);
 void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 								block_t len);
@@ -4278,20 +4271,21 @@ void f2fs_unlock_op(struct f2fs_sb_info *sbi, struct f2fs_lock_context *lc);
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io,
 							unsigned char reason);
 void f2fs_flush_ckpt_thread(struct f2fs_sb_info *sbi);
-struct folio *f2fs_grab_meta_folio(struct f2fs_sb_info *sbi, pgoff_t index);
-struct folio *f2fs_get_meta_folio(struct f2fs_sb_info *sbi, pgoff_t index);
-struct folio *f2fs_get_meta_folio_retry(struct f2fs_sb_info *sbi, pgoff_t index);
-struct folio *f2fs_get_tmp_folio(struct f2fs_sb_info *sbi, pgoff_t index);
+struct f2fs_cached_block *f2fs_grab_meta_cache(struct f2fs_sb_info *sbi, pgoff_t index);
+struct f2fs_cached_block *f2fs_get_meta_cache(struct f2fs_sb_info *sbi, pgoff_t index);
+struct f2fs_cached_block *f2fs_get_meta_cache_retry(struct f2fs_sb_info *sbi, pgoff_t index);
+struct f2fs_cached_block *f2fs_get_tmp_cache(struct f2fs_sb_info *sbi, pgoff_t index);
 bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 					block_t blkaddr, int type);
 bool f2fs_is_valid_blkaddr_raw(struct f2fs_sb_info *sbi,
 					block_t blkaddr, int type);
-int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
+int f2fs_ra_meta_caches(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 			int type, bool sync);
-void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index,
+void f2fs_ra_meta_caches_cond(struct f2fs_sb_info *sbi, pgoff_t index,
 							unsigned int ra_blocks);
-long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, long nr_to_write,
-			enum iostat_type io_type);
+void f2fs_write_meta_caches(struct f2fs_sb_info *sbi);
+long f2fs_sync_meta_caches(struct f2fs_sb_info *sbi, long nr_to_write,
+				bool sync, enum iostat_type io_type);
 void f2fs_add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type);
 void f2fs_remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type);
 void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all);
@@ -4477,7 +4471,7 @@ struct f2fs_stat_info {
 	unsigned int bimodal, avg_vblocks;
 	int util_free, util_valid, util_invalid;
 	int rsvd_segs, overp_segs;
-	int dirty_count, node_pages, meta_pages, compress_pages;
+	int dirty_count, node_pages, meta_caches, compress_pages;
 	int compress_page_hit;
 	int prefree_count, free_segs, free_secs;
 	int cp_call_count[MAX_CALL_TYPE], cp_count;
@@ -4679,7 +4673,6 @@ extern const struct file_operations f2fs_file_operations;
 extern const struct inode_operations f2fs_file_inode_operations;
 extern const struct address_space_operations f2fs_dblock_aops;
 extern const struct address_space_operations f2fs_node_aops;
-extern const struct address_space_operations f2fs_meta_aops;
 extern const struct inode_operations f2fs_dir_inode_operations;
 extern const struct inode_operations f2fs_symlink_inode_operations;
 extern const struct inode_operations f2fs_encrypted_symlink_inode_operations;
@@ -4700,7 +4693,7 @@ int f2fs_convert_inline_folio(struct dnode_of_data *dn, struct folio *folio);
 int f2fs_convert_inline_inode(struct inode *inode);
 int f2fs_try_convert_inline_dir(struct inode *dir, struct dentry *dentry);
 int f2fs_write_inline_data(struct inode *inode, struct folio *folio);
-int f2fs_recover_inline_data(struct inode *inode, struct folio *nfolio);
+int f2fs_recover_inline_data(struct inode *inode, struct f2fs_cached_block *entry);
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 		const struct f2fs_filename *fname, struct folio **res_folio,
 		bool use_hash);
@@ -5260,10 +5253,8 @@ static inline void f2fs_schedule_timeout_killable(long timeout, bool io)
 }
 
 static inline void f2fs_handle_page_eio(struct f2fs_sb_info *sbi,
-				struct folio *folio, enum page_type type)
+				pgoff_t ofs, enum page_type type)
 {
-	pgoff_t ofs = folio->index;
-
 	if (unlikely(f2fs_cp_error(sbi)))
 		return;
 
@@ -5298,37 +5289,10 @@ static inline bool f2fs_is_readonly(struct f2fs_sb_info *sbi)
 	return f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb);
 }
 
-static inline void f2fs_truncate_meta_inode_pages(struct f2fs_sb_info *sbi,
-					block_t blkaddr, unsigned int cnt)
-{
-	bool need_submit = false;
-	int i = 0;
-
-	do {
-		struct folio *folio;
-
-		folio = filemap_get_folio(META_MAPPING(sbi), blkaddr + i);
-		if (!IS_ERR(folio)) {
-			if (folio_test_writeback(folio))
-				need_submit = true;
-			f2fs_folio_put(folio, false);
-		}
-	} while (++i < cnt && !need_submit);
-
-	if (need_submit)
-		f2fs_submit_merged_write_cond(sbi, sbi->meta_inode,
-							NULL, 0, DATA);
-
-	truncate_inode_pages_range(META_MAPPING(sbi),
-			F2FS_BLK_TO_BYTES(sbi, (loff_t)blkaddr),
-			F2FS_BLK_END_BYTES(sbi,
-					    (loff_t)(blkaddr + cnt - 1)));
-}
-
 static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
 						block_t blkaddr, unsigned int len)
 {
-	f2fs_truncate_meta_inode_pages(sbi, blkaddr, len);
+	f2fs_truncate_meta_caches(sbi, blkaddr, len);
 	f2fs_invalidate_compress_pages_range(sbi, blkaddr, len);
 }
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b0bdc7a977b9..7c2bfa0e63d2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -215,7 +215,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	f2fs_folio_wait_writeback(folio, DATA, false, true);
 
-	/* wait for GCed page writeback via META_MAPPING */
+	/* wait for GCed page writeback via generic cache */
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
 	/*
@@ -2567,7 +2567,7 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
 		break;
 	case F2FS_GOING_DOWN_METAFLUSH:
-		f2fs_sync_meta_pages(sbi, LONG_MAX, FS_META_IO);
+		f2fs_sync_meta_caches(sbi, LONG_MAX, true, FS_META_IO);
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
 		break;
 	case F2FS_GOING_DOWN_NEED_FSCK:
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index aedb45c8ee4a..bed9056d6b6e 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1066,7 +1066,7 @@ static int gc_node_segment(struct f2fs_sb_info *sbi,
 			continue;
 
 		if (phase == 0) {
-			f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(sbi, nid), 1,
+			f2fs_ra_meta_caches(sbi, NAT_BLOCK_OFFSET(sbi, nid), 1,
 							META_NAT, true);
 			continue;
 		}
@@ -1219,7 +1219,8 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	struct address_space *mapping = inode->i_mapping;
 	struct inode *atomic_inode = NULL;
 	struct dnode_of_data dn;
-	struct folio *folio, *efolio;
+	struct folio *folio;
+	struct f2fs_cached_block *entry;
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
 		.ino = inode->i_ino,
@@ -1229,6 +1230,7 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 		.op_flags = 0,
 		.encrypted_page = NULL,
 		.in_list = 0,
+		.is_cache = 1,
 	};
 	int err = 0;
 
@@ -1287,22 +1289,21 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
-	efolio = f2fs_filemap_get_folio(META_MAPPING(sbi), dn.data_blkaddr,
-					FGP_LOCK | FGP_CREAT, GFP_NOFS);
-	if (IS_ERR(efolio)) {
-		err = PTR_ERR(efolio);
+	entry = f2fs_grab_cache(META_CACHE(sbi), dn.data_blkaddr,
+						F2FS_CACHE_LOCK_CREATE);
+	if (IS_ERR(entry)) {
+		err = PTR_ERR(entry);
 		goto put_folio;
 	}
 
-	fio.encrypted_page = &efolio->page;
-
-	if (folio_test_uptodate(efolio))
-		goto put_encrypted_page;
+	if (f2fs_cache_test_uptodate(entry))
+		goto put_cache;
 
-	err = f2fs_submit_page_bio(&fio);
+	fio.cache_entry = entry;
+	err = f2fs_submit_cache_read(&fio);
 	if (err)
-		goto put_encrypted_page;
-	f2fs_put_page(fio.encrypted_page, false);
+		goto put_cache;
+	f2fs_put_cache(entry, false);
 	f2fs_folio_put(folio, true);
 
 	f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO, F2FS_BLKSIZE(sbi));
@@ -1311,8 +1312,8 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	if (atomic_inode)
 		iput(atomic_inode);
 	return 0;
-put_encrypted_page:
-	f2fs_put_page(fio.encrypted_page, true);
+put_cache:
+	f2fs_put_cache(entry, true);
 put_folio:
 	f2fs_folio_put(folio, true);
 out_iput:
@@ -1322,7 +1323,7 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 }
 
 /*
- * Move data block via META_MAPPING while keeping locked data page.
+ * Move data block via meta cache while keeping locked data page.
  * This can be used to move blocks, aka LBAs, directly on disk.
  */
 static int move_data_block(struct inode *inode, block_t bidx,
@@ -1339,11 +1340,13 @@ static int move_data_block(struct inode *inode, block_t bidx,
 		.op_flags = 0,
 		.encrypted_page = NULL,
 		.in_list = 0,
+		.is_cache = 1,
 	};
 	struct dnode_of_data dn;
 	struct f2fs_summary sum;
 	struct node_info ni;
-	struct folio *folio, *mfolio, *efolio;
+	struct folio *folio;
+	struct f2fs_cached_block *sentry, *tentry;
 	block_t newaddr;
 	int err = 0;
 	bool lfs_mode = f2fs_lfs_mode(fio.sbi);
@@ -1408,20 +1411,20 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	if (lfs_mode)
 		f2fs_down_write(&fio.sbi->io_order_lock);
 
-	mfolio = f2fs_grab_cache_folio(META_MAPPING(fio.sbi),
-					fio.old_blkaddr, false);
-	if (IS_ERR(mfolio)) {
-		err = PTR_ERR(mfolio);
+	sentry = f2fs_grab_cache(META_CACHE(fio.sbi), fio.old_blkaddr,
+						F2FS_CACHE_LOCK_CREATE);
+	if (IS_ERR(sentry)) {
+		err = PTR_ERR(sentry);
 		goto up_out;
 	}
 
-	fio.encrypted_page = folio_file_page(mfolio, fio.old_blkaddr);
+	fio.cache_entry = sentry;
 
-	/* read source block in mfolio */
-	if (!folio_test_uptodate(mfolio)) {
-		err = f2fs_submit_page_bio(&fio);
+	/* read source block in cache */
+	if (!f2fs_cache_test_uptodate(sentry)) {
+		err = f2fs_submit_cache_read(&fio);
 		if (err) {
-			f2fs_folio_put(mfolio, true);
+			f2fs_put_cache(sentry, true);
 			goto up_out;
 		}
 
@@ -1430,11 +1433,11 @@ static int move_data_block(struct inode *inode, block_t bidx,
 		f2fs_update_iostat(fio.sbi, NULL, FS_GDATA_READ_IO,
 						F2FS_BLKSIZE(fio.sbi));
 
-		folio_lock(mfolio);
-		if (unlikely(!is_meta_folio(mfolio) ||
-			     !folio_test_uptodate(mfolio))) {
+		f2fs_lock_cache(sentry);
+		if (unlikely(!f2fs_is_meta_cache(sentry) ||
+				!f2fs_cache_test_uptodate(sentry))) {
 			err = -EIO;
-			f2fs_folio_put(mfolio, true);
+			f2fs_put_cache(sentry, true);
 			goto up_out;
 		}
 	}
@@ -1445,39 +1448,39 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	err = f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
 				&sum, type, NULL);
 	if (err) {
-		f2fs_folio_put(mfolio, true);
+		f2fs_put_cache(sentry, true);
 		/* filesystem should shutdown, no need to recovery block */
 		goto up_out;
 	}
 
-	efolio = f2fs_filemap_get_folio(META_MAPPING(fio.sbi), newaddr,
-					FGP_LOCK | FGP_CREAT, GFP_NOFS);
-	if (IS_ERR(efolio)) {
-		err = PTR_ERR(efolio);
-		f2fs_folio_put(mfolio, true);
+	tentry = f2fs_grab_cache(META_CACHE(fio.sbi), newaddr,
+					F2FS_CACHE_LOCK_CREATE);
+	if (IS_ERR(tentry)) {
+		err = PTR_ERR(tentry);
+		f2fs_put_cache(sentry, true);
 		goto recover_block;
 	}
 
-	fio.encrypted_page = &efolio->page;
+	fio.cache_entry = tentry;
 
 	/* write target block */
-	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true, true);
-	memcpy(page_address(fio.encrypted_page),
-				folio_address(mfolio), PAGE_SIZE);
-	f2fs_folio_put(mfolio, true);
+	f2fs_cache_wait_writeback_cond(tentry, DATA);
+	memcpy(cache_address(tentry), cache_address(sentry),
+							fio.sbi->blocksize);
+	f2fs_put_cache(sentry, true);
 
 	f2fs_invalidate_internal_cache(fio.sbi, fio.old_blkaddr, 1);
 
-	set_page_dirty(fio.encrypted_page);
-	if (clear_page_dirty_for_io(fio.encrypted_page))
+	f2fs_mark_cache_dirty(tentry);
+	if (f2fs_cache_test_and_clear_dirty(tentry))
 		dec_page_count(fio.sbi, F2FS_DIRTY_META);
 
-	set_page_writeback(fio.encrypted_page);
+	f2fs_start_cache_writeback(tentry);
 
 	fio.op = REQ_OP_WRITE;
 	fio.op_flags = REQ_SYNC;
 	fio.new_blkaddr = newaddr;
-	f2fs_submit_page_write(&fio);
+	f2fs_submit_cache_write(&fio);
 
 	f2fs_update_iostat(fio.sbi, NULL, FS_GC_DATA_IO,
 					F2FS_BLKSIZE(fio.sbi));
@@ -1485,7 +1488,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	f2fs_update_data_blkaddr(&dn, newaddr);
 	set_inode_flag(inode, FI_APPEND_WRITE);
 
-	f2fs_put_page(fio.encrypted_page, true);
+	f2fs_put_cache(tentry, true);
 recover_block:
 	if (err)
 		f2fs_do_replace_block(fio.sbi, &sum, newaddr, fio.old_blkaddr,
@@ -1617,7 +1620,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			continue;
 
 		if (phase == 0) {
-			f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(sbi, nid), 1,
+			f2fs_ra_meta_caches(sbi, NAT_BLOCK_OFFSET(sbi, nid), 1,
 							META_NAT, true);
 			continue;
 		}
@@ -1821,28 +1824,31 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	sum_blk_cnt = DIV_ROUND_UP(end_segno - segno, sbi->sums_per_block);
 	/* readahead multi ssa blocks those have contiguous address */
 	if (__is_large_section(sbi))
-		f2fs_ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
+		f2fs_ra_meta_caches(sbi, GET_SUM_BLOCK(sbi, segno),
 					sum_blk_cnt, META_SSA, true);
 
 	/* reference all summary page */
 	while (segno < end_segno) {
-		struct folio *sum_folio = f2fs_get_sum_folio(sbi, segno);
+		struct f2fs_cached_block *sum_entry =
+				f2fs_get_sum_cache(sbi, segno);
 
 		segno += sbi->sums_per_block;
-		if (IS_ERR(sum_folio)) {
-			int err = PTR_ERR(sum_folio);
+		if (IS_ERR(sum_entry)) {
+			int err = PTR_ERR(sum_entry);
 
 			end_segno = segno - sbi->sums_per_block;
 			segno = rounddown(start_segno, sbi->sums_per_block);
 			while (segno < end_segno) {
-				sum_folio = filemap_get_folio(META_MAPPING(sbi),
+				sum_entry = f2fs_find_meta_cache(sbi,
 						GET_SUM_BLOCK(sbi, segno));
-				folio_put_refs(sum_folio, 2);
+				f2fs_put_cache(sum_entry, false);
+				f2fs_put_cache(sum_entry, false);
 				segno += sbi->sums_per_block;
 			}
 			return err;
 		}
-		folio_unlock(sum_folio);
+		f2fs_unlock_cache(sum_entry);
+
 	}
 
 	blk_start_plug(&plug);
@@ -1850,11 +1856,16 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	segno = start_segno;
 	while (segno < end_segno) {
 		unsigned int cur_segno;
+		unsigned int block_end_segno;
 
 		/* find segment summary of victim */
-		struct folio *sum_folio = filemap_get_folio(META_MAPPING(sbi),
+		struct f2fs_cached_block *sum_entry =
+				f2fs_find_meta_cache(sbi,
 					GET_SUM_BLOCK(sbi, segno));
-		unsigned int block_end_segno = rounddown(segno, sbi->sums_per_block)
+
+		f2fs_bug_on(sbi, IS_ERR(sum_entry));
+
+		block_end_segno = rounddown(segno, sbi->sums_per_block)
 					+ sbi->sums_per_block;
 
 		if (block_end_segno > end_segno)
@@ -1867,8 +1878,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 			goto next_block;
 		}
 
-		if (!folio_test_uptodate(sum_folio) ||
-		    unlikely(f2fs_cp_error(sbi)))
+		if (!f2fs_cache_test_uptodate(sum_entry) ||
+			unlikely(f2fs_cp_error(sbi)))
 			goto next_block;
 
 		for (cur_segno = segno; cur_segno < block_end_segno;
@@ -1887,7 +1898,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 				data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
 			}
 
-			sum = SUM_BLK_PAGE_ADDR(sbi, sum_folio, cur_segno);
+			sum = SUM_BLK_ENTRY_ADDR(sbi, sum_entry, cur_segno);
 			if (type != GET_SUM_TYPE(sum_footer(sbi, sum))) {
 				f2fs_err(sbi, "Inconsistent segment (%u) type "
 						"[%d, %d] in SIT and SSA",
@@ -1929,12 +1940,14 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 					cur_segno + 1 : NULL_SEGNO;
 
 			if (unlikely(freezing(current))) {
-				folio_put_refs(sum_folio, 2);
+				f2fs_put_cache(sum_entry, false);
+				f2fs_put_cache(sum_entry, false);
 				goto stop;
 			}
 		}
 next_block:
-		folio_put_refs(sum_folio, 2);
+		f2fs_put_cache(sum_entry, false);
+		f2fs_put_cache(sum_entry, false);
 		segno = block_end_segno;
 	}
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 925bdaad013c..d10acb5042e3 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -293,7 +293,7 @@ int f2fs_write_inline_data(struct inode *inode, struct folio *folio)
 	return 0;
 }
 
-int f2fs_recover_inline_data(struct inode *inode, struct folio *nfolio)
+int f2fs_recover_inline_data(struct inode *inode, struct f2fs_cached_block *entry)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode *ri = NULL;
@@ -307,12 +307,13 @@ int f2fs_recover_inline_data(struct inode *inode, struct folio *nfolio)
 	 *    x       o  -> remove data blocks, and then recover inline_data
 	 *    x       x  -> recover data blocks
 	 */
-	if (IS_INODE(F2FS_I_SB(inode), nfolio))
-		ri = F2FS_INODE(nfolio);
+	if (IS_INODE(sbi, cache_folio(entry)))
+		ri = &CACHED_NODE(entry)->i;
 
 	if (f2fs_has_inline_data(inode) &&
 			ri && (ri->i_inline & F2FS_INLINE_DATA)) {
 		struct folio *ifolio;
+
 process_inline:
 		ifolio = f2fs_get_inode_folio(sbi, inode->i_ino);
 		if (IS_ERR(ifolio))
@@ -320,7 +321,7 @@ int f2fs_recover_inline_data(struct inode *inode, struct folio *nfolio)
 
 		f2fs_folio_wait_writeback(ifolio, NODE, true, true);
 
-		src_addr = inline_data_addr(inode, nfolio);
+		src_addr = inline_data_addr(inode, cache_folio(entry));
 		dst_addr = inline_data_addr(inode, ifolio);
 		memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 50f00286020b..49b04efd408a 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -578,7 +578,7 @@ static int do_read_inode(struct inode *inode)
 
 static bool is_meta_ino(struct f2fs_sb_info *sbi, unsigned int ino)
 {
-	if (ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi))
+	if (ino == F2FS_NODE_INO(sbi))
 		return true;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (test_opt(sbi, COMPRESS_CACHE) && ino == F2FS_COMPRESS_INO(sbi))
@@ -625,9 +625,6 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	if (ino == F2FS_NODE_INO(sbi)) {
 		inode->i_mapping->a_ops = &f2fs_node_aops;
 		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
-	} else if (ino == F2FS_META_INO(sbi)) {
-		inode->i_mapping->a_ops = &f2fs_meta_aops;
-		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 	} else if (ino == F2FS_COMPRESS_INO(sbi)) {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		inode->i_mapping->a_ops = &f2fs_compress_aops;
@@ -827,8 +824,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
-	if (inode->i_ino == F2FS_NODE_INO(sbi) ||
-			inode->i_ino == F2FS_META_INO(sbi))
+	if (inode->i_ino == F2FS_NODE_INO(sbi))
 		return 0;
 
 	/*
@@ -922,7 +918,6 @@ static bool f2fs_pre_evict_inode(struct inode *inode)
 		f2fs_invalidate_compress_pages(sbi, inode->i_ino);
 
 	if (inode->i_ino == F2FS_NODE_INO(sbi) ||
-	    inode->i_ino == F2FS_META_INO(sbi) ||
 	    inode->i_ino == F2FS_COMPRESS_INO(sbi))
 		return true;
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8c150d4966e5..de836444084b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -140,38 +140,36 @@ static void clear_node_folio_dirty(struct folio *folio)
 	folio_clear_uptodate(folio);
 }
 
-static struct folio *get_current_nat_folio(struct f2fs_sb_info *sbi, nid_t nid)
+static struct f2fs_cached_block *get_current_nat_cache(struct f2fs_sb_info *sbi,
+		nid_t nid)
 {
-	return f2fs_get_meta_folio_retry(sbi, current_nat_addr(sbi, nid));
+	return f2fs_get_meta_cache_retry(sbi, current_nat_addr(sbi, nid));
 }
 
-static struct folio *get_next_nat_folio(struct f2fs_sb_info *sbi, nid_t nid)
+static struct f2fs_cached_block *get_next_nat_cache(struct f2fs_sb_info *sbi,
+		nid_t nid)
 {
-	struct folio *src_folio;
-	struct folio *dst_folio;
+	struct f2fs_cached_block *src_entry;
+	struct f2fs_cached_block *dst_entry;
 	pgoff_t dst_off;
-	void *src_addr;
-	void *dst_addr;
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 
 	dst_off = next_nat_addr(sbi, current_nat_addr(sbi, nid));
 
 	/* get current nat block page with lock */
-	src_folio = get_current_nat_folio(sbi, nid);
-	if (IS_ERR(src_folio))
-		return src_folio;
-	dst_folio = f2fs_grab_meta_folio(sbi, dst_off);
-	f2fs_bug_on(sbi, folio_test_dirty(src_folio));
-
-	src_addr = folio_address(src_folio);
-	dst_addr = folio_address(dst_folio);
-	memcpy(dst_addr, src_addr, F2FS_BLKSIZE(sbi));
-	folio_mark_dirty(dst_folio);
-	f2fs_folio_put(src_folio, true);
+	src_entry = get_current_nat_cache(sbi, nid);
+	if (IS_ERR(src_entry))
+		return src_entry;
+	dst_entry = f2fs_grab_meta_cache(sbi, dst_off);
+	f2fs_bug_on(sbi, f2fs_cache_test_dirty(src_entry));
+
+	memcpy(cache_address(dst_entry), cache_address(src_entry), F2FS_BLKSIZE(sbi));
+	f2fs_mark_cache_dirty(dst_entry);
+	f2fs_put_cache(src_entry, true);
 
 	set_to_next_nat(sbi, nm_i, nid);
 
-	return dst_folio;
+	return dst_entry;
 }
 
 static struct nat_entry *__alloc_nat_entry(struct f2fs_sb_info *sbi,
@@ -583,7 +581,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 	struct f2fs_journal *journal = curseg->journal;
 	nid_t start_nid = f2fs_start_nid(sbi, nid);
 	struct f2fs_nat_block *nat_blk;
-	struct folio *folio = NULL;
+	struct f2fs_cached_block *entry = NULL;
 	struct f2fs_nat_entry ne;
 	struct nat_entry *e;
 	pgoff_t index;
@@ -638,14 +636,14 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 	index = current_nat_addr(sbi, nid);
 	f2fs_up_read_trace(&nm_i->nat_tree_lock, &lc);
 
-	folio = f2fs_get_meta_folio(sbi, index);
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+	entry = f2fs_get_meta_cache(sbi, index);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
 
-	nat_blk = folio_address(folio);
+	nat_blk = cache_address(entry);
 	ne = nat_blk->entries[nid - start_nid];
 	node_info_from_raw_nat(ni, &ne);
-	f2fs_folio_put(folio, true);
+	f2fs_put_cache(entry, true);
 sanity_check:
 	if (__is_valid_data_blkaddr(ni->blk_addr) &&
 		!f2fs_is_valid_blkaddr(sbi, ni->blk_addr,
@@ -1635,7 +1633,7 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 out_put_err:
 	/* ENOENT comes from read_node_folio which is not an error. */
 	if (err != -ENOENT)
-		f2fs_handle_page_eio(sbi, folio, NODE);
+		f2fs_handle_page_eio(sbi, folio->index, NODE);
 	f2fs_folio_put(folio, true);
 	return ERR_PTR(err);
 }
@@ -2617,6 +2615,7 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 						bool sync, bool mount)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	struct f2fs_cached_block *entry = NULL;
 	int i = 0, ret;
 	nid_t nid = nm_i->next_scan_nid;
 	struct f2fs_lock_context lc;
@@ -2643,7 +2642,7 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 	}
 
 	/* readahead nat pages to be scanned */
-	f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(sbi, nid), FREE_NID_PAGES,
+	f2fs_ra_meta_caches(sbi, NAT_BLOCK_OFFSET(sbi, nid), FREE_NID_PAGES,
 							META_NAT, true);
 
 	f2fs_down_read_trace(&nm_i->nat_tree_lock, &lc);
@@ -2651,14 +2650,14 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 	while (1) {
 		if (!test_bit_le(NAT_BLOCK_OFFSET(sbi, nid),
 						nm_i->nat_block_bitmap)) {
-			struct folio *folio = get_current_nat_folio(sbi, nid);
+			entry = get_current_nat_cache(sbi, nid);
 
-			if (IS_ERR(folio)) {
-				ret = PTR_ERR(folio);
+			if (IS_ERR(entry)) {
+				ret = PTR_ERR(entry);
 			} else {
-				ret = scan_nat_page(sbi, folio_address(folio),
+				ret = scan_nat_page(sbi, cache_address(entry),
 						nid);
-				f2fs_folio_put(folio, true);
+				f2fs_put_cache(entry, true);
 			}
 
 			if (ret) {
@@ -2692,7 +2691,7 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 
 	f2fs_up_read_trace(&nm_i->nat_tree_lock, &lc);
 
-	f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(sbi, nm_i->next_scan_nid),
+	f2fs_ra_meta_caches(sbi, NAT_BLOCK_OFFSET(sbi, nm_i->next_scan_nid),
 					nm_i->ra_nid_pages, META_NAT, false);
 
 	return 0;
@@ -2847,7 +2846,7 @@ int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 	return nr - nr_shrink;
 }
 
-int f2fs_recover_inline_xattr(struct inode *inode, struct folio *folio)
+int f2fs_recover_inline_xattr(struct inode *inode, struct f2fs_cached_block *entry)
 {
 	void *src_addr, *dst_addr;
 	size_t inline_size;
@@ -2858,7 +2857,7 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct folio *folio)
 	if (IS_ERR(ifolio))
 		return PTR_ERR(ifolio);
 
-	ri = F2FS_INODE(folio);
+	ri = &CACHED_NODE(entry)->i;
 	if (ri->i_inline & F2FS_INLINE_XATTR) {
 		if (!f2fs_has_inline_xattr(inode)) {
 			set_inode_flag(inode, FI_INLINE_XATTR);
@@ -2873,7 +2872,7 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct folio *folio)
 	}
 
 	dst_addr = inline_xattr_addr(inode, ifolio);
-	src_addr = inline_xattr_addr(inode, folio);
+	src_addr = inline_xattr_addr(inode, cache_folio(entry));
 	inline_size = inline_xattr_size(inode);
 
 	f2fs_folio_wait_writeback(ifolio, NODE, true, true);
@@ -2884,7 +2883,7 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct folio *folio)
 	return 0;
 }
 
-int f2fs_recover_xattr_data(struct inode *inode, struct folio *folio)
+int f2fs_recover_xattr_data(struct inode *inode, struct f2fs_cached_block *entry)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	nid_t prev_xnid = F2FS_I(inode)->i_xattr_nid;
@@ -2922,8 +2921,8 @@ int f2fs_recover_xattr_data(struct inode *inode, struct folio *folio)
 	f2fs_update_inode_page(inode);
 
 	/* 3: update and set xattr node page dirty */
-	if (folio) {
-		memcpy(F2FS_NODE(xfolio), F2FS_NODE(folio),
+	if (entry) {
+		memcpy(F2FS_NODE(xfolio), CACHED_NODE(entry),
 				VALID_XATTR_BLOCK_SIZE(inode));
 		folio_mark_dirty(xfolio);
 	}
@@ -2932,10 +2931,10 @@ int f2fs_recover_xattr_data(struct inode *inode, struct folio *folio)
 	return 0;
 }
 
-int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct folio *folio)
+int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry)
 {
 	struct f2fs_inode *src, *dst;
-	nid_t ino = ino_of_node(sbi, folio);
+	nid_t ino = ino_of_node(sbi, cache_folio(entry));
 	struct node_info old_ni, new_ni;
 	struct folio *ifolio;
 	int err;
@@ -2961,7 +2960,7 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct folio *folio)
 	fill_node_footer(sbi, ifolio, ino, ino, 0, true);
 	set_cold_node(sbi, ifolio, false);
 
-	src = F2FS_INODE(folio);
+	src = &CACHED_NODE(entry)->i;
 	dst = F2FS_INODE(ifolio);
 
 	memcpy(dst, src, offsetof(struct f2fs_inode, i_ext));
@@ -3019,23 +3018,23 @@ int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 		nrpages = bio_max_segs(last_offset - i);
 
 		/* readahead node pages */
-		f2fs_ra_meta_pages(sbi, addr, nrpages, META_POR, true);
+		f2fs_ra_meta_caches(sbi, addr, nrpages, META_POR, true);
 
 		for (idx = addr; idx < addr + nrpages; idx++) {
-			struct folio *folio = f2fs_get_tmp_folio(sbi, idx);
+			struct f2fs_cached_block *entry =
+				f2fs_get_tmp_cache(sbi, idx);
 
-			if (IS_ERR(folio))
-				return PTR_ERR(folio);
+			if (IS_ERR(entry))
+				return PTR_ERR(entry);
 
-			sum_entry->nid = F2FS_NODE_FOOTER(sbi, folio)->nid;
+			sum_entry->nid = F2FS_NODE_FOOTER(sbi, cache_folio(entry))->nid;
 			sum_entry->version = 0;
 			sum_entry->ofs_in_node = 0;
 			sum_entry++;
-			f2fs_folio_put(folio, true);
+			f2fs_put_cache(entry, true);
 		}
 
-		invalidate_mapping_pages(META_MAPPING(sbi), addr,
-							addr + nrpages);
+		f2fs_truncate_meta_caches(sbi, addr, nrpages);
 	}
 	return 0;
 }
@@ -3145,7 +3144,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	bool to_journal = true;
 	struct f2fs_nat_block *nat_blk;
 	struct nat_entry *ne, *cur;
-	struct folio *folio = NULL;
+	struct f2fs_cached_block *entry = NULL;
 
 	/*
 	 * there are two steps to flush nat entries:
@@ -3159,11 +3158,11 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	if (to_journal) {
 		down_write(&curseg->journal_rwsem);
 	} else {
-		folio = get_next_nat_folio(sbi, start_nid);
-		if (IS_ERR(folio))
-			return PTR_ERR(folio);
+		entry = get_next_nat_cache(sbi, start_nid);
+		if (IS_ERR(entry))
+			return PTR_ERR(entry);
 
-		nat_blk = folio_address(folio);
+		nat_blk = cache_address(entry);
 		f2fs_bug_on(sbi, !nat_blk);
 	}
 
@@ -3200,7 +3199,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		up_write(&curseg->journal_rwsem);
 	} else {
 		__update_nat_bits(sbi, start_nid, nat_blk);
-		f2fs_folio_put(folio, true);
+		f2fs_put_cache(entry, true);
 	}
 
 	/* Allow dirty nats by node block allocation in write_begin */
@@ -3272,7 +3271,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			__has_cursum_space(sbi, journal,
 					entry_count, NAT_JOURNAL))
 			continue;
-		f2fs_ra_meta_pages(sbi, set->set, 1, META_NAT, true);
+		f2fs_ra_meta_caches(sbi, set->set, 1, META_NAT, true);
 	}
 	/* flush dirty nats in nat entry set */
 	list_for_each_entry_safe(set, tmp, &sets, set_list) {
@@ -3309,15 +3308,15 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 	nat_bits_addr = __start_cp_addr(sbi) + BLKS_PER_SEG(sbi) -
 						nm_i->nat_bits_blocks;
 	for (i = 0; i < nm_i->nat_bits_blocks; i++) {
-		struct folio *folio;
+		struct f2fs_cached_block *entry;
 
-		folio = f2fs_get_meta_folio(sbi, nat_bits_addr++);
-		if (IS_ERR(folio))
-			return PTR_ERR(folio);
+		entry = f2fs_get_meta_cache(sbi, nat_bits_addr++);
+		if (IS_ERR(entry))
+			return PTR_ERR(entry);
 
 		memcpy(nm_i->nat_bits + F2FS_BLK_TO_BYTES(sbi, i),
-					folio_address(folio), F2FS_BLKSIZE(sbi));
-		f2fs_folio_put(folio, true);
+					cache_address(entry), F2FS_BLKSIZE(sbi));
+		f2fs_put_cache(entry, true);
 	}
 
 	cp_ver |= (cur_cp_crc(ckpt) << 32);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index ba3649e6190e..93564e532f2f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -182,33 +182,33 @@ static const char *recover_printable_name(struct inode *inode,
 	return raw->i_name;
 }
 
-static int recover_dentry(struct inode *inode, struct folio *ifolio,
+static int recover_dentry(struct inode *inode, struct f2fs_cached_block *entry,
 						struct list_head *dir_list)
 {
-	struct f2fs_inode *raw_inode = F2FS_INODE(ifolio);
+	struct f2fs_inode *raw_inode = &CACHED_NODE(entry)->i;
 	nid_t pino = le32_to_cpu(raw_inode->i_pino);
 	struct f2fs_dir_entry *de;
 	struct f2fs_filename fname;
 	struct qstr usr_fname;
 	struct folio *folio;
 	struct inode *dir, *einode;
-	struct fsync_inode_entry *entry;
+	struct fsync_inode_entry *fsync_entry;
 	int err = 0;
 	const char *name;
 	int name_len;
 
-	entry = get_fsync_inode(dir_list, pino);
-	if (!entry) {
-		entry = add_fsync_inode(F2FS_I_SB(inode), dir_list,
+	fsync_entry = get_fsync_inode(dir_list, pino);
+	if (!fsync_entry) {
+		fsync_entry = add_fsync_inode(F2FS_I_SB(inode), dir_list,
 							pino, false);
-		if (IS_ERR(entry)) {
-			dir = ERR_CAST(entry);
-			err = PTR_ERR(entry);
+		if (IS_ERR(fsync_entry)) {
+			dir = ERR_CAST(fsync_entry);
+			err = PTR_ERR(fsync_entry);
 			goto out;
 		}
 	}
 
-	dir = entry->inode;
+	dir = fsync_entry->inode;
 	err = init_recovered_filename(dir, inode, raw_inode, &fname, &usr_fname);
 	if (err)
 		goto out;
@@ -256,14 +256,14 @@ static int recover_dentry(struct inode *inode, struct folio *ifolio,
 out:
 	name = recover_printable_name(inode, raw_inode, &name_len);
 	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, dir = %llu, err = %d",
-		    __func__, ino_of_node(F2FS_I_SB(inode), ifolio), name_len, name,
+		    __func__, ino_of_node(F2FS_I_SB(inode), cache_folio(entry)), name_len, name,
 		    IS_ERR(dir) ? 0 : dir->i_ino, err);
 	return err;
 }
 
-static int recover_quota_data(struct inode *inode, struct folio *folio)
+static int recover_quota_data(struct inode *inode, struct f2fs_cached_block *entry)
 {
-	struct f2fs_inode *raw = F2FS_INODE(folio);
+	struct f2fs_inode *raw = &CACHED_NODE(entry)->i;
 	struct iattr attr;
 	uid_t i_uid = le32_to_cpu(raw->i_uid);
 	gid_t i_gid = le32_to_cpu(raw->i_gid);
@@ -300,9 +300,9 @@ static void recover_inline_flags(struct inode *inode, struct f2fs_inode *ri)
 		clear_inode_flag(inode, FI_DATA_EXIST);
 }
 
-static int recover_inode(struct inode *inode, struct folio *folio)
+static int recover_inode(struct inode *inode, struct f2fs_cached_block *entry)
 {
-	struct f2fs_inode *raw = F2FS_INODE(folio);
+	struct f2fs_inode *raw = &CACHED_NODE(entry)->i;
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	const char *name;
 	int name_len;
@@ -310,7 +310,7 @@ static int recover_inode(struct inode *inode, struct folio *folio)
 
 	inode->i_mode = le16_to_cpu(raw->i_mode);
 
-	err = recover_quota_data(inode, folio);
+	err = recover_quota_data(inode, entry);
 	if (err)
 		return err;
 
@@ -357,7 +357,7 @@ static int recover_inode(struct inode *inode, struct folio *folio)
 	name = recover_printable_name(inode, raw, &name_len);
 
 	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, inline = %x",
-		    __func__, ino_of_node(F2FS_I_SB(inode), folio), name_len, name,
+		    __func__, ino_of_node(F2FS_I_SB(inode), cache_folio(entry)), name_len, name,
 		    raw->i_inline);
 	return 0;
 }
@@ -386,30 +386,30 @@ static int sanity_check_node_chain(struct f2fs_sb_info *sbi, block_t blkaddr,
 		return 0;
 
 	for (i = 0; i < 2; i++) {
-		struct folio *folio;
+		struct f2fs_cached_block *entry;
 
 		if (!f2fs_is_valid_blkaddr(sbi, *blkaddr_fast, META_POR)) {
 			*is_detecting = false;
 			return 0;
 		}
 
-		folio = f2fs_get_tmp_folio(sbi, *blkaddr_fast);
-		if (IS_ERR(folio))
-			return PTR_ERR(folio);
+		entry = f2fs_get_tmp_cache(sbi, *blkaddr_fast);
+		if (IS_ERR(entry))
+			return PTR_ERR(entry);
 
-		if (!is_recoverable_dnode(sbi, folio)) {
-			f2fs_folio_put(folio, true);
+		if (!is_recoverable_dnode(sbi, cache_folio(entry))) {
+			f2fs_put_cache(entry, true);
 			*is_detecting = false;
 			return 0;
 		}
 
 		ra_blocks = adjust_por_ra_blocks(sbi, ra_blocks, *blkaddr_fast,
-					next_blkaddr_of_node(sbi, folio));
+					next_blkaddr_of_node(sbi, cache_folio(entry)));
 
-		*blkaddr_fast = next_blkaddr_of_node(sbi, folio);
-		f2fs_folio_put(folio, true);
+		*blkaddr_fast = next_blkaddr_of_node(sbi, cache_folio(entry));
+		f2fs_put_cache(entry, true);
 
-		f2fs_ra_meta_pages_cond(sbi, *blkaddr_fast, ra_blocks);
+		f2fs_ra_meta_caches_cond(sbi, *blkaddr_fast, ra_blocks);
 	}
 
 	if (*blkaddr_fast == blkaddr) {
@@ -434,45 +434,45 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 	blkaddr_fast = blkaddr;
 
 	while (1) {
-		struct fsync_inode_entry *entry;
-		struct folio *folio;
+		struct fsync_inode_entry *fsync_entry;
+		struct f2fs_cached_block *entry;
 
 		if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR))
 			return 0;
 
-		folio = f2fs_get_tmp_folio(sbi, blkaddr);
-		if (IS_ERR(folio)) {
-			err = PTR_ERR(folio);
+		entry = f2fs_get_tmp_cache(sbi, blkaddr);
+		if (IS_ERR(entry)) {
+			err = PTR_ERR(entry);
 			break;
 		}
 
-		if (!is_recoverable_dnode(sbi, folio)) {
-			f2fs_folio_put(folio, true);
+		if (!is_recoverable_dnode(sbi, cache_folio(entry))) {
+			f2fs_put_cache(entry, true);
 			break;
 		}
 
-		if (!is_fsync_dnode(sbi, folio))
+		if (!is_fsync_dnode(sbi, cache_folio(entry)))
 			goto next;
 
-		entry = get_fsync_inode(head, ino_of_node(sbi, folio));
-		if (!entry) {
+		fsync_entry = get_fsync_inode(head, ino_of_node(sbi, cache_folio(entry)));
+		if (!fsync_entry) {
 			bool quota_inode = false;
 
 			if (!check_only &&
-					IS_INODE(sbi, folio) &&
-					is_dent_dnode(sbi, folio)) {
-				err = f2fs_recover_inode_page(sbi, folio);
+					IS_INODE(sbi, cache_folio(entry)) &&
+					is_dent_dnode(sbi, cache_folio(entry))) {
+				err = f2fs_recover_inode_page(sbi, entry);
 				if (err) {
-					f2fs_folio_put(folio, true);
+					f2fs_put_cache(entry, true);
 					break;
 				}
 				quota_inode = true;
 			}
 
-			entry = add_fsync_inode(sbi, head, ino_of_node(sbi, folio),
+			fsync_entry = add_fsync_inode(sbi, head, ino_of_node(sbi, cache_folio(entry)),
 								quota_inode);
-			if (IS_ERR(entry)) {
-				err = PTR_ERR(entry);
+			if (IS_ERR(fsync_entry)) {
+				err = PTR_ERR(fsync_entry);
 				/*
 				 * CP | dnode(F) | inode(DF)
 				 * For this case, we should not give up now.
@@ -482,18 +482,18 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 						*new_inode = true;
 					goto next;
 				}
-				f2fs_folio_put(folio, true);
+				f2fs_put_cache(entry, true);
 				break;
 			}
 		}
-		entry->blkaddr = blkaddr;
+		fsync_entry->blkaddr = blkaddr;
 
-		if (IS_INODE(sbi, folio) && is_dent_dnode(sbi, folio))
-			entry->last_dentry = blkaddr;
+		if (IS_INODE(sbi, cache_folio(entry)) && is_dent_dnode(sbi, cache_folio(entry)))
+			fsync_entry->last_dentry = blkaddr;
 next:
 		/* check next segment */
-		blkaddr = next_blkaddr_of_node(sbi, folio);
-		f2fs_folio_put(folio, true);
+		blkaddr = next_blkaddr_of_node(sbi, cache_folio(entry));
+		f2fs_put_cache(entry, true);
 
 		err = sanity_check_node_chain(sbi, blkaddr, &blkaddr_fast,
 				&is_detecting);
@@ -519,7 +519,8 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	unsigned short blkoff = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
 	struct f2fs_summary_block *sum_node;
 	struct f2fs_summary sum;
-	struct folio *sum_folio, *node_folio;
+	struct f2fs_cached_block *entry = NULL;
+	struct folio *node_folio;
 	struct dnode_of_data tdn = *dn;
 	nid_t ino, nid;
 	struct inode *inode;
@@ -541,12 +542,12 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 		}
 	}
 
-	sum_folio = f2fs_get_sum_folio(sbi, segno);
-	if (IS_ERR(sum_folio))
-		return PTR_ERR(sum_folio);
-	sum_node = SUM_BLK_PAGE_ADDR(sbi, sum_folio, segno);
+	entry = f2fs_get_sum_cache(sbi, segno);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+	sum_node = SUM_BLK_ENTRY_ADDR(sbi, entry, segno);
 	sum = sum_entries(sum_node)[blkoff];
-	f2fs_folio_put(sum_folio, true);
+	f2fs_put_cache(entry, true);
 got_it:
 	/* Use the locked dnode page and inode */
 	nid = le32_to_cpu(sum.nid);
@@ -645,7 +646,7 @@ static int f2fs_reserve_new_block_retry(struct dnode_of_data *dn)
 }
 
 static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
-					struct folio *folio)
+					struct f2fs_cached_block *entry)
 {
 	struct dnode_of_data dn;
 	struct node_info ni;
@@ -653,19 +654,19 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	int err = 0, recovered = 0;
 
 	/* step 1: recover xattr */
-	if (IS_INODE(sbi, folio)) {
-		err = f2fs_recover_inline_xattr(inode, folio);
+	if (IS_INODE(sbi, cache_folio(entry))) {
+		err = f2fs_recover_inline_xattr(inode, entry);
 		if (err)
 			goto out;
-	} else if (f2fs_has_xattr_block(ofs_of_node(sbi, folio))) {
-		err = f2fs_recover_xattr_data(inode, folio);
+	} else if (f2fs_has_xattr_block(ofs_of_node(sbi, cache_folio(entry)))) {
+		err = f2fs_recover_xattr_data(inode, entry);
 		if (!err)
 			recovered++;
 		goto out;
 	}
 
 	/* step 2: recover inline data */
-	err = f2fs_recover_inline_data(inode, folio);
+	err = f2fs_recover_inline_data(inode, entry);
 	if (err) {
 		if (err == 1)
 			err = 0;
@@ -673,8 +674,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	}
 
 	/* step 3: recover data indices */
-	start = f2fs_start_bidx_of_node(ofs_of_node(sbi, folio), inode);
-	end = start + ADDRS_PER_PAGE(folio, inode);
+	start = f2fs_start_bidx_of_node(ofs_of_node(sbi, cache_folio(entry)), inode);
+	end = start + addrs_per_page(inode, IS_INODE(sbi, cache_folio(entry)));
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 retry_dn:
@@ -693,12 +694,12 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	if (err)
 		goto err;
 
-	f2fs_bug_on(sbi, ni.ino != ino_of_node(sbi, folio));
+	f2fs_bug_on(sbi, ni.ino != ino_of_node(sbi, cache_folio(entry)));
 
-	if (ofs_of_node(sbi, dn.node_folio) != ofs_of_node(sbi, folio)) {
+	if (ofs_of_node(sbi, dn.node_folio) != ofs_of_node(sbi, cache_folio(entry))) {
 		f2fs_warn(sbi, "Inconsistent ofs_of_node, ino:%llu, ofs:%u, %u",
 			  inode->i_ino, ofs_of_node(sbi, dn.node_folio),
-			  ofs_of_node(sbi, folio));
+			  ofs_of_node(sbi, cache_folio(entry)));
 		err = -EFSCORRUPTED;
 		f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
 		fserror_report_file_metadata(dn.inode, err, GFP_NOFS);
@@ -709,7 +710,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		block_t src, dest;
 
 		src = f2fs_data_blkaddr(&dn);
-		dest = data_blkaddr(dn.inode, folio, dn.ofs_in_node);
+		dest = data_blkaddr(dn.inode, cache_folio(entry), dn.ofs_in_node);
 
 		if (__is_valid_data_blkaddr(src) &&
 			!f2fs_is_valid_blkaddr(sbi, src, META_POR)) {
@@ -784,16 +785,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		}
 	}
 
-	copy_node_footer(sbi, dn.node_folio, folio);
+	copy_node_footer(sbi, dn.node_folio, cache_folio(entry));
 	fill_node_footer(sbi, dn.node_folio, dn.nid, ni.ino,
-					ofs_of_node(sbi, folio), false);
+					ofs_of_node(sbi, cache_folio(entry)), false);
 	folio_mark_dirty(dn.node_folio);
 err:
 	f2fs_put_dnode(&dn);
 out:
 	f2fs_notice(sbi, "recover_data: ino = %llx, nid = %x (i_size: %s), "
 		    "range (%u, %u), recovered = %d, err = %d",
-		    inode->i_ino, nid_of_node(sbi, folio),
+		    inode->i_ino, nid_of_node(sbi, cache_folio(entry)),
 		    file_keep_isize(inode) ? "keep" : "recover",
 		    start, end, recovered, err);
 	return err;
@@ -820,26 +821,26 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 	blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
 
 	while (1) {
-		struct fsync_inode_entry *entry;
-		struct folio *folio;
+		struct fsync_inode_entry *fsync_entry;
+		struct f2fs_cached_block *entry;
 
 		if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR))
 			break;
 
-		folio = f2fs_get_tmp_folio(sbi, blkaddr);
-		if (IS_ERR(folio)) {
-			err = PTR_ERR(folio);
+		entry = f2fs_get_tmp_cache(sbi, blkaddr);
+		if (IS_ERR(entry)) {
+			err = PTR_ERR(entry);
 			break;
 		}
 
-		if (!is_recoverable_dnode(sbi, folio)) {
-			f2fs_folio_put(folio, true);
+		if (!is_recoverable_dnode(sbi, cache_folio(entry))) {
+			f2fs_put_cache(entry, true);
 			break;
 		}
 		recoverable_dnode++;
 
-		entry = get_fsync_inode(inode_list, ino_of_node(sbi, folio));
-		if (!entry)
+		fsync_entry = get_fsync_inode(inode_list, ino_of_node(sbi, cache_folio(entry)));
+		if (!fsync_entry)
 			goto next;
 		fsynced_dnode++;
 		/*
@@ -847,40 +848,40 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 		 * In this case, we can lose the latest inode(x).
 		 * So, call recover_inode for the inode update.
 		 */
-		if (IS_INODE(sbi, folio)) {
-			err = recover_inode(entry->inode, folio);
+		if (IS_INODE(sbi, cache_folio(entry))) {
+			err = recover_inode(fsync_entry->inode, entry);
 			if (err) {
-				f2fs_folio_put(folio, true);
+				f2fs_put_cache(entry, true);
 				break;
 			}
 			recovered_inode++;
 		}
-		if (entry->last_dentry == blkaddr) {
-			err = recover_dentry(entry->inode, folio, dir_list);
+		if (fsync_entry->last_dentry == blkaddr) {
+			err = recover_dentry(fsync_entry->inode, entry, dir_list);
 			if (err) {
-				f2fs_folio_put(folio, true);
+				f2fs_put_cache(entry, true);
 				break;
 			}
 			recovered_dentry++;
 		}
-		err = do_recover_data(sbi, entry->inode, folio);
+		err = do_recover_data(sbi, fsync_entry->inode, entry);
 		if (err) {
-			f2fs_folio_put(folio, true);
+			f2fs_put_cache(entry, true);
 			break;
 		}
 		recovered_dnode++;
 
-		if (entry->blkaddr == blkaddr)
-			list_move_tail(&entry->list, tmp_inode_list);
+		if (fsync_entry->blkaddr == blkaddr)
+			list_move_tail(&fsync_entry->list, tmp_inode_list);
 next:
 		ra_blocks = adjust_por_ra_blocks(sbi, ra_blocks, blkaddr,
-					next_blkaddr_of_node(sbi, folio));
+					next_blkaddr_of_node(sbi, cache_folio(entry)));
 
 		/* check next segment */
-		blkaddr = next_blkaddr_of_node(sbi, folio);
-		f2fs_folio_put(folio, true);
+		blkaddr = next_blkaddr_of_node(sbi, cache_folio(entry));
+		f2fs_put_cache(entry, true);
 
-		f2fs_ra_meta_pages_cond(sbi, blkaddr, ra_blocks);
+		f2fs_ra_meta_caches_cond(sbi, blkaddr, ra_blocks);
 		total_dnode++;
 	}
 	if (!err)
@@ -937,12 +938,11 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	destroy_fsync_dnodes(&tmp_inode_list, err);
 
 	/* truncate meta pages to be used by the recovery */
-	truncate_inode_pages_range(META_MAPPING(sbi),
-			(loff_t)MAIN_BLKADDR(sbi) << PAGE_SHIFT, -1);
-
+	f2fs_truncate_meta_caches(sbi, MAIN_BLKADDR(sbi),
+				MAX_BLKADDR(sbi) - MAIN_BLKADDR(sbi));
 	if (err) {
 		truncate_inode_pages_final(NODE_MAPPING(sbi));
-		truncate_inode_pages_final(META_MAPPING(sbi));
+		f2fs_truncate_meta_caches(sbi, 0, ULONG_MAX);
 	}
 
 	/*
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0b6267d0354e..97f29758c6bb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2830,63 +2830,62 @@ int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra)
 	return 3;
 }
 
-/*
- * Caller should put this summary folio
- */
-struct folio *f2fs_get_sum_folio(struct f2fs_sb_info *sbi, unsigned int segno)
+
+struct f2fs_cached_block *f2fs_get_sum_cache(struct f2fs_sb_info *sbi,
+		unsigned int segno)
 {
 	if (unlikely(f2fs_cp_error(sbi)))
 		return ERR_PTR(-EIO);
-	return f2fs_get_meta_folio_retry(sbi, GET_SUM_BLOCK(sbi, segno));
+	return f2fs_get_meta_cache_retry(sbi, GET_SUM_BLOCK(sbi, segno));
 }
 
 void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
 					void *src, block_t blk_addr)
 {
-	struct folio *folio;
+	struct f2fs_cached_block *entry;
 
 	if (!f2fs_sb_has_packed_ssa(sbi))
-		folio = f2fs_grab_meta_folio(sbi, blk_addr);
+		entry = f2fs_grab_meta_cache(sbi, blk_addr);
 	else
-		folio = f2fs_get_meta_folio_retry(sbi, blk_addr);
+		entry = f2fs_get_meta_cache_retry(sbi, blk_addr);
 
-	if (IS_ERR(folio))
+	if (IS_ERR(entry))
 		return;
 
-	memcpy(folio_address(folio), src, F2FS_BLKSIZE(sbi));
-	folio_mark_dirty(folio);
-	f2fs_folio_put(folio, true);
+	memcpy(cache_address(entry), src, F2FS_BLKSIZE(sbi));
+	f2fs_mark_cache_dirty(entry);
+	f2fs_put_cache(entry, true);
 }
 
 static void write_sum_page(struct f2fs_sb_info *sbi,
 		struct f2fs_summary_block *sum_blk, unsigned int segno)
 {
-	struct folio *folio;
+	struct f2fs_cached_block *entry;
 
 	if (!f2fs_sb_has_packed_ssa(sbi))
 		return f2fs_update_meta_page(sbi, (void *)sum_blk,
 				GET_SUM_BLOCK(sbi, segno));
 
-	folio = f2fs_get_sum_folio(sbi, segno);
-	if (IS_ERR(folio))
+	entry = f2fs_get_sum_cache(sbi, segno);
+	if (IS_ERR(entry))
 		return;
 
-	memcpy(SUM_BLK_PAGE_ADDR(sbi, folio, segno), sum_blk,
+	memcpy(SUM_BLK_ENTRY_ADDR(sbi, entry, segno), sum_blk,
 			sbi->sum_blocksize);
-	folio_mark_dirty(folio);
-	f2fs_folio_put(folio, true);
+	f2fs_mark_cache_dirty(entry);
+	f2fs_put_cache(entry, true);
 }
 
 static void write_current_sum_page(struct f2fs_sb_info *sbi,
 						int type, block_t blk_addr)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
-	struct folio *folio = f2fs_grab_meta_folio(sbi, blk_addr);
+	struct f2fs_cached_block *entry = f2fs_grab_meta_cache(sbi, blk_addr);
 	struct f2fs_summary_block *src = curseg->sum_blk;
 	struct f2fs_summary_block *dst;
 
-	dst = folio_address(folio);
-	memset(dst, 0, PAGE_SIZE);
+	dst = cache_address(entry);
+	memset(dst, 0, sbi->blocksize);
 
 	mutex_lock(&curseg->curseg_mutex);
 
@@ -2899,8 +2898,8 @@ static void write_current_sum_page(struct f2fs_sb_info *sbi,
 
 	mutex_unlock(&curseg->curseg_mutex);
 
-	folio_mark_dirty(folio);
-	f2fs_folio_put(folio, true);
+	f2fs_mark_cache_dirty(entry);
+	f2fs_put_cache(entry, true);
 }
 
 static int is_next_segment_free(struct f2fs_sb_info *sbi,
@@ -3216,7 +3215,7 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	unsigned int new_segno = curseg->next_segno;
 	struct f2fs_summary_block *sum_node;
-	struct folio *sum_folio;
+	struct f2fs_cached_block *entry = NULL;
 
 	if (curseg->inited)
 		write_sum_page(sbi, curseg->sum_blk, curseg->segno);
@@ -3232,15 +3231,15 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
 	curseg->alloc_type = SSR;
 	curseg->next_blkoff = __next_free_blkoff(sbi, curseg->segno, 0);
 
-	sum_folio = f2fs_get_sum_folio(sbi, new_segno);
-	if (IS_ERR(sum_folio)) {
+	entry = f2fs_get_sum_cache(sbi, new_segno);
+	if (IS_ERR(entry)) {
 		/* GC won't be able to use stale summary pages by cp_error */
 		memset(curseg->sum_blk, 0, sbi->sum_entry_size);
-		return PTR_ERR(sum_folio);
+		return PTR_ERR(entry);
 	}
-	sum_node = SUM_BLK_PAGE_ADDR(sbi, sum_folio, new_segno);
+	sum_node = SUM_BLK_ENTRY_ADDR(sbi, entry, new_segno);
 	memcpy(curseg->sum_blk, sum_node, sbi->sum_entry_size);
-	f2fs_folio_put(sum_folio, true);
+	f2fs_put_cache(entry, true);
 	return 0;
 }
 
@@ -4183,8 +4182,9 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 		f2fs_up_read(&fio->sbi->io_order_lock);
 }
 
-void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct folio *folio,
-					enum iostat_type io_type)
+void f2fs_do_write_meta_cache(struct f2fs_sb_info *sbi,
+			struct f2fs_cached_block *entry,
+			enum iostat_type io_type)
 {
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
@@ -4192,20 +4192,21 @@ void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct folio *folio,
 		.temp = HOT,
 		.op = REQ_OP_WRITE,
 		.op_flags = REQ_SYNC | REQ_META | REQ_PRIO,
-		.old_blkaddr = folio->index,
-		.new_blkaddr = folio->index,
-		.folio = folio,
+		.old_blkaddr = entry->index,
+		.new_blkaddr = entry->index,
 		.encrypted_page = NULL,
 		.in_list = 0,
+		.cache_entry = entry,
+		.is_cache = 1,
 	};
 
-	if (unlikely(folio->index >= MAIN_BLKADDR(sbi)))
+	if (unlikely(entry->index >= MAIN_BLKADDR(sbi)))
 		fio.op_flags &= ~REQ_META;
 
-	folio_start_writeback(folio);
-	f2fs_submit_page_write(&fio);
+	f2fs_start_cache_writeback(entry);
+	f2fs_submit_cache_write(&fio);
 
-	stat_inc_meta_count(sbi, folio->index);
+	stat_inc_meta_count(sbi, entry->index);
 	f2fs_update_iostat(sbi, NULL, io_type, F2FS_BLKSIZE(sbi));
 }
 
@@ -4264,7 +4265,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	}
 
 	if (fio->meta_gc)
-		f2fs_truncate_meta_inode_pages(sbi, fio->new_blkaddr, 1);
+		f2fs_truncate_meta_caches(sbi, fio->new_blkaddr, 1);
 
 	stat_inc_inplace_blocks(fio->sbi);
 
@@ -4430,7 +4431,7 @@ void f2fs_folio_wait_writeback(struct folio *folio, enum page_type type,
 void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct folio *cfolio;
+	struct f2fs_cached_block *entry;
 
 	if (!f2fs_meta_inode_gc_required(inode))
 		return;
@@ -4438,11 +4439,12 @@ void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr)
 	if (!__is_valid_data_blkaddr(blkaddr))
 		return;
 
-	cfolio = filemap_lock_folio(META_MAPPING(sbi), blkaddr);
-	if (!IS_ERR(cfolio)) {
-		f2fs_folio_wait_writeback(cfolio, DATA, true, true);
-		f2fs_folio_put(cfolio, true);
-	}
+	entry = f2fs_find_cache(META_CACHE(sbi), blkaddr, 0);
+	if (IS_ERR(entry))
+		return;
+	f2fs_lock_cache(entry);
+	f2fs_cache_wait_writeback_cond(entry, DATA);
+	f2fs_put_cache(entry, true);
 }
 
 void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
@@ -4457,7 +4459,7 @@ void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 	for (i = 0; i < len; i++)
 		f2fs_wait_on_block_writeback(inode, blkaddr + i);
 
-	f2fs_truncate_meta_inode_pages(sbi, blkaddr, len);
+	f2fs_truncate_meta_caches(sbi, blkaddr, len);
 }
 
 static int read_compacted_summaries(struct f2fs_sb_info *sbi)
@@ -4465,16 +4467,16 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	struct curseg_info *seg_i;
 	unsigned char *kaddr;
-	struct folio *folio;
+	struct f2fs_cached_block *entry;
 	block_t start;
 	int i, j, offset;
 
 	start = start_sum_block(sbi);
 
-	folio = f2fs_get_meta_folio(sbi, start++);
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
-	kaddr = folio_address(folio);
+	entry = f2fs_get_meta_cache(sbi, start++);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+	kaddr = cache_address(entry);
 
 	/* Step 1: restore nat cache */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_DATA);
@@ -4511,16 +4513,16 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 						SUM_FOOTER_SIZE)
 				continue;
 
-			f2fs_folio_put(folio, true);
+			f2fs_put_cache(entry, true);
 
-			folio = f2fs_get_meta_folio(sbi, start++);
-			if (IS_ERR(folio))
-				return PTR_ERR(folio);
-			kaddr = folio_address(folio);
+			entry = f2fs_get_meta_cache(sbi, start++);
+			if (IS_ERR(entry))
+				return PTR_ERR(entry);
+			kaddr = cache_address(entry);
 			offset = 0;
 		}
 	}
-	f2fs_folio_put(folio, true);
+	f2fs_put_cache(entry, true);
 	return 0;
 }
 
@@ -4529,7 +4531,7 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	struct f2fs_summary_block *sum;
 	struct curseg_info *curseg;
-	struct folio *new;
+	struct f2fs_cached_block *entry;
 	unsigned short blk_off;
 	unsigned int segno = 0;
 	block_t blk_addr = 0;
@@ -4556,10 +4558,10 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 			blk_addr = GET_SUM_BLOCK(sbi, segno);
 	}
 
-	new = f2fs_get_meta_folio(sbi, blk_addr);
-	if (IS_ERR(new))
-		return PTR_ERR(new);
-	sum = folio_address(new);
+	entry = f2fs_get_meta_cache(sbi, blk_addr);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+	sum = cache_address(entry);
 
 	if (IS_NODESEG(type)) {
 		if (__exist_node_summaries(sbi)) {
@@ -4596,7 +4598,7 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	curseg->next_blkoff = blk_off;
 	mutex_unlock(&curseg->curseg_mutex);
 out:
-	f2fs_folio_put(new, true);
+	f2fs_put_cache(entry, true);
 	return err;
 }
 
@@ -4611,8 +4613,8 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 		int npages = f2fs_npages_for_summary_flush(sbi, true);
 
 		if (npages >= 2)
-			f2fs_ra_meta_pages(sbi, start_sum_block(sbi), npages,
-							META_CP, true);
+			f2fs_ra_meta_caches(sbi, start_sum_block(sbi),
+					npages, META_CP, true);
 
 		/* restore for compacted data summary */
 		err = read_compacted_summaries(sbi);
@@ -4622,7 +4624,7 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 	}
 
 	if (__exist_node_summaries(sbi))
-		f2fs_ra_meta_pages(sbi,
+		f2fs_ra_meta_caches(sbi,
 				sum_blk_addr(sbi, NR_CURSEG_PERSIST_TYPE, type),
 				NR_CURSEG_PERSIST_TYPE - type, META_CP, true);
 
@@ -4645,16 +4647,16 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 
 static void write_compacted_summaries(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
-	struct folio *folio;
+	struct f2fs_cached_block *entry = NULL;
 	unsigned char *kaddr;
 	struct f2fs_summary *summary;
 	struct curseg_info *seg_i;
 	int written_size = 0;
 	int i, j;
 
-	folio = f2fs_grab_meta_folio(sbi, blkaddr++);
-	kaddr = folio_address(folio);
-	memset(kaddr, 0, PAGE_SIZE);
+	entry = f2fs_grab_meta_cache(sbi, blkaddr++);
+	kaddr = cache_address(entry);
+	memset(kaddr, 0, sbi->blocksize);
 
 	/* Step 1: write nat cache */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_DATA);
@@ -4670,10 +4672,10 @@ static void write_compacted_summaries(struct f2fs_sb_info *sbi, block_t blkaddr)
 	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
 		seg_i = CURSEG_I(sbi, i);
 		for (j = 0; j < f2fs_curseg_valid_blocks(sbi, i); j++) {
-			if (!folio) {
-				folio = f2fs_grab_meta_folio(sbi, blkaddr++);
-				kaddr = folio_address(folio);
-				memset(kaddr, 0, PAGE_SIZE);
+			if (!entry) {
+				entry = f2fs_grab_meta_cache(sbi, blkaddr++);
+				kaddr = cache_address(entry);
+				memset(kaddr, 0, sbi->blocksize);
 				written_size = 0;
 			}
 			summary = (struct f2fs_summary *)(kaddr + written_size);
@@ -4684,14 +4686,14 @@ static void write_compacted_summaries(struct f2fs_sb_info *sbi, block_t blkaddr)
 							SUM_FOOTER_SIZE)
 				continue;
 
-			folio_mark_dirty(folio);
-			f2fs_folio_put(folio, true);
-			folio = NULL;
+			f2fs_mark_cache_dirty(entry);
+			f2fs_put_cache(entry, true);
+			entry = NULL;
 		}
 	}
-	if (folio) {
-		folio_mark_dirty(folio);
-		f2fs_folio_put(folio, true);
+	if (entry) {
+		f2fs_mark_cache_dirty(entry);
+		f2fs_put_cache(entry, true);
 	}
 }
 
@@ -4745,29 +4747,29 @@ int f2fs_lookup_journal_in_cursum(struct f2fs_sb_info *sbi,
 	return -1;
 }
 
-static struct folio *get_current_sit_folio(struct f2fs_sb_info *sbi,
+static struct f2fs_cached_block *get_current_sit_cache(struct f2fs_sb_info *sbi,
 					unsigned int segno)
 {
-	return f2fs_get_meta_folio(sbi, current_sit_addr(sbi, segno));
+	return f2fs_get_meta_cache(sbi, current_sit_addr(sbi, segno));
 }
 
-static struct folio *get_next_sit_folio(struct f2fs_sb_info *sbi,
+static struct f2fs_cached_block *get_next_sit_cache(struct f2fs_sb_info *sbi,
 					unsigned int start)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	struct folio *folio;
+	struct f2fs_cached_block *entry;
 	pgoff_t src_off, dst_off;
 
 	src_off = current_sit_addr(sbi, start);
 	dst_off = next_sit_addr(sbi, src_off);
 
-	folio = f2fs_grab_meta_folio(sbi, dst_off);
-	seg_info_to_sit_folio(sbi, folio, start);
+	entry = f2fs_grab_meta_cache(sbi, dst_off);
+	seg_info_to_sit_block(sbi, entry, start);
 
-	folio_mark_dirty(folio);
+	f2fs_mark_cache_dirty(entry);
 	set_to_next_sit(sbi, sit_i, start);
 
-	return folio;
+	return entry;
 }
 
 static struct sit_entry_set *grab_sit_entry_set(void)
@@ -4898,8 +4900,9 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * #2, flush sit entries to sit page.
 	 */
 	list_for_each_entry_safe(ses, tmp, head, set_list) {
-		struct folio *folio = NULL;
+		struct f2fs_cached_block *entry = NULL;
 		struct f2fs_sit_block *raw_sit = NULL;
+
 		unsigned int start_segno = ses->start_segno;
 		unsigned int end = min(start_segno + SIT_ENTRY_PER_BLOCK(sbi),
 						(unsigned long)MAIN_SEGS(sbi));
@@ -4913,8 +4916,8 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		if (to_journal) {
 			down_write(&curseg->journal_rwsem);
 		} else {
-			folio = get_next_sit_folio(sbi, start_segno);
-			raw_sit = folio_address(folio);
+			entry = get_next_sit_cache(sbi, start_segno);
+			raw_sit = cache_address(entry);
 		}
 
 		/* flush dirty sit entries in region of current sit set */
@@ -4959,7 +4962,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		if (to_journal)
 			up_write(&curseg->journal_rwsem);
 		else
-			f2fs_folio_put(folio, true);
+			f2fs_put_cache(entry, true);
 
 		f2fs_bug_on(sbi, ses->entry_cnt);
 		release_sit_entry_set(ses);
@@ -5150,7 +5153,7 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 	block_t sit_valid_blocks[2] = {0, 0};
 
 	do {
-		readed = f2fs_ra_meta_pages(sbi, start_blk, BIO_MAX_VECS,
+		readed = f2fs_ra_meta_caches(sbi, start_blk, BIO_MAX_VECS,
 							META_SIT, true);
 
 		start = start_blk * sit_i->sents_per_block;
@@ -5158,15 +5161,15 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 
 		for (; start < end && start < MAIN_SEGS(sbi); start++) {
 			struct f2fs_sit_block *sit_blk;
-			struct folio *folio;
+			struct f2fs_cached_block *entry;
 
 			se = &sit_i->sentries[start];
-			folio = get_current_sit_folio(sbi, start);
-			if (IS_ERR(folio))
-				return PTR_ERR(folio);
-			sit_blk = folio_address(folio);
+			entry = get_current_sit_cache(sbi, start);
+			if (IS_ERR(entry))
+				return PTR_ERR(entry);
+			sit_blk = cache_address(entry);
 			sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
-			f2fs_folio_put(folio, true);
+			f2fs_put_cache(entry, true);
 
 			err = check_block_count(sbi, start, &sit);
 			if (err)
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index cc0428b614da..3083069c9092 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -96,6 +96,8 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 #define GET_SUM_BLKOFF(sbi, segno) (segno % (sbi)->sums_per_block)
 #define SUM_BLK_PAGE_ADDR(sbi, folio, segno)	\
 	(folio_address(folio) + GET_SUM_BLKOFF(sbi, segno) * (sbi)->sum_blocksize)
+#define SUM_BLK_ENTRY_ADDR(sbi, entry, segno)	\
+	(cache_address(entry) + GET_SUM_BLKOFF(sbi, segno) * (sbi)->sum_blocksize)
 
 #define GET_SUM_TYPE(footer) ((footer)->entry_type)
 #define SET_SUM_TYPE(footer, type) ((footer)->entry_type = (type))
@@ -421,8 +423,8 @@ static inline void __seg_info_to_raw_sit(struct seg_entry *se,
 	rs->mtime = cpu_to_le64(se->mtime);
 }
 
-static inline void seg_info_to_sit_folio(struct f2fs_sb_info *sbi,
-				struct folio *folio, unsigned int start)
+static inline void seg_info_to_sit_block(struct f2fs_sb_info *sbi,
+			struct f2fs_cached_block *entry, unsigned int start)
 {
 	struct f2fs_sit_block *raw_sit;
 	struct seg_entry *se;
@@ -431,7 +433,7 @@ static inline void seg_info_to_sit_folio(struct f2fs_sb_info *sbi,
 					(unsigned long)MAIN_SEGS(sbi));
 	int i;
 
-	raw_sit = folio_address(folio);
+	raw_sit = cache_address(entry);
 	memset(raw_sit, 0, F2FS_BLKSIZE(sbi));
 	for (i = 0; i < end - start; i++) {
 		rs = &raw_sit->entries[i];
@@ -996,6 +998,27 @@ static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
 		return 0;
 }
 
+/*
+ * When writing cache asynchronously, align nr_to_write to BIO_MAX_VECS.
+ */
+static inline long adjust_flush_cache_number(struct f2fs_sb_info *sbi, int type)
+{
+	long nr_to_write;
+
+	switch (type) {
+	case META:
+		nr_to_write = BIO_MAX_VECS;
+		break;
+	case NODE:
+		nr_to_write = BIO_MAX_VECS << 1;
+		break;
+	default:
+		f2fs_bug_on(sbi, 1);
+		return 0;
+	}
+	return nr_to_write;
+}
+
 /*
  * When writing pages, it'd better align nr_to_write for segment size.
  */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ac9e3dcd34ed..53f3b548e201 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1880,8 +1880,7 @@ static int f2fs_drop_inode(struct inode *inode)
 	 * drop useless meta/node dirty pages.
 	 */
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
-		if (inode->i_ino == F2FS_NODE_INO(sbi) ||
-			inode->i_ino == F2FS_META_INO(sbi)) {
+		if (inode->i_ino == F2FS_NODE_INO(sbi)) {
 			trace_f2fs_drop_inode(inode, 1);
 			return 1;
 		}
@@ -1983,8 +1982,7 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
-	if (inode->i_ino == F2FS_NODE_INO(sbi) ||
-			inode->i_ino == F2FS_META_INO(sbi))
+	if (inode->i_ino == F2FS_NODE_INO(sbi))
 		return;
 
 	if (is_inode_flag_set(inode, FI_AUTO_RECOVER))
@@ -2080,9 +2078,10 @@ static void f2fs_put_super(struct super_block *sb)
 
 	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
 
-	if (err || f2fs_cp_error(sbi)) {
+	if (err || f2fs_cp_error(sbi) ||
+		unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
 		truncate_inode_pages_final(NODE_MAPPING(sbi));
-		truncate_inode_pages_final(META_MAPPING(sbi));
+		f2fs_truncate_meta_caches(sbi, 0, ULONG_MAX);
 	}
 
 	f2fs_bug_on(sbi, sbi->fsync_node_num);
@@ -2092,9 +2091,6 @@ static void f2fs_put_super(struct super_block *sb)
 	iput(sbi->node_inode);
 	sbi->node_inode = NULL;
 
-	iput(sbi->meta_inode);
-	sbi->meta_inode = NULL;
-
 	f2fs_destroy_cache(META_CACHE(sbi));
 
 	/* Should check the page counts after dropping all node/meta pages */
@@ -4447,7 +4443,6 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->allocate_section_policy = ALLOCATE_FORWARD_NOHINT;
 	F2FS_ROOT_INO(sbi) = le32_to_cpu(raw_super->root_ino);
 	F2FS_NODE_INO(sbi) = le32_to_cpu(raw_super->node_ino);
-	F2FS_META_INO(sbi) = le32_to_cpu(raw_super->meta_ino);
 	sbi->cur_victim_sec = NULL_SECNO;
 	sbi->gc_mode = GC_NORMAL;
 	sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
@@ -5288,18 +5283,10 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto free_page_array_cache;
 
-	/* get an inode for meta space */
-	sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
-	if (IS_ERR(sbi->meta_inode)) {
-		f2fs_err(sbi, "Failed to read F2FS meta data inode");
-		err = PTR_ERR(sbi->meta_inode);
-		goto free_meta_cache;
-	}
-
 	err = f2fs_get_valid_checkpoint(sbi);
 	if (err) {
 		f2fs_err(sbi, "Failed to get valid F2FS checkpoint");
-		goto free_meta_inode;
+		goto free_meta_cache;
 	}
 
 	if (__is_set_ckpt_flags(F2FS_CKPT(sbi), CP_QUOTA_NEED_FSCK_FLAG))
@@ -5595,7 +5582,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * followed by f2fs_write_checkpoint() through f2fs_write_node_pages(), which
 	 * falls into an infinite loop in f2fs_sync_meta_pages().
 	 */
-	truncate_inode_pages_final(META_MAPPING(sbi));
+	f2fs_truncate_meta_caches(sbi, 0, ULONG_MAX);
 	/* evict some inodes being cached by GC */
 	evict_inodes(sb);
 	f2fs_unregister_sysfs(sbi);
@@ -5625,10 +5612,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 free_devices:
 	destroy_device_list(sbi);
 	kvfree(sbi->ckpt);
-free_meta_inode:
-	make_bad_inode(sbi->meta_inode);
-	iput(sbi->meta_inode);
-	sbi->meta_inode = NULL;
 free_meta_cache:
 	f2fs_destroy_cache(META_CACHE(sbi));
 free_page_array_cache:
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index f38558279e86..c325904f461e 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -44,7 +44,6 @@
 
 #define F2FS_ROOT_INO(sbi)	((sbi)->root_ino_num)
 #define F2FS_NODE_INO(sbi)	((sbi)->node_ino_num)
-#define F2FS_META_INO(sbi)	((sbi)->meta_ino_num)
 #define F2FS_COMPRESS_INO(sbi)	(NM_I(sbi)->max_nid)
 
 #define F2FS_MAX_QUOTAS		3
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
