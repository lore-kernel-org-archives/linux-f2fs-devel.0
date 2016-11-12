From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: use err for f2fs_preallocate_blocks
Date: Fri, 11 Nov 2016 17:30:42 -0800
Message-ID: <20161112013043.8058-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c5N9i-00018q-Ho
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Nov 2016 01:30:54 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c5N9h-00007w-D1
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Nov 2016 01:30:54 +0000
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

This patch has no functional change.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 26 +++++++++++++-------------
 fs/f2fs/f2fs.h |  2 +-
 fs/f2fs/file.c | 35 +++++++++++++++++++----------------
 3 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 861173f..2938311 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -658,11 +658,11 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	return 0;
 }
 
-ssize_t f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
+int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct f2fs_map_blocks map;
-	ssize_t ret = 0;
+	int err = 0;
 
 	map.m_lblk = F2FS_BLK_ALIGN(iocb->ki_pos);
 	map.m_len = F2FS_BYTES_TO_BLK(iocb->ki_pos + iov_iter_count(from));
@@ -674,19 +674,19 @@ ssize_t f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 	map.m_next_pgofs = NULL;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
-		ret = f2fs_convert_inline_inode(inode);
-		if (ret)
-			return ret;
+		err = f2fs_convert_inline_inode(inode);
+		if (err)
+			return err;
 		return f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
 	}
 	if (iocb->ki_pos + iov_iter_count(from) > MAX_INLINE_DATA) {
-		ret = f2fs_convert_inline_inode(inode);
-		if (ret)
-			return ret;
+		err = f2fs_convert_inline_inode(inode);
+		if (err)
+			return err;
 	}
 	if (!f2fs_has_inline_data(inode))
 		return f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
-	return ret;
+	return err;
 }
 
 /*
@@ -863,19 +863,19 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 			pgoff_t *next_pgofs)
 {
 	struct f2fs_map_blocks map;
-	int ret;
+	int err;
 
 	map.m_lblk = iblock;
 	map.m_len = bh->b_size >> inode->i_blkbits;
 	map.m_next_pgofs = next_pgofs;
 
-	ret = f2fs_map_blocks(inode, &map, create, flag);
-	if (!ret) {
+	err = f2fs_map_blocks(inode, &map, create, flag);
+	if (!err) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
 		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
 		bh->b_size = map.m_len << inode->i_blkbits;
 	}
-	return ret;
+	return err;
 }
 
 static int get_data_block(struct inode *inode, sector_t iblock,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 96221b1..a1dcc60 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2160,7 +2160,7 @@ void f2fs_update_data_blkaddr(struct dnode_of_data *, block_t);
 int reserve_new_blocks(struct dnode_of_data *, blkcnt_t);
 int reserve_new_block(struct dnode_of_data *);
 int f2fs_get_block(struct dnode_of_data *, pgoff_t);
-ssize_t f2fs_preallocate_blocks(struct kiocb *, struct iov_iter *);
+int f2fs_preallocate_blocks(struct kiocb *, struct iov_iter *);
 int f2fs_reserve_block(struct dnode_of_data *, pgoff_t);
 struct page *get_read_data_page(struct inode *, pgoff_t, int, bool);
 struct page *find_data_page(struct inode *, pgoff_t);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 80eb6a1..6811d4c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1320,15 +1320,15 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	pgoff_t pg_end;
 	loff_t new_size = i_size_read(inode);
 	loff_t off_end;
-	int ret;
+	int err;
 
-	ret = inode_newsize_ok(inode, (len + offset));
-	if (ret)
-		return ret;
+	err = inode_newsize_ok(inode, (len + offset));
+	if (err)
+		return err;
 
-	ret = f2fs_convert_inline_inode(inode);
-	if (ret)
-		return ret;
+	err = f2fs_convert_inline_inode(inode);
+	if (err)
+		return err;
 
 	f2fs_balance_fs(sbi, true);
 
@@ -1340,12 +1340,12 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	if (off_end)
 		map.m_len++;
 
-	ret = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
-	if (ret) {
+	err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
+	if (err) {
 		pgoff_t last_off;
 
 		if (!map.m_len)
-			return ret;
+			return err;
 
 		last_off = map.m_lblk + map.m_len - 1;
 
@@ -1359,7 +1359,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && i_size_read(inode) < new_size)
 		f2fs_i_size_write(inode, new_size);
 
-	return ret;
+	return err;
 }
 
 static long f2fs_fallocate(struct file *file, int mode,
@@ -2263,12 +2263,15 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	inode_lock(inode);
 	ret = generic_write_checks(iocb, from);
 	if (ret > 0) {
-		ret = f2fs_preallocate_blocks(iocb, from);
-		if (!ret) {
-			blk_start_plug(&plug);
-			ret = __generic_file_write_iter(iocb, from);
-			blk_finish_plug(&plug);
+		int err = f2fs_preallocate_blocks(iocb, from);
+
+		if (err) {
+			inode_unlock(inode);
+			return err;
 		}
+		blk_start_plug(&plug);
+		ret = __generic_file_write_iter(iocb, from);
+		blk_finish_plug(&plug);
 	}
 	inode_unlock(inode);
 
-- 
2.8.3


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
