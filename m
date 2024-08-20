Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36671C54722
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Aug 2024 03:47:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sgFq5-0006ix-Ns;
	Tue, 20 Aug 2024 03:47:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sgFq3-0006ip-7N
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 03:47:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/GItEWqxznVCij7rKDkuYmv2jUj/+xx6HzGDrLsxMOU=; b=LhvjNM3Y7SOr8OyJnu9WVv63jI
 2HLIlyXlvNaoUmAqKL/LeHKjYNHDwBJOVXKrz6dbUjEnVx9cYITQFpeTdnZJ13D4gSTkxVtvoXDqB
 keTAy5aoEDKbem5rOeruHkcyD3+P5Esfz3F5XBVvaJH3yJsQQ8lnHg3uRFmXuuAHu6fY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/GItEWqxznVCij7rKDkuYmv2jUj/+xx6HzGDrLsxMOU=; b=h
 PRU35S7R5mLlcXo0MyX8QiREHAxAwEck5+prJWjsCdjJNTcLfvESiSnDrcorruMLq2QKV41jTzmlb
 0cV/Ucd2oqMA/M/ymbdIkn90+N7LiQsbc+uexZLlJyjkt37B02jSE8OkHVfhHlZzi6G9IkjwozF7/
 sQzXGOqBK5Oi5xyc=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sgFq1-0006RU-G6 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 03:47:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A9A5FCE0989;
 Tue, 20 Aug 2024 03:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF5AC4AF0C;
 Tue, 20 Aug 2024 03:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724125624;
 bh=g4BTj0BsXqAj1BLALkrYqHcBy0nS0AoA9Yo+xzPSI3w=;
 h=From:To:Cc:Subject:Date:From;
 b=EWvYZUIAWCaXoBFo5ThcMoMl+KZVKuVlkWRa55RwOpuL4j3Kd7blI0IG8zWQw+aTu
 L3pdYh1jKCeYafMuBSqSRAq8GCxd/oleYTl1nMjf3SZC3p0PELwDfIc/00RszkdRzX
 J2VGElFvyOjiNnM9S7P+nJ10n5PzPC9ZY6Q5R4tdhmDaWGdIW87/5Im68rw15R5Uxj
 qaqHQCQEIb5vBzezO6+YrTpuYFzqu0o2NQbRBxEyniUApYtG6hNt/uPKDW8J8bXI/2
 fEmYOkkuurkuyZseogsoPYwUPeFqCKmxSO7QRSbfDLk2HSFJowKNTodnbnFGHsrfc9
 k8hs9lzec2kFA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 20 Aug 2024 11:46:47 +0800
Message-Id: <20240820034654.698236-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1sgFq1-0006RU-G6
Subject: [f2fs-dev] [PATCH v2 1/8] f2fs: convert f2fs_write_begin() to use
 folio
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
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Convert to use folio, so that we can get rid of 'page->index' to
prepare for removal of 'index' field in structure page [1].

[1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix compile error.
 fs/f2fs/data.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0655fddfc4ba..85ac05c3655a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3378,11 +3378,11 @@ void f2fs_write_failed(struct inode *inode, loff_t to)
 }
 
 static int prepare_write_begin(struct f2fs_sb_info *sbi,
-			struct page *page, loff_t pos, unsigned len,
+			struct folio *folio, loff_t pos, unsigned int len,
 			block_t *blk_addr, bool *node_changed)
 {
-	struct inode *inode = page->mapping->host;
-	pgoff_t index = page->index;
+	struct inode *inode = folio->mapping->host;
+	pgoff_t index = folio->index;
 	struct dnode_of_data dn;
 	struct page *ipage;
 	bool locked = false;
@@ -3419,13 +3419,13 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 	if (f2fs_has_inline_data(inode)) {
 		if (pos + len <= MAX_INLINE_DATA(inode)) {
-			f2fs_do_read_inline_data(page_folio(page), ipage);
+			f2fs_do_read_inline_data(folio, ipage);
 			set_inode_flag(inode, FI_DATA_EXIST);
 			if (inode->i_nlink)
 				set_page_private_inline(ipage);
 			goto out;
 		}
-		err = f2fs_convert_inline_page(&dn, page);
+		err = f2fs_convert_inline_page(&dn, folio_page(folio, 0));
 		if (err || dn.data_blkaddr != NULL_ADDR)
 			goto out;
 	}
@@ -3518,12 +3518,12 @@ static int __reserve_data_block(struct inode *inode, pgoff_t index,
 }
 
 static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
-			struct page *page, loff_t pos, unsigned int len,
+			struct folio *folio, loff_t pos, unsigned int len,
 			block_t *blk_addr, bool *node_changed, bool *use_cow)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct inode *cow_inode = F2FS_I(inode)->cow_inode;
