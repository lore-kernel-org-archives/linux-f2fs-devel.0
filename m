Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED82C44507
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jul 2026 02:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E87dgvHg5raG/Aqgv1xQiIlJoLVa3U4NnV+jtD4XlyY=; b=IF0oQDQbjiNlSeB39Xnm5VFok9
	eqX9Hkn65gJjvPTcnGXpaf1/D5IDQHms/8c2xncXRNRvLRFigayIhweSnm770bEeFpItPooKfu8FY
	bWCCc2H8juszuRCnK9w6eRVzXx5khf4g/IUG2jVcOUsrL31piLSX8cU1VIf3IsC2xTHM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wj6aN-00065m-M9;
	Mon, 13 Jul 2026 02:40:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wj6aJ-00064j-I8
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 02:39:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bbMgc3U9Wrf7V5sNOplnNKhU5giKnGr9y8HSKK/IOoE=; b=eeTsPphw6X9EwtiFkLigNcA8Ts
 SGF3yOWbNg598/qOvvm0kT7yf7c4KB3OjtzSvVNkFyfErSaGeRwuKW1+21/MNty+i7ydFujg3KxaN
 1r2ElJlQk1uixMjKKtuyp8ecyhntUjIXAgHVS0wxRrmp5/LYqEnIdeWW9lDZuoIoV430=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bbMgc3U9Wrf7V5sNOplnNKhU5giKnGr9y8HSKK/IOoE=; b=INrowA7b/XA9PvGBwRNEOoy6T2
 wvJP4bmFYcxa02H627gsDYrX8dxzUFkqXgOLogX5M/TjUezaLZGA04aUUvxeGhzi00S5stahO6kiD
 8XCp4iAydfDfqfThehdDoeAEbKZPu73x1U2BD8eBsqPhTJF/hNbTpBO64s29Bk4EIRl4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wj6aJ-0003C2-Ev for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 02:39:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 220B843626;
 Mon, 13 Jul 2026 02:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64651F00A3A;
 Mon, 13 Jul 2026 02:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783910385;
 bh=bbMgc3U9Wrf7V5sNOplnNKhU5giKnGr9y8HSKK/IOoE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lvaFIXArLqICM5szm+vl81pwVdZL5fMmNahe8lrR36btpVkegVkNqO89r876W1H7M
 zI+Q539Q1Ugke8ZXLk1DntEFXfV/7iMTw5X5f1PajHTRHFHujTxy8eVkhxUm//9gpF
 hpa5UxqGAMHGEmAmca/8tCxLpJuTxqH45dj0XDn4ADKZVGCHMomAJ0hiWxG0rZ1t6k
 wWcSdD4hbsEBVB1/FHT8A7/ySlMi8PYl6yiOpuiDj0LJTknhw93QY/xBJ2j9G2bWYk
 rCEF5Ckr/VyeGllKIB8avRL4unmeb5Eo3KxQNnVjBpA+AAz8EQUqRTpvAARzYVX4OG
 K5J6C1a/RfFRQ==
To: linux-fscrypt@vger.kernel.org
Date: Sun, 12 Jul 2026 22:36:59 -0400
Message-ID: <20260713023708.9245-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713023708.9245-1-ebiggers@kernel.org>
References: <20260713023708.9245-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wj6aJ-0003C2-Ev
Subject: [f2fs-dev] [PATCH v3 08/17] ext4: Make ext4_bio_write_folio()
 return void
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Zhang Yi <yi.zhang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Since the fs-layer file contents encryption implementation was removed,
ext4_bio_write_folio() now always returns 0.  Change it to return void,
and likewise for its caller mpage_submit_folio().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/ext4/ext4.h    |  2 +-
 fs/ext4/inode.c   | 32 +++++++++-----------------------
 fs/ext4/page-io.c |  6 ++----
 3 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index b37c136ea3ab..920a8ec1b948 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3945,7 +3945,7 @@ extern void ext4_io_submit_init(struct ext4_io_submit *io,
 				struct writeback_control *wbc);
 extern void ext4_end_io_rsv_work(struct work_struct *work);
 extern void ext4_io_submit(struct ext4_io_submit *io);
-int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *page,
+void ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *page,
 		size_t len);
 extern struct ext4_io_end_vec *ext4_alloc_io_end_vec(ext4_io_end_t *io_end);
 extern struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8eb2af481129..567d62032bc5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2064,11 +2064,10 @@ static void mpage_folio_done(struct mpage_da_data *mpd, struct folio *folio)
 	folio_unlock(folio);
 }
 
