Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3E8C3601E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLVy-0005sY-GG;
	Mon, 31 Mar 2025 20:13:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVn-0005ho-0z
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sNANg2TcEGf/NEt960elRiVXLMYEfNrHTL9Cz/1Mmyg=; b=UgiXdjoJ/cu5y2Nbh0Fx3yufMV
 bqMzLMqE66zMixzJhRGRulAuoiumxy3vWCEmm5LXrdTipv+8LTZhdIg1yRSLSqqTCfSuNe3KWsBaI
 zd8PpU5hfWf00dtyTRDUpFABNLG2f8f6WMKTeBWAp9//CuxfxgfBq+WPn6TIGTb7dHSg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sNANg2TcEGf/NEt960elRiVXLMYEfNrHTL9Cz/1Mmyg=; b=c0Q+2BTsWJmv0QqtyjACkx9TKj
 By/mC+DCr2caKahwh8VE61voWuvEClTncwOSj+jvP01sdIlPU8a+pMEfD+UcqAxibOfSo+sEd0VCE
 uaHDDh86XH7gu3wAUyTCKW6Dbqqdadcr8jPR7K9j43SxaJL8YVy1pLe+/P8FLMjqo580=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVl-0003gi-Pt for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=sNANg2TcEGf/NEt960elRiVXLMYEfNrHTL9Cz/1Mmyg=; b=QFeLnrAcCrI0v8M/WlWHs23HQS
 lNhfFZIMhb2jbU5I9IHrVKICvym2X7lbr2bcl/ADEeKY4cF2FZTpoZjRjfBv7iKSmbgt7hqsdJO9E
 1VOlJfIba6swd48NVqXlpZoDxddUJnqwzi/mpmozJFqvisl6OL41CxaQN9eq1ZCeaepDp/gUW8Re8
 +Hoh6XIOu9SLXb984DzL4cFZAA0YGoFBQBng/aELRXINjY1G/R+UDR4ES9+M606ITwijRnRGex1Cj
 k14ebJEMO+zBUIUzGz3EdDMC3IgOcKt4UDG9Q1YPQTiM8R51r68ZYhD2G7Aquygfchhy4BYbuRQ3y
 CcQ9hjHA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVa-00000004SVX-27Hn;
 Mon, 31 Mar 2025 20:13:22 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:12:25 +0100
Message-ID: <20250331201256.1057782-126-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVl-0003gi-Pt
Subject: [f2fs-dev] [PATCH 125/153] f2fs: Pass a folio to
 f2fs_truncate_inline_inode()
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

All callers now have a folio, so pass it in.  Removes a call to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/f2fs.h   |  4 ++--
 fs/f2fs/file.c   |  2 +-
 fs/f2fs/inline.c | 18 +++++++++---------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bb9e4f512242..5a6910b7d58a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4274,8 +4274,8 @@ bool f2fs_may_inline_data(struct inode *inode);
 bool f2fs_sanity_check_inline_data(struct inode *inode, struct page *ipage);
 bool f2fs_may_inline_dentry(struct inode *inode);
 void f2fs_do_read_inline_data(struct folio *folio, struct folio *ifolio);
-void f2fs_truncate_inline_inode(struct inode *inode,
-						struct page *ipage, u64 from);
+void f2fs_truncate_inline_inode(struct inode *inode, struct folio *ifolio,
+		u64 from);
 int f2fs_read_inline_data(struct inode *inode, struct folio *folio);
 int f2fs_convert_inline_folio(struct dnode_of_data *dn, struct folio *folio);
 int f2fs_convert_inline_inode(struct inode *inode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 66c743a09756..8f1adaa9f90a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -781,7 +781,7 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 	}
 
 	if (f2fs_has_inline_data(inode)) {
-		f2fs_truncate_inline_inode(inode, &ifolio->page, from);
+		f2fs_truncate_inline_inode(inode, ifolio, from);
 		f2fs_folio_put(ifolio, true);
 		truncate_page = true;
 		goto out;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 39b936be6ca8..bce99af7f4ef 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -97,19 +97,19 @@ void f2fs_do_read_inline_data(struct folio *folio, struct folio *ifolio)
 		folio_mark_uptodate(folio);
 }
 
-void f2fs_truncate_inline_inode(struct inode *inode,
-					struct page *ipage, u64 from)
+void f2fs_truncate_inline_inode(struct inode *inode, struct folio *ifolio,
+		u64 from)
 {
 	void *addr;
 
 	if (from >= MAX_INLINE_DATA(inode))
 		return;
 
-	addr = inline_data_addr(inode, ipage);
+	addr = inline_data_addr(inode, &ifolio->page);
 
-	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
+	f2fs_folio_wait_writeback(ifolio, NODE, true, true);
 	memset(addr + from, 0, MAX_INLINE_DATA(inode) - from);
-	set_page_dirty(ipage);
+	folio_mark_dirty(ifolio);
 
 	if (from == 0)
 		clear_inode_flag(inode, FI_DATA_EXIST);
@@ -205,7 +205,7 @@ int f2fs_convert_inline_folio(struct dnode_of_data *dn, struct folio *folio)
 	set_inode_flag(dn->inode, FI_APPEND_WRITE);
 
 	/* clear inline data and flag after data writeback */
-	f2fs_truncate_inline_inode(dn->inode, &dn->inode_folio->page, 0);
+	f2fs_truncate_inline_inode(dn->inode, dn->inode_folio, 0);
 	clear_page_private_inline(&dn->inode_folio->page);
 clear_out:
 	stat_dec_inline_inode(dn->inode);
@@ -334,7 +334,7 @@ int f2fs_recover_inline_data(struct inode *inode, struct page *npage)
 		struct folio *ifolio = f2fs_get_inode_folio(sbi, inode->i_ino);
 		if (IS_ERR(ifolio))
 			return PTR_ERR(ifolio);
-		f2fs_truncate_inline_inode(inode, &ifolio->page, 0);
+		f2fs_truncate_inline_inode(inode, ifolio, 0);
 		stat_dec_inline_inode(inode);
 		clear_inode_flag(inode, FI_INLINE_DATA);
 		f2fs_folio_put(ifolio, true);
@@ -460,7 +460,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
 	folio_mark_dirty(folio);
 
 	/* clear inline dir and flag after data writeback */
-	f2fs_truncate_inline_inode(dir, &ifolio->page, 0);
+	f2fs_truncate_inline_inode(dir, ifolio, 0);
 
 	stat_dec_inline_dir(dir);
 	clear_inode_flag(dir, FI_INLINE_DENTRY);
@@ -547,7 +547,7 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct folio *ifolio,
 	}
 
 	memcpy(backup_dentry, inline_dentry, MAX_INLINE_DATA(dir));
-	f2fs_truncate_inline_inode(dir, &ifolio->page, 0);
+	f2fs_truncate_inline_inode(dir, ifolio, 0);
 
 	folio_unlock(ifolio);
 
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