-	pgoff_t index = page->index;
+	pgoff_t index = folio->index;
 	int err = 0;
 	block_t ori_blk_addr = NULL_ADDR;
 
@@ -3566,6 +3566,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *page = NULL;
+	struct folio *folio;
 	pgoff_t index = ((unsigned long long) pos) >> PAGE_SHIFT;
 	bool need_balance = false;
 	bool use_cow = false;
@@ -3625,22 +3626,23 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	/* TODO: cluster can be compressed due to race with .writepage */
 
 	*pagep = page;
+	folio = page_folio(page);
 
 	if (f2fs_is_atomic_file(inode))
-		err = prepare_atomic_write_begin(sbi, page, pos, len,
+		err = prepare_atomic_write_begin(sbi, folio, pos, len,
 					&blkaddr, &need_balance, &use_cow);
 	else
-		err = prepare_write_begin(sbi, page, pos, len,
+		err = prepare_write_begin(sbi, folio, pos, len,
 					&blkaddr, &need_balance);
 	if (err)
 		goto fail;
 
 	if (need_balance && !IS_NOQUOTA(inode) &&
 			has_not_enough_free_secs(sbi, 0, 0)) {
-		unlock_page(page);
+		folio_unlock(folio);
 		f2fs_balance_fs(sbi, true);
-		lock_page(page);
-		if (page->mapping != mapping) {
+		folio_lock(folio);
+		if (folio->mapping != mapping) {
 			/* The page got truncated from under us */
 			f2fs_put_page(page, 1);
 			goto repeat;
@@ -3649,18 +3651,18 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 
 	f2fs_wait_on_page_writeback(page, DATA, false, true);
 
-	if (len == PAGE_SIZE || PageUptodate(page))
+	if (len == PAGE_SIZE || folio_test_uptodate(folio))
 		return 0;
 
 	if (!(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode) &&
 	    !f2fs_verity_in_progress(inode)) {
-		zero_user_segment(page, len, PAGE_SIZE);
+		folio_zero_segment(folio, len, folio_size(folio));
 		return 0;
 	}
 
 	if (blkaddr == NEW_ADDR) {
-		zero_user_segment(page, 0, PAGE_SIZE);
-		SetPageUptodate(page);
+		folio_zero_segment(folio, 0, folio_size(folio));
+		folio_mark_uptodate(folio);
 	} else {
 		if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
 				DATA_GENERIC_ENHANCE_READ)) {
@@ -3669,16 +3671,16 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 		}
 		err = f2fs_submit_page_read(use_cow ?
 				F2FS_I(inode)->cow_inode : inode,
-				page_folio(page), blkaddr, 0, true);
+				folio, blkaddr, 0, true);
 		if (err)
 			goto fail;
 
-		lock_page(page);
-		if (unlikely(page->mapping != mapping)) {
+		folio_lock(folio);
+		if (unlikely(folio->mapping != mapping)) {
 			f2fs_put_page(page, 1);
 			goto repeat;
 		}
-		if (unlikely(!PageUptodate(page))) {
+		if (unlikely(!folio_test_uptodate(folio))) {
 			err = -EIO;
 			goto fail;
 		}
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
