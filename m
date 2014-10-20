From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 11/11] f2fs: use kmap_atomic instead of kmap
Date: Sun, 19 Oct 2014 22:19:39 -0700
Message-ID: <1413782379-11758-11-git-send-email-jaegeuk@kernel.org>
References: <1413782379-11758-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xg5Nx-0007qQ-G3
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:20:01 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xg5Nw-0006iD-Lu for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:20:01 +0000
In-Reply-To: <1413782379-11758-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

For better performance, we need to use kmap_atomic instead of kmap.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inline.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 825995f..c03653d 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -55,11 +55,10 @@ int f2fs_read_inline_data(struct inode *inode, struct page *page)
 
 	/* Copy the whole inline data block */
 	src_addr = inline_data_addr(ipage);
-	dst_addr = kmap(page);
+	dst_addr = kmap_atomic(page);
 	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
-	kunmap(page);
+	kunmap_atomic(dst_addr);
 	f2fs_put_page(ipage, 1);
-
 out:
 	SetPageUptodate(page);
 	unlock_page(page);
@@ -105,9 +104,9 @@ static int __f2fs_convert_inline_data(struct inode *inode, struct page *page)
 
 	/* Copy the whole inline data block */
 	src_addr = inline_data_addr(ipage);
-	dst_addr = kmap(page);
+	dst_addr = kmap_atomic(page);
 	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
-	kunmap(page);
+	kunmap_atomic(dst_addr);
 	SetPageUptodate(page);
 
 	/* write data page to try to make data consistent */
@@ -177,10 +176,10 @@ int f2fs_write_inline_data(struct inode *inode,
 	f2fs_wait_on_page_writeback(ipage, NODE);
 	zero_user_segment(ipage, INLINE_DATA_OFFSET,
 				 INLINE_DATA_OFFSET + MAX_INLINE_DATA);
-	src_addr = kmap(page);
+	src_addr = kmap_atomic(page);
 	dst_addr = inline_data_addr(ipage);
 	memcpy(dst_addr, src_addr, size);
-	kunmap(page);
+	kunmap_atomic(src_addr);
 
 	set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
 	sync_inode_page(&dn);
@@ -351,7 +350,7 @@ int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
 	f2fs_wait_on_page_writeback(page, DATA);
 	zero_user_segment(page, 0, PAGE_CACHE_SIZE);
 
-	dentry_blk = kmap(page);
+	dentry_blk = kmap_atomic(page);
 
 	/* copy data from inline dentry block to new dentry block */
 	memcpy(dentry_blk->dentry_bitmap, inline_dentry->dentry_bitmap,
@@ -363,7 +362,7 @@ int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
 	memcpy(dentry_blk->filename, inline_dentry->filename,
 					NR_INLINE_DENTRY * F2FS_SLOT_LEN);
 
-	kunmap(page);
+	kunmap_atomic(dentry_blk);
 	SetPageUptodate(page);
 	set_page_dirty(page);
 
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
