From: <guoweichao@huawei.com>
Subject: [PATCH v2] f2fs: convert inline data for direct I/O &
 FI_NO_PREALLOC
Date: Fri, 29 Sep 2017 22:43:23 +0800
Message-ID: <20170929144323.170386-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <guoweichao@huawei.com>)
 id 1dxpBt-00064u-VM
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Sep 2017 06:54:29 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dxpBp-0000lV-ML
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Sep 2017 06:54:29 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org
Cc: Weichao Guo <guoweichao@huawei.com>, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

From: Weichao Guo <guoweichao@huawei.com>

In FI_NO_PREALLOC cases, direct I/O path may allocate blocks for an
inode but keep its inline data flag. This inconsistency may trigger
vfs clear_inode nrpages bug_on when evicting the inode. We should
convert inline data first in this case.

Signed-off-by: Weichao Guo <guoweichao@huawei.com>
---
 fs/f2fs/data.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 36b5352..3793ba4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -833,6 +833,13 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 	struct f2fs_map_blocks map;
 	int err = 0;
 
+	/* convert inline data for Direct I/O*/
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		err = f2fs_convert_inline_inode(inode);
+		if (err)
+			return err;
+	}
+
 	if (is_inode_flag_set(inode, FI_NO_PREALLOC))
 		return 0;
 
@@ -845,15 +852,11 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 
 	map.m_next_pgofs = NULL;
 
-	if (iocb->ki_flags & IOCB_DIRECT) {
-		err = f2fs_convert_inline_inode(inode);
-		if (err)
-			return err;
+	if (iocb->ki_flags & IOCB_DIRECT)
 		return f2fs_map_blocks(inode, &map, 1,
 			__force_buffered_io(inode, WRITE) ?
 				F2FS_GET_BLOCK_PRE_AIO :
 				F2FS_GET_BLOCK_PRE_DIO);
-	}
 	if (iocb->ki_pos + iov_iter_count(from) > MAX_INLINE_DATA(inode)) {
 		err = f2fs_convert_inline_inode(inode);
 		if (err)
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
