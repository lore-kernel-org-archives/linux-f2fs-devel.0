From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: fix redundant block allocation
Date: Fri, 11 Nov 2016 17:30:43 -0800
Message-ID: <20161112013043.8058-2-jaegeuk@kernel.org>
References: <20161112013043.8058-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c5N9k-0005Lc-7u
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Nov 2016 01:30:56 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c5N9j-0002y8-GM
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Nov 2016 01:30:56 +0000
In-Reply-To: <20161112013043.8058-1-jaegeuk@kernel.org>
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

In direct_IO path of f2fs_file_write_iter(),
1. f2fs_preallocate_blocks(F2FS_GET_BLOCK_PRE_DIO)
   -> allocate LBA X
2. f2fs_direct_IO()
   -> return 0;

Then,
f2fs_write_data_page() will allocate another LBA X+1.

This makes EIO triggered by HM-SMR.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2938311..59203a3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -658,6 +658,13 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	return 0;
 }
 
+static inline bool __force_buffered_io(struct inode *inode, int rw)
+{
+	return ((f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) ||
+			(rw == WRITE && test_opt(F2FS_I_SB(inode), LFS)) ||
+			F2FS_I_SB(inode)->s_ndevs);
+}
+
 int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -677,7 +684,10 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 		err = f2fs_convert_inline_inode(inode);
 		if (err)
 			return err;
-		return f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
+		return f2fs_map_blocks(inode, &map, 1,
+			__force_buffered_io(inode, WRITE) ?
+				F2FS_GET_BLOCK_PRE_AIO :
+				F2FS_GET_BLOCK_PRE_DIO);
 	}
 	if (iocb->ki_pos + iov_iter_count(from) > MAX_INLINE_DATA) {
 		err = f2fs_convert_inline_inode(inode);
@@ -1769,11 +1779,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (err)
 		return err;
 
-	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
-		return 0;
-	if (rw == WRITE && test_opt(F2FS_I_SB(inode), LFS))
-		return 0;
-	if (F2FS_I_SB(inode)->s_ndevs)
+	if (__force_buffered_io(inode, rw))
 		return 0;
 
 	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
-- 
2.8.3


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
