Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A425C369C0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLVx-00043V-7f;
	Mon, 31 Mar 2025 20:13:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVk-0003tu-V6
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K5sdbrAkTxpYv7H+ap+5uAiFvI19/6vBtdDWHOQB0i4=; b=hyWZchzP4wM4EQY9uIIsyui+Dl
 x7sYqr6YbkIOLduXahu+AUHFlZ7nMAP/frMSaJYv8nmzYfa8e4EjW7KDTq2ZjAPuelji5WzdqR/BD
 ggu27jMcR1KM7CTEm+yInBWp82EH4LYdRALNSAKZujoUgS99j7Dx5G2Lnp43v6xmcS4o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K5sdbrAkTxpYv7H+ap+5uAiFvI19/6vBtdDWHOQB0i4=; b=FLf6oBQvNPovBjanU9xAagOJh8
 bt+0en/xo7JbhCfkhtn4eAOh28kB+tfsDhXuCC0weD5UY2wk0FOjw1V/SJ0sZFH0bYXnMp5WbPeKP
 GoKQPl6u+MRnNg/ZYXPjhmD/Lk2qljjRu9/lj9JBA+8QqsF6Hi0wLAkI0A1uoW0kTkSQ=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVa-0003bM-28 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=K5sdbrAkTxpYv7H+ap+5uAiFvI19/6vBtdDWHOQB0i4=; b=ON2SnzR7iQbnNRCH54UVUdTA7h
 sidbXQ9jOFFJq/bKB0ifaTPbIodOUJcLi2HR1odZ0zbFSl2mMkFcqiCdl6lYMae4NBqKQsQSjiEhv
 CaSm5rR0c5qJtpUOgBzCb8vA/e8BLtK4iiUxYRVtKFW09NTbIajJxMDg3sfUUHH4w0lBNS0Jd8xJN
 Y/jrqXwIOTaRcTM9MxVxwSnPtniM6UvaPCASnoqpkDVYfXhQHnAg5tGZdaMc9Vxn1R8/jyBxE90bo
 3X9oPhkamT37PEle/W8xBd1cAmbcKTBAtNIC05NpTey0Yvit5s9LZLc+NBd6vR5CkKRQzBVH29bxA
 qdsytg0g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVO-00000004Rps-1kiR;
 Mon, 31 Mar 2025 20:13:10 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:11:23 +0100
Message-ID: <20250331201256.1057782-64-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVa-0003bM-28
Subject: [f2fs-dev] [PATCH 063/153] f2fs: Use a folio in
 f2fs_move_inline_dirents()
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
Cc: "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Remove eight hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/inline.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 4b0a7062a0e0..9bac2c4e8937 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -410,16 +410,16 @@ int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
 static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 							void *inline_dentry)
 {
-	struct page *page;
+	struct folio *folio;
 	struct dnode_of_data dn;
 	struct f2fs_dentry_block *dentry_blk;
 	struct f2fs_dentry_ptr src, dst;
 	int err;
 
-	page = f2fs_grab_cache_page(dir->i_mapping, 0, true);
-	if (!page) {
+	folio = f2fs_grab_cache_folio(dir->i_mapping, 0, true);
+	if (IS_ERR(folio)) {
 		f2fs_put_page(ipage, 1);
-		return -ENOMEM;
+		return PTR_ERR(folio);
 	}
 
 	set_new_dnode(&dn, dir, ipage, NULL, 0);
@@ -429,17 +429,17 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 
 	if (unlikely(dn.data_blkaddr != NEW_ADDR)) {
 		f2fs_put_dnode(&dn);
-		set_sbi_flag(F2FS_P_SB(page), SBI_NEED_FSCK);
-		f2fs_warn(F2FS_P_SB(page), "%s: corrupted inline inode ino=%lx, i_addr[0]:0x%x, run fsck to fix.",
+		set_sbi_flag(F2FS_F_SB(folio), SBI_NEED_FSCK);
+		f2fs_warn(F2FS_F_SB(folio), "%s: corrupted inline inode ino=%lx, i_addr[0]:0x%x, run fsck to fix.",
 			  __func__, dir->i_ino, dn.data_blkaddr);
-		f2fs_handle_error(F2FS_P_SB(page), ERROR_INVALID_BLKADDR);
+		f2fs_handle_error(F2FS_F_SB(folio), ERROR_INVALID_BLKADDR);
 		err = -EFSCORRUPTED;
 		goto out;
 	}
 
-	f2fs_wait_on_page_writeback(page, DATA, true, true);
+	f2fs_folio_wait_writeback(folio, DATA, true, true);
 
-	dentry_blk = page_address(page);
+	dentry_blk = folio_address(folio);
 
 	/*
 	 * Start by zeroing the full block, to ensure that all unused space is
@@ -455,9 +455,9 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 	memcpy(dst.dentry, src.dentry, SIZE_OF_DIR_ENTRY * src.max);
 	memcpy(dst.filename, src.filename, src.max * F2FS_SLOT_LEN);
 
-	if (!PageUptodate(page))
-		SetPageUptodate(page);
-	set_page_dirty(page);
+	if (!folio_test_uptodate(folio))
+		folio_mark_uptodate(folio);
+	folio_mark_dirty(folio);
 
 	/* clear inline dir and flag after data writeback */
 	f2fs_truncate_inline_inode(dir, ipage, 0);
@@ -477,7 +477,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 	if (i_size_read(dir) < PAGE_SIZE)
 		f2fs_i_size_write(dir, PAGE_SIZE);
 out:
-	f2fs_put_page(page, 1);
+	f2fs_folio_put(folio, true);
 	return err;
 }
 
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
