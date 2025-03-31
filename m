Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6845C369AC
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLW8-0004JC-G6;
	Mon, 31 Mar 2025 20:13:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLW1-00048l-2r
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uH8xLVOYlFGlw/YTPOdkfvn86ssZlSC+WgHhfc3oJL0=; b=GaTgEHY4gkFXKrVtxOBUz2sNo9
 kkpOjyM75aGb35KGM0brGNwndmbR74AKv+tKNyb0dILWbt65bb/vmCa/zS3+5IBAVI1w9j0ht6BN+
 VcHofMhWGLw9ecQlibjURg36WZUqv8irZAS3OP/MbbVxds7JWZbVpJ55A2FVtglwD8Yw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uH8xLVOYlFGlw/YTPOdkfvn86ssZlSC+WgHhfc3oJL0=; b=WBhO1uLR44MZdWPWCPm0fRYAkk
 lBmVZgx5DfyivaqkMxBXoHpt2M1s7L0u3m/ynKb9+Z+SJEJy99earAAFd8eOUrIe8cbGifylNyciM
 A45GClUjF/W+X0Emj0xYVKjvLKgj1v7mlBjXbUr5WMT+hCy7A64NR59P1WqNafwt+tog=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVq-0003iS-5m for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=uH8xLVOYlFGlw/YTPOdkfvn86ssZlSC+WgHhfc3oJL0=; b=tsCZ8SXpmA5XSm+rXj1UaWSI+/
 Fhs2ApLyIoPw6vi++T8gPjwlrxQPxwTXzK3TvNzewB+WCVM/3bkzPewwPDVTfzCOS6onFdTWpsZvz
 70kGG8P9zTSA4yK+Rhbn7DBmygacOGRGAKyvTMqf+MpRLwvPnqSu56KUqMY8dJWB7IH3esylwgWzz
 s97HiNrqC6H72iAwv22cByo/0vsSl5vxGd6R8fEaExEN0y478Do75J5tdwPp4CqiKqJulW3mBhj6K
 YO+iZCkPPo6ZI6MDAfus1YSqps5vmqpqukoIlXLI7jrQcZRSH/heQefLBlnXZJrTMnULG5JjN7TIS
 1KSMnG6A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVe-00000004SeE-2r1J;
 Mon, 31 Mar 2025 20:13:26 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:12:51 +0100
Message-ID: <20250331201256.1057782-152-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVq-0003iS-5m
Subject: [f2fs-dev] [PATCH 151/153] f2fs: Remove f2fs_new_node_page()
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

All callers now use f2fs_new_node_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/f2fs.h | 6 ------
 fs/f2fs/node.c | 4 ++--
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 768f5fd9b45d..b546c720cf03 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3765,12 +3765,6 @@ void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi);
 int __init f2fs_create_node_manager_caches(void);
 void f2fs_destroy_node_manager_caches(void);
 
-static inline
-struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
-{
-	return &f2fs_new_node_folio(dn, ofs)->page;
-}
-
 /*
  * segment.c
  */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f95a922c4936..53ad48075eb5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1351,7 +1351,7 @@ struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs)
 		dec_valid_node_count(sbi, dn->inode, !ofs);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn_ratelimited(sbi,
-			"f2fs_new_node_page: inconsistent nat entry, "
+			"f2fs_new_node_folio: inconsistent nat entry, "
 			"ino:%u, nid:%u, blkaddr:%u, ver:%u, flag:%u",
 			new_ni.ino, new_ni.nid, new_ni.blk_addr,
 			new_ni.version, new_ni.flag);
@@ -2356,7 +2356,7 @@ static bool add_free_nid(struct f2fs_sb_info *sbi,
 		 *  - f2fs_add_link
 		 *   - f2fs_init_inode_metadata
 		 *    - f2fs_new_inode_folio
-		 *     - f2fs_new_node_page
+		 *     - f2fs_new_node_folio
 		 *      - set_node_addr
 		 *  - f2fs_alloc_nid_done
 		 *   - __remove_nid_from_list(PREALLOC_NID)
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
