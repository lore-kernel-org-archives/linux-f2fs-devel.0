From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 2/9] f2fs: avoid unneeded initializing when
 converting inline dentry
Date: Mon, 24 Aug 2015 17:36:25 +0800
Message-ID: <001801d0de50$74c630c0$5e529240$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZToBu-000554-OS
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 09:37:22 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZToBs-0006KH-IJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 09:37:22 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NTK02VFUYQ048A0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 18:37:13 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

When converting inline dentry, we will zero out target dentry page before
duplicating data of inline dentry into target page, it become overhead
since inline dentry size is not small.

So this patch tries to remove unneeded initializing in the space of target
dentry page.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2:
 - remove unneeded memcpy/memset suggested by Jaegeuk Kim.
 fs/f2fs/inline.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 79d18d5..3d143be 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -384,13 +384,21 @@ static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
 		goto out;
 
 	f2fs_wait_on_page_writeback(page, DATA);
-	zero_user_segment(page, 0, PAGE_CACHE_SIZE);
+	zero_user_segment(page, MAX_INLINE_DATA, PAGE_CACHE_SIZE);
 
 	dentry_blk = kmap_atomic(page);
 
 	/* copy data from inline dentry block to new dentry block */
 	memcpy(dentry_blk->dentry_bitmap, inline_dentry->dentry_bitmap,
 					INLINE_DENTRY_BITMAP_SIZE);
+	memset(dentry_blk->dentry_bitmap + INLINE_DENTRY_BITMAP_SIZE, 0,
+			SIZE_OF_DENTRY_BITMAP - INLINE_DENTRY_BITMAP_SIZE);
+	/*
+	 * we do not need to zero out remainder part of dentry and filename
+	 * field, since we have used bitmap for marking the usage status of
+	 * them, besides, we can also ignore copying/zeroing reserved space
+	 * of dentry block, because them haven't been used so far.
+	 */
 	memcpy(dentry_blk->dentry, inline_dentry->dentry,
 			sizeof(struct f2fs_dir_entry) * NR_INLINE_DENTRY);
 	memcpy(dentry_blk->filename, inline_dentry->filename,
-- 
2.4.2



------------------------------------------------------------------------------
