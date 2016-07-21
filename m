From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: support an ioctl to move a range of
	data blocks
Date: Wed, 20 Jul 2016 20:42:03 -0700
Message-ID: <20160721034205.99473-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bQ4sL-0004WP-Ks
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Jul 2016 03:42:17 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bQ4sK-0007Md-DM
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Jul 2016 03:42:17 +0000
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

This patch implements moving a range of data blocks from source file to
destination file.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h |   9 ++++
 fs/f2fs/file.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c737854..7a57279 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -268,6 +268,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_IOC_GARBAGE_COLLECT	_IO(F2FS_IOCTL_MAGIC, 6)
 #define F2FS_IOC_WRITE_CHECKPOINT	_IO(F2FS_IOCTL_MAGIC, 7)
 #define F2FS_IOC_DEFRAGMENT		_IO(F2FS_IOCTL_MAGIC, 8)
+#define F2FS_IOC_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
+						struct f2fs_move_range)
 
 #define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
 #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
@@ -297,6 +299,13 @@ struct f2fs_defragment {
 	u64 len;
 };
 
+struct f2fs_move_range {
+	u32 dst_fd;		/* destination fd */
+	u64 pos_in;		/* start position in src_fd */
+	u64 pos_out;		/* start position in dst_fd */
+	u64 len;		/* size to move */
+};
+
 /*
  * For INODE and NODE manager
  */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9f9cb64..0e493f6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -21,6 +21,7 @@
 #include <linux/mount.h>
 #include <linux/pagevec.h>
 #include <linux/uuid.h>
+#include <linux/file.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -2068,6 +2069,133 @@ out:
 	return err;
 }
 
+static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
+			struct file *file_out, loff_t pos_out, size_t len)
+{
+	struct inode *src = file_inode(file_in);
+	struct inode *dst = file_inode(file_out);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(src);
+	size_t olen = len, dst_max_i_size = 0;
+	size_t dst_osize;
+	int ret;
+
+	if (file_in->f_path.mnt != file_out->f_path.mnt ||
+				src->i_sb != dst->i_sb)
+		return -EXDEV;
+
+	if (unlikely(f2fs_readonly(src->i_sb)))
+		return -EROFS;
+
+	if (S_ISDIR(src->i_mode) || S_ISDIR(dst->i_mode))
+		return -EISDIR;
+
+	if (f2fs_encrypted_inode(src) || f2fs_encrypted_inode(dst))
+		return -EOPNOTSUPP;
+
+	inode_lock(src);
+	if (src != dst)
+		inode_lock(dst);
+
+	ret = -EINVAL;
+	if (pos_in + len > src->i_size || pos_in + len < pos_in)
+		goto out_unlock;
+	if (len == 0)
+		olen = len = src->i_size - pos_in;
+	if (pos_in + len == src->i_size)
+		len = ALIGN(src->i_size, F2FS_BLKSIZE) - pos_in;
+	if (len == 0) {
+		ret = 0;
+		goto out_unlock;
+	}
+
+	dst_osize = dst->i_size;
+	if (pos_out + olen > dst->i_size)
+		dst_max_i_size = pos_out + olen;
+
+	/* verify the end result is block aligned */
+	if (!IS_ALIGNED(pos_in, F2FS_BLKSIZE) ||
+			!IS_ALIGNED(pos_in + len, F2FS_BLKSIZE) ||
+			!IS_ALIGNED(pos_out, F2FS_BLKSIZE))
+		goto out_unlock;
+
+	ret = f2fs_convert_inline_inode(src);
+	if (ret)
+		goto out_unlock;
+
+	ret = f2fs_convert_inline_inode(dst);
+	if (ret)
+		goto out_unlock;
+
+	/* write out all dirty pages from offset */
+	ret = filemap_write_and_wait_range(src->i_mapping,
+					pos_in, pos_in + len);
+	if (ret)
+		goto out_unlock;
+
+	ret = filemap_write_and_wait_range(dst->i_mapping,
+					pos_out, pos_out + len);
+	if (ret)
+		goto out_unlock;
+
+	f2fs_balance_fs(sbi, true);
+	f2fs_lock_op(sbi);
+	ret = __exchange_data_block(src, dst, pos_in,
+				pos_out, len >> F2FS_BLKSIZE_BITS, false);
+
+	if (!ret) {
+		if (dst_max_i_size)
+			f2fs_i_size_write(dst, dst_max_i_size);
+		else if (dst_osize != dst->i_size)
+			f2fs_i_size_write(dst, dst_osize);
+	}
+	f2fs_unlock_op(sbi);
+out_unlock:
+	if (src != dst)
+		inode_unlock(dst);
+	inode_unlock(src);
+	return ret;
+}
+
+static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
+{
+	struct f2fs_move_range range;
+	struct fd dst;
+	int err;
+
+	if (!(filp->f_mode & FMODE_READ) ||
+			!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (copy_from_user(&range, (struct f2fs_move_range __user *)arg,
+							sizeof(range)))
+		return -EFAULT;
+
+	dst = fdget(range.dst_fd);
+	if (!dst.file)
+		return -EBADF;
+
+	if (!(dst.file->f_mode & FMODE_WRITE)) {
+		err = -EBADF;
+		goto err_out;
+	}
+
+	err = mnt_want_write_file(filp);
+	if (err)
+		goto err_out;
+
+	err = f2fs_move_file_range(filp, range.pos_in, dst.file,
+					range.pos_out, range.len);
+
+	mnt_drop_write_file(filp);
+
+	if (copy_to_user((struct f2fs_move_range __user *)arg,
+						&range, sizeof(range)))
+		err = -EFAULT;
+err_out:
+	fdput(dst);
+	return err;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -2103,6 +2231,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_write_checkpoint(filp, arg);
 	case F2FS_IOC_DEFRAGMENT:
 		return f2fs_ioc_defragment(filp, arg);
+	case F2FS_IOC_MOVE_RANGE:
+		return f2fs_ioc_move_range(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -2163,6 +2293,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_WRITE_CHECKPOINT:
 	case F2FS_IOC_DEFRAGMENT:
 		break;
+	case F2FS_IOC_MOVE_RANGE:
+		break;
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