-static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
+static void mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 {
 	size_t len;
 	loff_t size;
-	int err;
 
 	WARN_ON_ONCE(folio_pos(folio) != mpd->start_pos);
 	folio_clear_dirty_for_io(folio);
@@ -2090,9 +2089,7 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 	if (folio_pos(folio) + len > size &&
 	    !ext4_verity_in_progress(mpd->inode))
 		len = size & (len - 1);
-	err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
-
-	return err;
+	ext4_bio_write_folio(&mpd->io_submit, folio, len);
 }
 
 #define BH_FLAGS (BIT(BH_Unwritten) | BIT(BH_Delay))
@@ -2169,8 +2166,7 @@ static bool mpage_add_bh_to_extent(struct mpage_da_data *mpd, ext4_lblk_t lblk,
  * accumulated extent of buffers to map or add buffers in the page to the
  * extent of buffers to map. The function returns 1 if the caller can continue
  * by processing the next page, 0 if it should stop adding buffers to the
- * extent to map because we cannot extend it anymore. It can also return value
- * < 0 in case of error during IO submission.
+ * extent to map because we cannot extend it anymore.
  */
 static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 				   struct buffer_head *head,
@@ -2178,7 +2174,6 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 				   ext4_lblk_t lblk)
 {
 	struct inode *inode = mpd->inode;
-	int err;
 	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
 							>> inode->i_blkbits;
 
@@ -2201,9 +2196,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 	} while (lblk++, (bh = bh->b_this_page) != head);
 	/* So far everything mapped? Submit the page for IO. */
 	if (mpd->map.m_len == 0) {
-		err = mpage_submit_folio(mpd, head->b_folio);
-		if (err < 0)
-			return err;
+		mpage_submit_folio(mpd, head->b_folio);
 		mpage_folio_done(mpd, head->b_folio);
 	}
 	if (lblk >= blocks) {
@@ -2333,9 +2326,7 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 			if (err < 0 || map_bh)
 				goto out;
 			/* Page fully mapped - let IO run! */
-			err = mpage_submit_folio(mpd, folio);
-			if (err < 0)
-				goto out;
+			mpage_submit_folio(mpd, folio);
 			mpage_folio_done(mpd, folio);
 		}
 		folio_batch_release(&fbatch);
@@ -2408,7 +2399,6 @@ static int mpage_submit_partial_folio(struct mpage_da_data *mpd)
 	struct inode *inode = mpd->inode;
 	struct folio *folio;
 	loff_t pos;
-	int ret;
 
 	folio = filemap_get_folio(inode->i_mapping,
 				  mpd->start_pos >> PAGE_SHIFT);
@@ -2423,9 +2413,7 @@ static int mpage_submit_partial_folio(struct mpage_da_data *mpd)
 			 !folio_contains(folio, pos >> PAGE_SHIFT)))
 		return -EINVAL;
 
-	ret = mpage_submit_folio(mpd, folio);
-	if (ret)
-		goto out;
+	mpage_submit_folio(mpd, folio);
 	/*
 	 * Update start_pos to prevent this folio from being released in
 	 * mpage_release_unused_pages(), it will be reset to the aligned folio
@@ -2434,10 +2422,9 @@ static int mpage_submit_partial_folio(struct mpage_da_data *mpd)
 	 * entire folio has finished processing.
 	 */
 	mpd->start_pos = pos;
-out:
 	folio_unlock(folio);
 	folio_put(folio);
-	return ret;
+	return 0;
 }
 
 /*
@@ -2724,9 +2711,8 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 * through a pin.
 			 */
 			if (!mpd->can_map) {
-				err = mpage_submit_folio(mpd, folio);
-				if (err < 0)
-					goto out;
+				mpage_submit_folio(mpd, folio);
+				err = 0;
 				/* Pending dirtying of journalled data? */
 				if (folio_test_checked(folio)) {
 					err = mpage_journal_page_buffers(handle,
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 557f44178d87..0236b6b9785a 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -459,7 +459,7 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 	io->io_next_block++;
 }
 
-int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
+void ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 		size_t len)
 {
 	struct inode *inode = folio->mapping->host;
@@ -533,7 +533,7 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 		 */
 		__folio_start_writeback(folio, keep_towrite);
 		folio_end_writeback(folio);
-		return 0;
+		return;
 	}
 
 	bh = head = folio_buffers(folio);
@@ -546,6 +546,4 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 			continue;
 		io_submit_add_bh(io, inode, folio, bh);
 	} while ((bh = bh->b_this_page) != head);
-
-	return 0;
 }
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
