From: Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] f2fs: remove redundant check in
 f2fs_file_write_iter()
Date: Tue, 23 Apr 2019 13:08:35 +0800
Message-ID: <20190423050835.4642-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <cgxu519@gmx.com>) id 1hIngL-0002Ie-Tn
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Apr 2019 05:09:25 +0000
Received: from mout.gmx.net ([212.227.15.19])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hInfy-007nvP-SO
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Apr 2019 05:09:25 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: Chengguang Xu <cgxu519@gmx.com>, linux-f2fs-devel@lists.sourceforge.net

We have already checked flag IOCB_DIRECT in the sanity
check of flag IOCB_NOWAIT, so don't have to check it
again here.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/f2fs/file.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5742ab8b57dc..43b6a0b08497 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3056,18 +3056,15 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (iov_iter_fault_in_readable(from, iov_iter_count(from)))
 			set_inode_flag(inode, FI_NO_PREALLOC);

-		if ((iocb->ki_flags & IOCB_NOWAIT) &&
-			(iocb->ki_flags & IOCB_DIRECT)) {
-				if (!f2fs_overwrite_io(inode, iocb->ki_pos,
-						iov_iter_count(from)) ||
-					f2fs_has_inline_data(inode) ||
-					f2fs_force_buffered_io(inode,
-							iocb, from)) {
-						clear_inode_flag(inode,
-								FI_NO_PREALLOC);
-						inode_unlock(inode);
-						return -EAGAIN;
-				}
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			if (!f2fs_overwrite_io(inode, iocb->ki_pos,
+			    iov_iter_count(from)) ||
+			    f2fs_has_inline_data(inode) ||
+			    f2fs_force_buffered_io(inode, iocb, from)) {
+				clear_inode_flag(inode, FI_NO_PREALLOC);
+				inode_unlock(inode);
+				return -EAGAIN;
+			}

 		} else {
 			preallocated = true;
--
2.20.1
