From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/9] f2fs: avoid unneeded initializing when
 converting inline dentry
Date: Wed, 19 Aug 2015 19:10:19 +0800
Message-ID: <017601d0da6f$bcb555d0$36200170$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZS1Gz-0005KQ-Kw
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Aug 2015 11:11:13 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZS1Gw-0004Wa-Bi
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Aug 2015 11:11:13 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NTB012ADTQEDQ20@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Aug 2015 20:11:02 +0900 (KST)
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
 fs/f2fs/inline.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 79d18d5..e4da0d7 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -384,17 +384,30 @@ static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
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
+	 * reserved space size of inline dentry is larger than the one of
+	 * regular dentry, here we just copy with the size of reserved space
+	 * in regular dentry.
+	 */
+	memcpy(dentry_blk->reserved, inline_dentry->reserved, SIZE_OF_RESERVED);
 	memcpy(dentry_blk->dentry, inline_dentry->dentry,
 			sizeof(struct f2fs_dir_entry) * NR_INLINE_DENTRY);
+	memset(dentry_blk->dentry + NR_INLINE_DENTRY, 0,
+			sizeof (struct f2fs_dir_entry) *
+			(NR_DENTRY_IN_BLOCK - NR_INLINE_DENTRY));
 	memcpy(dentry_blk->filename, inline_dentry->filename,
 					NR_INLINE_DENTRY * F2FS_SLOT_LEN);
+	memset(&dentry_blk->filename[NR_INLINE_DENTRY][0], 0,
+		F2FS_SLOT_LEN * (NR_DENTRY_IN_BLOCK - NR_INLINE_DENTRY));
 
 	kunmap_atomic(dentry_blk);
 	SetPageUptodate(page);
-- 
2.4.2



------------------------------------------------------------------------------
