Return-Path: <SRS0=/9Ak=GR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8504C433E9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 14 Jan 2021 19:02:02 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7D623B79;
	Thu, 14 Jan 2021 19:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7D623B79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1l07sf-0000GO-62; Thu, 14 Jan 2021 19:02:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1l07se-0000G9-8S
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Jan 2021 19:02:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q/TT6MV20P8eRHlRUQdeew9evaFHwu/mZPeqJEfu55o=; b=Dp8iQIryluS1ysB4rFrP3KVPBG
 vVZquwQ7oF9vu1OK2WuxmgEx+LeEnUrVS8LzP4XhFSVFI1Qb5OIc6FQBKB4/7EFnTAGjsTW4FxqdE
 vvXPBZ4JuIJJ1R8VXxM2G7J0LkmAVfkg9GA3HFnIDJgmqVuOrO8GD/PjU+YOJcNCulmc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Q/TT6MV20P8eRHlRUQdeew9evaFHwu/mZPeqJEfu55o=; b=M
 fuMJCIZ8ayKpbp2TMM667tmU9YQcaXoAYur3mELthxKNhMoSfToelcWcHdQ2hG5yUqXrIIkCMH9nI
 TbIaHhs7G8AbJn2JSEY4da+qjIr1CsxWSONs3SUUfXePlLdVyOAEYG7lNF/ni+DLu3dL1ecuf7p9j
 FT/O9bxEkZF8JBzs=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1l07sT-00HHXt-Ru
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Jan 2021 19:02:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Q/TT6MV20P8eRHlRUQdeew9evaFHwu/mZPeqJEfu55o=; b=S6+9Isag0wf1iCUNHuMU3MH19w
 rWTizHmdap2lYgBB8g52v/W7IXwxraYul1yOGdEbEFAn2lP8zfPIN4nX0NgBjpEmh5BvB7j1g6tCL
 cZC9Qvj98ivY2m1Np8xQgMTI8G1GDWZWSli3EJuQWrCndo3Tat7e/iJTvsI6eeFq4W0jI/s4rAID+
 HNUm5w8jG0JF0r8lr9BSUgYfG/OQ8ZITHjWhjZmlES/YlAtSEvHrog8JrIlU6twAAY0USW9UiHe68
 868gJEC1NxhAdWcnBAbSoNg4c6/48/peRGD4tFW3tmPT1Zxm7U3bPdQnTeD0aSa/Mku2psGpzuiJp
 P3zhSp4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1l07rZ-007wmU-BC; Thu, 14 Jan 2021 19:00:57 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Date: Thu, 14 Jan 2021 19:00:51 +0000
Message-Id: <20210114190051.1893991-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Headers-End: 1l07sT-00HHXt-Ru
Subject: [f2fs-dev] [PATCH] f2fs: Remove readahead collision detection
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
Cc: "Matthew Wilcox \(Oracle\)" <willy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

With the new ->readahead operation, locked pages are added to the page
cache, preventing two threads from racing with each other to read the
same chunk of file, so this is dead code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c  | 25 -------------------------
 fs/f2fs/f2fs.h  |  1 -
 fs/f2fs/super.c |  2 --
 3 files changed, 28 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4d80f00e5e40..c18248d54020 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2265,11 +2265,6 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 /*
  * This function was originally taken from fs/mpage.c, and customized for f2fs.
  * Major change was from block_size == page_size in f2fs by default.
- *
- * Note that the aops->readpages() function is ONLY used for read-ahead. If
- * this function ever deviates from doing just read-ahead, it should either
- * use ->readpage() or do the necessary surgery to decouple ->readpages()
- * from read-ahead.
  */
 static int f2fs_mpage_readpages(struct inode *inode,
 		struct readahead_control *rac, struct page *page)
@@ -2292,7 +2287,6 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	unsigned nr_pages = rac ? readahead_count(rac) : 1;
 	unsigned max_nr_pages = nr_pages;
 	int ret = 0;
-	bool drop_ra = false;
 
 	map.m_pblk = 0;
 	map.m_lblk = 0;
@@ -2303,26 +2297,10 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	map.m_seg_type = NO_CHECK_TYPE;
 	map.m_may_create = false;
 
-	/*
-	 * Two readahead threads for same address range can cause race condition
-	 * which fragments sequential read IOs. So let's avoid each other.
-	 */
-	if (rac && readahead_count(rac)) {
-		if (READ_ONCE(F2FS_I(inode)->ra_offset) == readahead_index(rac))
-			drop_ra = true;
-		else
-			WRITE_ONCE(F2FS_I(inode)->ra_offset,
-						readahead_index(rac));
-	}
-
 	for (; nr_pages; nr_pages--) {
 		if (rac) {
 			page = readahead_page(rac);
 			prefetchw(&page->flags);
-			if (drop_ra) {
-				f2fs_put_page(page, 1);
-				continue;
-			}
 		}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -2385,9 +2363,6 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	}
 	if (bio)
 		__submit_bio(F2FS_I_SB(inode), bio, DATA);
-
-	if (rac && readahead_count(rac) && !drop_ra)
-		WRITE_ONCE(F2FS_I(inode)->ra_offset, -1);
 	return ret;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 980e061f7968..114a72a99df7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -718,7 +718,6 @@ struct f2fs_inode_info {
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct task_struct *inmem_task;	/* store inmemory task */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
-	pgoff_t ra_offset;		/* ongoing readahead offset */
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
 
 	/* avoid racing between foreground op and gc */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1d42a59fb982..a25a2db273a3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1156,8 +1156,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
 
-	fi->ra_offset = -1;
-
 	return &fi->vfs_inode;
 }
 
-- 
2.29.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
