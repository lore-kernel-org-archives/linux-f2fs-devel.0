From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: continue to do direct IO if we only preallocate partial blocks
Date: Wed, 3 Jan 2018 17:30:19 +0800
Message-ID: <20180103093019.13278-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

While doing direct IO, if we run out-of-space when we preallocate blocks,
we should not return ENOSPC error directly, instead, we should continue
to do following direct IO, which will keep directIO of f2fs acting like
other filesystems.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4ba9aa268632..557d6d1e65f7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -831,10 +831,12 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct f2fs_map_blocks map;
+	int flag;
 	int err = 0;
+	bool direct_io = iocb->ki_flags & IOCB_DIRECT;
 
 	/* convert inline data for Direct I/O*/
-	if (iocb->ki_flags & IOCB_DIRECT) {
+	if (direct_io) {
 		err = f2fs_convert_inline_inode(inode);
 		if (err)
 			return err;
@@ -853,25 +855,29 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 	map.m_next_pgofs = NULL;
 	map.m_seg_type = NO_CHECK_TYPE;
 
-	if (iocb->ki_flags & IOCB_DIRECT) {
+	if (direct_io) {
 		map.m_seg_type = rw_hint_to_seg_type(iocb->ki_hint);
-		return f2fs_map_blocks(inode, &map, 1,
-			__force_buffered_io(inode, WRITE) ?
-				F2FS_GET_BLOCK_PRE_AIO :
-				F2FS_GET_BLOCK_PRE_DIO);
+		flag = __force_buffered_io(inode, WRITE) ?
+					F2FS_GET_BLOCK_PRE_AIO :
+					F2FS_GET_BLOCK_PRE_DIO;
+		goto map_blocks;
 	}
 	if (iocb->ki_pos + iov_iter_count(from) > MAX_INLINE_DATA(inode)) {
 		err = f2fs_convert_inline_inode(inode);
 		if (err)
 			return err;
 	}
-	if (!f2fs_has_inline_data(inode)) {
-		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
-		if (map.m_len > 0 && err == -ENOSPC) {
-			set_inode_flag(inode, FI_NO_PREALLOC);
-			err = 0;
-		}
+	if (f2fs_has_inline_data(inode))
 		return err;
+
+	flag = F2FS_GET_BLOCK_PRE_AIO;
+
+map_blocks:
+	err = f2fs_map_blocks(inode, &map, 1, flag);
+	if (map.m_len > 0 && err == -ENOSPC) {
+		if (!direct_io)
+			set_inode_flag(inode, FI_NO_PREALLOC);
+		err = 0;
 	}
 	return err;
 }
-- 
2.15.0.55.gc2ece9dc4de6
