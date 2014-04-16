From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 2/3 v2] f2fs: fix to decrease the number of
 dirty dentry page
Date: Wed, 16 Apr 2014 14:10:52 +0900
Message-ID: <1397625052.7727.8.camel@kjgkr>
References: <1397559423-27411-1-git-send-email-jaegeuk.kim@samsung.com>
	<1397559423-27411-2-git-send-email-jaegeuk.kim@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WaI9f-0008Ol-B3
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Apr 2014 05:13:03 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WaI9d-0003mo-CZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Apr 2014 05:13:03 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N4300LFOYHHV4A0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Apr 2014 14:12:53 +0900 (KST)
In-reply-to: <1397559423-27411-2-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Change log from v1:
 o change the patch, which includes this bug fix

>From 0f3b8427b40b9ace829ba0b16336d5cd67589022 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Tue, 15 Apr 2014 16:04:15 +0900
Subject: [PATCH] f2fs: call redirty_page_for_writepage

This patch replace some general codes with redirty_page_for_writepage,
which
can be enabled after consideration on additional procedure like counting
dirty
pages appropriately.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c |  5 +----
 fs/f2fs/data.c       | 10 +++-------
 fs/f2fs/node.c       |  5 +----
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 890e23d..2902f7d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -174,10 +174,7 @@ no_write:
 	return 0;
 
 redirty_out:
-	dec_page_count(sbi, F2FS_DIRTY_META);
-	wbc->pages_skipped++;
-	account_page_redirty(page);
-	set_page_dirty(page);
+	redirty_page_for_writepage(wbc, page);
 	return AOP_WRITEPAGE_ACTIVATE;
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 45abd60..b5cd6d1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -798,10 +798,8 @@ static int f2fs_write_data_page(struct page *page,
 	 * this page does not have to be written to disk.
 	 */
 	offset = i_size & (PAGE_CACHE_SIZE - 1);
-	if ((page->index >= end_index + 1) || !offset) {
-		inode_dec_dirty_dents(inode);
+	if ((page->index >= end_index + 1) || !offset)
 		goto out;
-	}
 
 	zero_user_segment(page, offset, PAGE_CACHE_SIZE);
 write:
@@ -810,7 +808,6 @@ write:
 
 	/* Dentry blocks are controlled by checkpoint */
 	if (S_ISDIR(inode->i_mode)) {
-		inode_dec_dirty_dents(inode);
 		err = do_write_data_page(page, &fio);
 		goto done;
 	}
@@ -832,15 +829,14 @@ done:
 
 	clear_cold_data(page);
 out:
+	inode_dec_dirty_dents(inode);
 	unlock_page(page);
 	if (need_balance_fs)
 		f2fs_balance_fs(sbi);
 	return 0;
 
 redirty_out:
-	wbc->pages_skipped++;
-	account_page_redirty(page);
-	set_page_dirty(page);
+	redirty_page_for_writepage(wbc, page);
 	return AOP_WRITEPAGE_ACTIVATE;
 }
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a161e95..f760793 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1227,10 +1227,7 @@ static int f2fs_write_node_page(struct page
*page,
 	return 0;
 
 redirty_out:
-	dec_page_count(sbi, F2FS_DIRTY_NODES);
-	wbc->pages_skipped++;
-	account_page_redirty(page);
-	set_page_dirty(page);
+	redirty_page_for_writepage(wbc, page);
 	return AOP_WRITEPAGE_ACTIVATE;
 }
 
-- 
1.8.4.474.g128a96c


-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
