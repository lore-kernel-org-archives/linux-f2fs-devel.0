Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E51C3601A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLVz-00046G-1W;
	Mon, 31 Mar 2025 20:13:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVn-0003vd-9v
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hyp5ofv1+uylru2mOQwJNYQ7OoGdQ+6dSnv0GkxmW24=; b=dOccqxAe7RkVsUhhvYSREjxaoe
 CpF2pvVGcWfLRa8hmjU+Vpc+B8EY0srbuEgYRTMcXWgyoIqKmpki0BW17BznwbJtFl63PbeG+X+D/
 g5XvHKcL1DUAcIo89s5PdVpVZsRXVEW9jXk0ydU6YTeiYG2bfLPxnnl8je/LTanYfmUM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Hyp5ofv1+uylru2mOQwJNYQ7OoGdQ+6dSnv0GkxmW24=; b=K9PM20XP2zOaNGy9e2UGRgjkyA
 K/dCSvMj4eeVdliP9sRFQYzVDL+sUxCqxBF1+meN5Vf04SQajB0Pg2p6L/21JecCp6kBDm4El8TIK
 QY/z2oLOCSgrq6KJ/mAZGPCtWbx0iqc+J1icJv/AOUdbu9XuTYjT3SBc2g2/d464cf2w=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVh-0003eU-GT for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Hyp5ofv1+uylru2mOQwJNYQ7OoGdQ+6dSnv0GkxmW24=; b=MsjnUxnGN1Pjq+NGYTNXvRrXBI
 LiiIJP52+qen/twdOH9VaP6NW+j3WszlRBoSjVXDj1wb9HBcNh0TWgXbfNYnJzODoH00A5oOeE5Qe
 o2oV/+1g3hFJUON5xvhQyJU8bH7xQaDjnZjOTyPc5W9fnBhROhPsvX8NjfSF1Gb9ELe1peT0OLYe0
 6WCDiMYCDjKmmQvMOJJgeuZqbwXTxCMbxbwGeq1SmFGFaJssFezo1nwvgyWsty9aw7IOQJPQj6wvf
 LcVIG6R1C86HoG1sRahly6smfiqqVnD/U8dl9KVXXEB6ZKY3GKgWfXO23YWX5cPD2H8Hy1cnxQQgT
 CuGdrYPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVW-00000004SC1-0Xzw;
 Mon, 31 Mar 2025 20:13:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:11:59 +0100
Message-ID: <20250331201256.1057782-100-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVh-0003eU-GT
Subject: [f2fs-dev] [PATCH 099/153] f2fs: Use a folio in
 f2fs_write_inline_data()
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

Remove four calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/inline.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 508004f4df4f..55c0b82d43d5 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -263,31 +263,31 @@ int f2fs_convert_inline_inode(struct inode *inode)
 int f2fs_write_inline_data(struct inode *inode, struct folio *folio)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct page *ipage;
+	struct folio *ifolio;
 
-	ipage = f2fs_get_inode_page(sbi, inode->i_ino);
-	if (IS_ERR(ipage))
-		return PTR_ERR(ipage);
+	ifolio = f2fs_get_inode_folio(sbi, inode->i_ino);
+	if (IS_ERR(ifolio))
+		return PTR_ERR(ifolio);
 
 	if (!f2fs_has_inline_data(inode)) {
-		f2fs_put_page(ipage, 1);
+		f2fs_folio_put(ifolio, true);
 		return -EAGAIN;
 	}
 
 	f2fs_bug_on(F2FS_I_SB(inode), folio->index);
 
-	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
-	memcpy_from_folio(inline_data_addr(inode, ipage),
+	f2fs_folio_wait_writeback(ifolio, NODE, true, true);
+	memcpy_from_folio(inline_data_addr(inode, &ifolio->page),
 			 folio, 0, MAX_INLINE_DATA(inode));
-	set_page_dirty(ipage);
+	folio_mark_dirty(ifolio);
 
 	f2fs_clear_page_cache_dirty_tag(folio);
 
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	set_inode_flag(inode, FI_DATA_EXIST);
 
-	clear_page_private_inline(ipage);
-	f2fs_put_page(ipage, 1);
+	clear_page_private_inline(&ifolio->page);
+	f2fs_folio_put(ifolio, 1);
 	return 0;
 }
 
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
