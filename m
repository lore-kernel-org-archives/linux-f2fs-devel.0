From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: remove redundant block plug
Date: Sun, 8 Apr 2018 11:34:39 +0800
Message-ID: <20180408033439.24830-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>, Yunlei He <heyunlei@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

For buffered IO, we don't need to use block plug to cache bio,
for direct IO, generic f2fs_direct_IO has already added block
plug, so let's remove redundant one in .write_iter.

As Yunlei described in his patch:

-f2fs_file_write_iter
  -blk_start_plug
    -__generic_file_write_iter
	...
	  -do_blockdev_direct_IO
	    -blk_start_plug
		...
	    -blk_finish_plug
	...
  -blk_finish_plug

which may conduct performance decrease in our platform

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7b8fb31086c3..cb315d23c56f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2886,7 +2886,6 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	struct blk_plug plug;
 	ssize_t ret;
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
@@ -2931,9 +2930,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 				return err;
 			}
 		}
-		blk_start_plug(&plug);
 		ret = __generic_file_write_iter(iocb, from);
-		blk_finish_plug(&plug);
 		clear_inode_flag(inode, FI_NO_PREALLOC);
 
 		/* if we couldn't write data, we should deallocate blocks. */
-- 
2.15.0.55.gc2ece9dc4de6
