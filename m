From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 4/4] f2fs: avoid race in between GC and block
 exchange
Date: Fri, 3 Nov 2017 10:21:05 +0800
Message-ID: <20171103022105.26884-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1eARcg-0003ZO-GY
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Nov 2017 02:22:18 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1eARcc-000874-B4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Nov 2017 02:22:18 +0000
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

During block exchange in {insert,collapse,move}_range, page-block mapping
is unstable due to mapping moving or recovery, so there should be no
concurrent cache read operation rely on such mapping, nor cache write
operation to mess up block exchange.

So this patch let background GC be aware of that.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix error path handling.
- avoid data block read operation from GC.
 fs/f2fs/file.c | 26 +++++++++++++++++++++-----
 fs/f2fs/gc.c   |  7 +++++++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0e09b9f02dc5..cee0f36ba9a1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1186,11 +1186,14 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		goto out;
 
+	/* avoid gc operation during block exchange */
+	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+
 	truncate_pagecache(inode, offset);
 
 	ret = f2fs_do_collapse(inode, pg_start, pg_end);
 	if (ret)
-		goto out;
+		goto out_unlock;
 
 	/* write out all moved pages, if possible */
 	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
@@ -1202,7 +1205,8 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	ret = truncate_blocks(inode, new_size, true);
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
-
+out_unlock:
+	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 out:
 	up_write(&F2FS_I(inode)->i_mmap_sem);
 	return ret;
@@ -1385,6 +1389,9 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		goto out;
 
+	/* avoid gc operation during block exchange */
+	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+
 	truncate_pagecache(inode, offset);
 
 	pg_start = offset >> PAGE_SHIFT;
@@ -1412,6 +1419,8 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
+
+	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 out:
 	up_write(&F2FS_I(inode)->i_mmap_sem);
 	return ret;
@@ -2274,9 +2283,13 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	}
 
 	inode_lock(src);
+	down_write(&F2FS_I(src)->dio_rwsem[WRITE]);
 	if (src != dst) {
-		if (!inode_trylock(dst)) {
-			ret = -EBUSY;
+		ret = -EBUSY;
+		if (!inode_trylock(dst))
+			goto out;
+		if (!down_write_trylock(&F2FS_I(dst)->dio_rwsem[WRITE])) {
+			inode_unlock(dst);
 			goto out;
 		}
 	}
@@ -2336,9 +2349,12 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	}
 	f2fs_unlock_op(sbi);
 out_unlock:
-	if (src != dst)
+	if (src != dst) {
+		up_write(&F2FS_I(dst)->dio_rwsem[WRITE]);
 		inode_unlock(dst);
+	}
 out:
+	up_write(&F2FS_I(src)->dio_rwsem[WRITE]);
 	inode_unlock(src);
 	return ret;
 }
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 7af91c423456..0dd109454345 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -832,10 +832,17 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				continue;
 			}
 
+			if (!down_write_trylock(
+				&F2FS_I(inode)->dio_rwsem[WRITE])) {
+				iput(inode);
+				continue;
+			}
+
 			start_bidx = start_bidx_of_node(nofs, inode);
 			data_page = get_read_data_page(inode,
 					start_bidx + ofs_in_node, REQ_RAHEAD,
 					true);
+			up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 			if (IS_ERR(data_page)) {
 				iput(inode);
 				continue;
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
