From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: support FALLOC_FL_INSERT_RANGE
Date: Thu, 28 May 2015 19:16:57 +0800
Message-ID: <007601d09937$e8dbbbf0$ba9333d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Yxvov-0004Rf-1h
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 May 2015 11:17:53 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Yxvot-0007ww-9R
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 May 2015 11:17:53 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NP200DKX4PK3F80@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 May 2015 20:17:44 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

FALLOC_FL_INSERT_RANGE flag for ->fallocate was introduced in commit
dd46c787788d ("fs: Add support FALLOC_FL_INSERT_RANGE for fallocate").

The effect of FALLOC_FL_INSERT_RANGE command is the opposite of
FALLOC_FL_COLLAPSE_RANGE, if this command was performed, all data from
offset to EOF in our file will be shifted to right as given length, and
then range [offset, offset + length] becomes a hole.

This command is useful for our user who wants to add some data in the
middle of the file, for example: video/music editor will insert a keyframe
in specified position of media file, with this command we can easily create
a hole for inserting without removing original data.

This patch introduces f2fs_insert_range() to support FALLOC_FL_INSERT_RANGE.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Yuan Zhong <yuan.mark.zhong@samsung.com>
---
 fs/f2fs/file.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index aec96d3..4d42d66 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1010,6 +1010,100 @@ out:
 	return ret;
 }
 
+static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	pgoff_t pg_start, pg_end, delta, nrpages, idx;
+	loff_t new_size;
+	int ret;
+
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	new_size = i_size_read(inode) + len;
+	if (new_size > inode->i_sb->s_maxbytes)
+		return -EFBIG;
+
+	if (offset >= i_size_read(inode))
+		return -EINVAL;
+
+	/* insert range should be aligned to block size of f2fs. */
+	if (offset & (F2FS_BLKSIZE - 1) || len & (F2FS_BLKSIZE - 1))
+		return -EINVAL;
+
+	f2fs_balance_fs(sbi);
+
+	ret = truncate_blocks(inode, i_size_read(inode), true);
+	if (ret)
+		return ret;
+
+	/* write out all dirty pages from offset */
+	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
+	if (ret)
+		return ret;
+
+	truncate_pagecache(inode, offset);
+
+	pg_start = offset >> PAGE_CACHE_SHIFT;
+	pg_end = (offset + len) >> PAGE_CACHE_SHIFT;
+	delta = pg_end - pg_start;
+	nrpages = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
+
+	for (idx = nrpages - 1; idx >= pg_start && idx != -1; idx--) {
+		struct dnode_of_data dn;
+		struct page *ipage;
+		block_t new_addr, old_addr;
+
+		f2fs_lock_op(sbi);
+
+		set_new_dnode(&dn, inode, NULL, NULL, 0);
+		ret = get_dnode_of_data(&dn, idx, LOOKUP_NODE_RA);
+		if (ret && ret != -ENOENT) {
+			goto out;
+		} else if (ret == -ENOENT) {
+			goto next;
+		} else if (dn.data_blkaddr == NULL_ADDR) {
+			f2fs_put_dnode(&dn);
+			goto next;
+		} else {
+			new_addr = dn.data_blkaddr;
+			truncate_data_blocks_range(&dn, 1);
+			f2fs_put_dnode(&dn);
+		}
+
+		ipage = get_node_page(sbi, inode->i_ino);
+		if (IS_ERR(ipage)) {
+			ret = PTR_ERR(ipage);
+			goto out;
+		}
+
+		set_new_dnode(&dn, inode, ipage, NULL, 0);
+		ret = f2fs_reserve_block(&dn, idx + delta);
+		if (ret)
+			goto out;
+
+		old_addr = dn.data_blkaddr;
+		f2fs_bug_on(sbi, old_addr != NEW_ADDR);
+
+		if (new_addr != NEW_ADDR) {
+			struct node_info ni;
+
+			get_node_info(sbi, dn.nid, &ni);
+			f2fs_replace_block(sbi, &dn, old_addr, new_addr,
+							ni.version, true);
+		}
+		f2fs_put_dnode(&dn);
+next:
+		f2fs_unlock_op(sbi);
+	}
+
+	i_size_write(inode, new_size);
+	return 0;
+out:
+	f2fs_unlock_op(sbi);
+	return ret;
+}
+
 static int expand_inode_data(struct inode *inode, loff_t offset,
 					loff_t len, int mode)
 {
@@ -1077,11 +1171,13 @@ static long f2fs_fallocate(struct file *file, int mode,
 	struct inode *inode = file_inode(file);
 	long ret = 0;
 
-	if (f2fs_encrypted_inode(inode) && (mode & FALLOC_FL_COLLAPSE_RANGE))
+	if (f2fs_encrypted_inode(inode) &&
+		(mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
 		return -EOPNOTSUPP;
 
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
-			FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE))
+			FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
+			FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
 
 	mutex_lock(&inode->i_mutex);
@@ -1095,6 +1191,8 @@ static long f2fs_fallocate(struct file *file, int mode,
 		ret = f2fs_collapse_range(inode, offset, len);
 	} else if (mode & FALLOC_FL_ZERO_RANGE) {
 		ret = f2fs_zero_range(inode, offset, len, mode);
+	} else if (mode & FALLOC_FL_INSERT_RANGE) {
+		ret = f2fs_insert_range(inode, offset, len);
 	} else {
 		ret = expand_inode_data(inode, offset, len, mode);
 	}
-- 
2.3.3



------------------------------------------------------------------------------
