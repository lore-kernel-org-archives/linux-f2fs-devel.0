From: sunqiuyang <sunqiuyang@huawei.com>
Subject: [PATCH 1/3] f2fs:dax: fix races between page faults and
	fallocate
Date: Thu, 4 May 2017 08:16:59 +0800
Message-ID: <1493857019-40586-1-git-send-email-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunqiuyang@huawei.com>) id 1d64Pt-0002i3-0J
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 May 2017 00:14:45 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d64Pr-0001F8-1f
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 May 2017 00:14:44 +0000
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
Cc: wenyuzhong1@huawei.com, wangxiaojun11@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com, guzheng1@huawei.com, yanaijie@huawei.com, zhaohongjiang@huawei.com, dingxiang@huawei.com, wangyijing@huawei.com, sunqiuyang@huawei.com

Currently in F2FS, page faults and fallocate operations, like punch_hole 
and collapse/insert/zero_range, are completely unsynchronized. This can 
result in page fault faulting in a page into a range that we are changing 
after truncating pagecache, and thus we can end up with a page mapped to 
disk blocks that will be shortly freed. Filesystem corruption will shortly 
follow. 

This patch fixes the problem by creating new rw semaphore i_mmap_sem in 
f2fs_inode_info and grab it for functions removing blocks from extent tree 
and for read over page faults. The mechanism is similar to that in ext4.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/file.c  | 30 +++++++++++++++++++++---------
 fs/f2fs/super.c |  1 +
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0a6e115..f7957ca 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -474,6 +474,7 @@ struct f2fs_inode_info {
 	struct mutex inmem_lock;	/* lock for inmemory pages */
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
 	struct rw_semaphore dio_rwsem[2];/* avoid racing between dio and gc */
+	struct rw_semaphore i_mmap_sem;
 };
 
 static inline void get_extent_info(struct extent_info *ext,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5f73178..165acbf 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -813,22 +813,23 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	off_start = offset & (PAGE_SIZE - 1);
 	off_end = (offset + len) & (PAGE_SIZE - 1);
 
+	down_write(&F2FS_I(inode)->i_mmap_sem);
 	if (pg_start == pg_end) {
 		ret = fill_zero(inode, pg_start, off_start,
 						off_end - off_start);
 		if (ret)
-			return ret;
+			goto out;
 	} else {
 		if (off_start) {
 			ret = fill_zero(inode, pg_start++, off_start,
 						PAGE_SIZE - off_start);
 			if (ret)
-				return ret;
+				goto out;
 		}
 		if (off_end) {
 			ret = fill_zero(inode, pg_end, 0, off_end);
 			if (ret)
-				return ret;
+				goto out;
 		}
 
 		if (pg_start < pg_end) {
@@ -849,6 +850,8 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		}
 	}
 
+out:
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 	return ret;
 }
 
@@ -1084,16 +1087,17 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	pg_start = offset >> PAGE_SHIFT;
 	pg_end = (offset + len) >> PAGE_SHIFT;
 
+	down_write(&F2FS_I(inode)->i_mmap_sem);
 	/* write out all dirty pages from offset */
 	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
 	if (ret)
-		return ret;
+		goto out;
 
 	truncate_pagecache(inode, offset);
 
 	ret = f2fs_do_collapse(inode, pg_start, pg_end);
 	if (ret)
-		return ret;
+		goto out;
 
 	/* write out all moved pages, if possible */
 	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
@@ -1106,6 +1110,8 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
 
+out:
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 	return ret;
 }
 
@@ -1182,11 +1188,12 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	off_start = offset & (PAGE_SIZE - 1);
 	off_end = (offset + len) & (PAGE_SIZE - 1);
 
+	down_write(&F2FS_I(inode)->i_mmap_sem);
 	if (pg_start == pg_end) {
 		ret = fill_zero(inode, pg_start, off_start,
 						off_end - off_start);
 		if (ret)
-			return ret;
+			goto unlock;
 
 		if (offset + len > new_size)
 			new_size = offset + len;
@@ -1196,7 +1203,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			ret = fill_zero(inode, pg_start++, off_start,
 						PAGE_SIZE - off_start);
 			if (ret)
-				return ret;
+				goto unlock;
 
 			new_size = max_t(loff_t, new_size,
 					(loff_t)pg_start << PAGE_SHIFT);
@@ -1245,6 +1252,8 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 out:
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && i_size_read(inode) < new_size)
 		f2fs_i_size_write(inode, new_size);
+unlock:
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 
 	return ret;
 }
@@ -1271,16 +1280,17 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
+	down_write(&F2FS_I(inode)->i_mmap_sem);
 	f2fs_balance_fs(sbi, true);
 
 	ret = truncate_blocks(inode, i_size_read(inode), true);
 	if (ret)
-		return ret;
+		goto out;
 
 	/* write out all dirty pages from offset */
 	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
 	if (ret)
-		return ret;
+		goto out;
 
 	truncate_pagecache(inode, offset);
 
@@ -1309,6 +1319,8 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
+out:
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 	return ret;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 96fe8ed..30855cf 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -616,6 +616,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	mutex_init(&fi->inmem_lock);
 	init_rwsem(&fi->dio_rwsem[READ]);
 	init_rwsem(&fi->dio_rwsem[WRITE]);
+	init_rwsem(&fi->i_mmap_sem);
 
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
-- 
1.8.3.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
