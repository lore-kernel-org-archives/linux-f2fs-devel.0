From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/4] f2fs: avoid race in between GC and block
 exchange
Date: Thu, 2 Nov 2017 20:41:04 +0800
Message-ID: <20171102124104.75298-4-yuchao0@huawei.com>
References: <20171102124104.75298-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1eAEoL-0006yT-Hs
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 12:41:29 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1eAEoK-0000sv-12
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 12:41:29 +0000
In-Reply-To: <20171102124104.75298-1-yuchao0@huawei.com>
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
 fs/f2fs/file.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0e09b9f02dc5..21ae4faa7c58 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1186,6 +1186,9 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		goto out;
 
+	/* avoid gc operation during block exchange */
+	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+
 	truncate_pagecache(inode, offset);
 
 	ret = f2fs_do_collapse(inode, pg_start, pg_end);
@@ -1204,6 +1207,7 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 		f2fs_i_size_write(inode, new_size);
 
 out:
+	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 	up_write(&F2FS_I(inode)->i_mmap_sem);
 	return ret;
 }
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
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
