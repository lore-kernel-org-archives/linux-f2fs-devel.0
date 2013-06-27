From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 2/2] f2fs: fix to recover i_size from roll-forward
Date: Thu, 27 Jun 2013 13:17:28 +0900
Message-ID: <1372306648-26438-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1372306648-26438-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Us3eP-0007rM-ON
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Jun 2013 04:17:41 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Us3eN-000312-QG for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Jun 2013 04:17:41 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MP100626AL5C730@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Jun 2013 13:17:29 +0900 (KST)
In-reply-to: <1372306648-26438-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If user requests many data writes and fsync together, the last updated i_size
should be stored to the inode block consistently.

But, previous write_end just marks the inode as dirty and doesn't update its
metadata into its inode block.
After that, fsync just writes the inode block with newly updated data index
excluding inode metadata updates.

So, this patch introduces write_end in which updates inode block too when the
i_size is changed.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6d4a743..e88f46f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -701,6 +701,27 @@ err:
 	return err;
 }
 
+static int f2fs_write_end(struct file *file,
+			struct address_space *mapping,
+			loff_t pos, unsigned len, unsigned copied,
+			struct page *page, void *fsdata)
+{
+	struct inode *inode = page->mapping->host;
+
+	SetPageUptodate(page);
+	set_page_dirty(page);
+
+	if (pos + copied > i_size_read(inode)) {
+		i_size_write(inode, pos + copied);
+		mark_inode_dirty(inode);
+		update_inode_page(inode);
+	}
+
+	unlock_page(page);
+	page_cache_release(page);
+	return copied;
+}
+
 static ssize_t f2fs_direct_IO(int rw, struct kiocb *iocb,
 		const struct iovec *iov, loff_t offset, unsigned long nr_segs)
 {
@@ -757,7 +778,7 @@ const struct address_space_operations f2fs_dblock_aops = {
 	.writepage	= f2fs_write_data_page,
 	.writepages	= f2fs_write_data_pages,
 	.write_begin	= f2fs_write_begin,
-	.write_end	= nobh_write_end,
+	.write_end	= f2fs_write_end,
 	.set_page_dirty	= f2fs_set_data_page_dirty,
 	.invalidatepage	= f2fs_invalidate_data_page,
 	.releasepage	= f2fs_release_data_page,
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
