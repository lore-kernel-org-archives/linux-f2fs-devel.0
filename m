From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: introduce macros to convert bytes and
	blocks in f2fs
Date: Tue, 10 Feb 2015 13:58:44 -0800
Message-ID: <1423605525-85348-3-git-send-email-jaegeuk@kernel.org>
References: <1423605525-85348-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YLIpi-0002bo-IH
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 10 Feb 2015 21:59:02 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YLIph-0007be-8X for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 10 Feb 2015 21:59:02 +0000
In-Reply-To: <1423605525-85348-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds two macros for transition between byte and block offsets.
Currently, f2fs only supports 4KB blocks, so use the default size for now.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c    | 7 +++----
 fs/f2fs/file.c          | 3 +--
 fs/f2fs/segment.c       | 8 ++++----
 include/linux/f2fs_fs.h | 4 ++++
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 31a715b..58d88df 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -981,15 +981,14 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	/* write out checkpoint buffer at block 0 */
 	cp_page = grab_meta_page(sbi, start_blk++);
 	kaddr = page_address(cp_page);
-	memcpy(kaddr, ckpt, (1 << sbi->log_blocksize));
+	memcpy(kaddr, ckpt, F2FS_BLKSIZE);
 	set_page_dirty(cp_page);
 	f2fs_put_page(cp_page, 1);
 
 	for (i = 1; i < 1 + cp_payload_blks; i++) {
 		cp_page = grab_meta_page(sbi, start_blk++);
 		kaddr = page_address(cp_page);
-		memcpy(kaddr, (char *)ckpt + i * F2FS_BLKSIZE,
-				(1 << sbi->log_blocksize));
+		memcpy(kaddr, (char *)ckpt + i * F2FS_BLKSIZE, F2FS_BLKSIZE);
 		set_page_dirty(cp_page);
 		f2fs_put_page(cp_page, 1);
 	}
@@ -1009,7 +1008,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	/* writeout checkpoint block */
 	cp_page = grab_meta_page(sbi, start_blk);
 	kaddr = page_address(cp_page);
-	memcpy(kaddr, ckpt, (1 << sbi->log_blocksize));
+	memcpy(kaddr, ckpt, F2FS_BLKSIZE);
 	set_page_dirty(cp_page);
 	f2fs_put_page(cp_page, 1);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7dc0ed8..790edb9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -491,8 +491,7 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 
 	trace_f2fs_truncate_blocks_enter(inode, from);
 
-	free_from = (pgoff_t)
-		((from + blocksize - 1) >> (sbi->log_blocksize));
+	free_from = (pgoff_t)F2FS_BYTES_TO_BLK(from + blocksize - 1);
 
 	if (lock)
 		f2fs_lock_op(sbi);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9f278d1..877a272 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1048,8 +1048,8 @@ static const struct segment_allocation default_salloc_ops = {
 
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 {
-	__u64 start = range->start >> sbi->log_blocksize;
-	__u64 end = start + (range->len >> sbi->log_blocksize) - 1;
+	__u64 start = F2FS_BYTES_TO_BLK(range->start);
+	__u64 end = start + F2FS_BYTES_TO_BLK(range->len) - 1;
 	unsigned int start_segno, end_segno;
 	struct cp_control cpc;
 
@@ -1066,7 +1066,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	end_segno = (end >= MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
 						GET_SEGNO(sbi, end);
 	cpc.reason = CP_DISCARD;
-	cpc.trim_minlen = range->minlen >> sbi->log_blocksize;
+	cpc.trim_minlen = F2FS_BYTES_TO_BLK(range->minlen);
 
 	/* do checkpoint to issue discard commands safely */
 	for (; start_segno <= end_segno; start_segno = cpc.trim_end + 1) {
@@ -1080,7 +1080,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 		mutex_unlock(&sbi->gc_mutex);
 	}
 out:
-	range->len = cpc.trimmed << sbi->log_blocksize;
+	range->len = F2FS_BLK_TO_BYTES(cpc.trimmed);
 	return 0;
 }
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 0980572..a23556c 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -19,12 +19,16 @@
 #define F2FS_MAX_LOG_SECTOR_SIZE	12	/* 12 bits for 4096 bytes */
 #define F2FS_LOG_SECTORS_PER_BLOCK	3	/* log number for sector/blk */
 #define F2FS_BLKSIZE			4096	/* support only 4KB block */
+#define F2FS_BLKSIZE_BITS		12	/* bits for F2FS_BLKSIZE */
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
 #define F2FS_BLK_ALIGN(x)	(((x) + F2FS_BLKSIZE - 1) / F2FS_BLKSIZE)
 
 #define NULL_ADDR		((block_t)0)	/* used as block_t addresses */
 #define NEW_ADDR		((block_t)-1)	/* used as block_t addresses */
 
+#define F2FS_BYTES_TO_BLK(bytes)	((bytes) >> F2FS_BLKSIZE_BITS)
+#define F2FS_BLK_TO_BYTES(blk)		((blk) << F2FS_BLKSIZE_BITS)
+
 /* 0, 1(node nid), 2(meta nid) are reserved node id */
 #define F2FS_RESERVED_NODE_NUM		3
 
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
