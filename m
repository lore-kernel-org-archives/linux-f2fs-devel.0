From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/5] f2fs: add tracepoint for
 f2fs_file_write_iter()
Date: Tue, 2 Apr 2019 18:52:22 +0800
Message-ID: <20190402105222.28374-5-yuchao0@huawei.com>
References: <20190402105222.28374-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hBH2K-0007R0-W2
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Apr 2019 10:53:00 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hBH2J-009ALG-9p
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Apr 2019 10:53:00 +0000
In-Reply-To: <20190402105222.28374-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds tracepoint for f2fs_file_write_iter().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c              | 28 +++++++++++++++++++---------
 include/trace/events/f2fs.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 578486e03427..65e14ec7366f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3037,15 +3037,21 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(file);
 	ssize_t ret;
 
-	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
-		return -EIO;
+	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode)))) {
+		ret = -EIO;
+		goto out;
+	}
 
-	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
-		return -EINVAL;
+	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	if (!inode_trylock(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			return -EAGAIN;
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			ret = -EAGAIN;
+			goto out;
+		}
 		inode_lock(inode);
 	}
 
@@ -3068,7 +3074,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 						clear_inode_flag(inode,
 								FI_NO_PREALLOC);
 						inode_unlock(inode);
-						return -EAGAIN;
+						ret = -EAGAIN;
+						goto out;
 				}
 
 		} else {
@@ -3079,7 +3086,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			if (err) {
 				clear_inode_flag(inode, FI_NO_PREALLOC);
 				inode_unlock(inode);
-				return err;
+				ret = err;
+				goto out;
 			}
 		}
 		ret = __generic_file_write_iter(iocb, from);
@@ -3093,7 +3101,9 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
 	}
 	inode_unlock(inode);
-
+out:
+	trace_f2fs_file_write_iter(inode, iocb->ki_pos,
+					iov_iter_count(from), ret);
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
 	return ret;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 1b39b50511f5..9d63457c1232 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -533,6 +533,37 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
 		__entry->err)
 );
 
+TRACE_EVENT(f2fs_file_write_iter,
+
+	TP_PROTO(struct inode *inode, unsigned long offset,
+		unsigned long length, int ret),
+
+	TP_ARGS(inode, offset, length, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(unsigned long, offset)
+		__field(unsigned long, length)
+		__field(int,	ret)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->offset	= offset;
+		__entry->length	= length;
+		__entry->ret	= ret;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, "
+		"offset = %lu, length = %lu, written(err) = %d",
+		show_dev_ino(__entry),
+		__entry->offset,
+		__entry->length,
+		__entry->ret)
+);
+
 TRACE_EVENT(f2fs_map_blocks,
 	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map, int ret),
 
-- 
2.18.0.rc1
