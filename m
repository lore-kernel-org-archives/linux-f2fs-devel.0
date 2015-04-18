From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: support FALLOC_FL_ZERO_RANGE
Date: Sat, 18 Apr 2015 18:02:23 +0800
Message-ID: <007a01d079be$de888360$9b998a20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YjPap-0002G2-Hp
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Apr 2015 10:03:19 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YjPan-0004n9-Vf
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Apr 2015 10:03:19 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NMZ0037KYLAFVC0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Apr 2015 19:03:10 +0900 (KST)
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

Now, FALLOC_FL_ZERO_RANGE flag in ->fallocate is supported in ext4/xfs.

In commit, the semantics of this flag is descripted as following:
"1) Make sure that both offset and len are block size aligned.
2) Update the i_size of inode by len bytes.
3) Compute the file's logical block number against offset. If the computed
   block number is not the starting block of the extent, split the extent
   such that the block number is the starting block of the extent.
4) Shift all the extents which are lying between [offset, last allocated extent]
   towards right by len bytes. This step will make a hole of len bytes
   at offset."

This patch implements fallocate's FALLOC_FL_ZERO_RANGE for f2fs.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 86bcc9c..b8099aa 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -890,6 +890,108 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	return ret;
 }
 
+static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
+								int mode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t index, pg_start, pg_end;
+	loff_t new_size = i_size_read(inode);
+	loff_t off_start, off_end;
+	int ret = 0;
+
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	ret = inode_newsize_ok(inode, (len + offset));
+	if (ret)
+		return ret;
+
+	f2fs_balance_fs(sbi);
+
+	if (f2fs_has_inline_data(inode)) {
+		ret = f2fs_convert_inline_inode(inode);
+		if (ret)
+			return ret;
+	}
+
+	ret = filemap_write_and_wait_range(mapping, offset, offset + len - 1);
+	if (ret)
+		return ret;
+
+	truncate_pagecache_range(inode, offset, offset + len - 1);
+
+	pg_start = ((unsigned long long) offset) >> PAGE_CACHE_SHIFT;
+	pg_end = ((unsigned long long) offset + len) >> PAGE_CACHE_SHIFT;
+
+	off_start = offset & (PAGE_CACHE_SIZE - 1);
+	off_end = (offset + len) & (PAGE_CACHE_SIZE - 1);
+
+	if (pg_start == pg_end) {
+		fill_zero(inode, pg_start, off_start, off_end - off_start);
+		if (offset + len > new_size)
+			new_size = offset + len;
+		new_size = max_t(loff_t, new_size, offset + len);
+	} else {
+		if (off_start) {
+			fill_zero(inode, pg_start++, off_start,
+					PAGE_CACHE_SIZE - off_start);
+			new_size = max_t(loff_t, new_size,
+						pg_start << PAGE_CACHE_SHIFT);
+		}
+
+		for (index = pg_start; index < pg_end; index++) {
+			struct dnode_of_data dn;
+			struct page *ipage;
+
+			f2fs_lock_op(sbi);
+
+			ipage = get_node_page(sbi, inode->i_ino);
+			if (IS_ERR(ipage)) {
+				ret = PTR_ERR(ipage);
+				f2fs_unlock_op(sbi);
+				goto out;
+			}
+
+			set_new_dnode(&dn, inode, ipage, NULL, 0);
+			ret = f2fs_reserve_block(&dn, index);
+			if (ret) {
+				f2fs_unlock_op(sbi);
+				goto out;
+			}
+
+			if (dn.data_blkaddr != NEW_ADDR) {
+				invalidate_blocks(sbi, dn.data_blkaddr);
+
+				dn.data_blkaddr = NEW_ADDR;
+				set_data_blkaddr(&dn);
+
+				dn.data_blkaddr = NULL_ADDR;
+				f2fs_update_extent_cache(&dn);
+			}
+			f2fs_put_dnode(&dn);
+			f2fs_unlock_op(sbi);
+
+			new_size = max_t(loff_t, new_size,
+					(index + 1) << PAGE_CACHE_SHIFT);
+		}
+
+		if (off_end) {
+			fill_zero(inode, pg_end, 0, off_end);
+			new_size = max_t(loff_t, new_size, offset + len);
+		}
+	}
+
+out:
+	if (!(mode & FALLOC_FL_KEEP_SIZE) && i_size_read(inode) < new_size) {
+		i_size_write(inode, new_size);
+		mark_inode_dirty(inode);
+		update_inode_page(inode);
+	}
+
+	return ret;
+}
+
 static int expand_inode_data(struct inode *inode, loff_t offset,
 					loff_t len, int mode)
 {
@@ -958,7 +1060,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 	long ret;
 
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
-			FALLOC_FL_COLLAPSE_RANGE))
+			FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE))
 		return -EOPNOTSUPP;
 
 	mutex_lock(&inode->i_mutex);
@@ -967,6 +1069,8 @@ static long f2fs_fallocate(struct file *file, int mode,
 		ret = punch_hole(inode, offset, len);
 	else if (mode & FALLOC_FL_COLLAPSE_RANGE)
 		ret = f2fs_collapse_range(inode, offset, len);
+	else if (mode & FALLOC_FL_ZERO_RANGE)
+		ret = f2fs_zero_range(inode, offset, len, mode);
 	else
 		ret = expand_inode_data(inode, offset, len, mode);
 
-- 
2.3.3



------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
