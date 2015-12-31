From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: introduce max_file_blocks in sbi
Date: Thu, 31 Dec 2015 14:35:37 +0800
Message-ID: <011601d14395$95f64d70$c1e2e850$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aEWqm-0002pd-6U
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 06:36:40 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aEWqk-0004hl-LV
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 06:36:40 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O0700NUSMCVX030@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 15:36:31 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Introduce max_file_blocks in sbi to store max block index of file in f2fs,
it could be used to avoid unneeded calculation of max block index in
runtime.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c  | 2 +-
 fs/f2fs/f2fs.h  | 2 +-
 fs/f2fs/super.c | 7 ++++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5a71017..73b7a8f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -762,7 +762,7 @@ static int get_data_block_bmap(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
 	/* Block number less than F2FS MAX BLOCKS */
-	if (unlikely(iblock >= max_file_size(0)))
+	if (unlikely(iblock >= F2FS_I_SB(inode)->max_file_blocks))
 		return -EFBIG;
 
 	return __get_data_block(inode, iblock, bh_result, create,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9ba6a09..520d8f2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -786,6 +786,7 @@ struct f2fs_sb_info {
 	unsigned int total_node_count;		/* total node block count */
 	unsigned int total_valid_node_count;	/* valid node block count */
 	unsigned int total_valid_inode_count;	/* valid inode count */
+	unsigned int max_file_blocks;		/* max block index of file */
 	int active_logs;			/* # of active logs */
 	int dir_level;				/* directory level */
 	int serialized_dio_pages;		/* serialized direct IO pages */
@@ -1731,7 +1732,6 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
  * super.c
  */
 int f2fs_commit_super(struct f2fs_sb_info *, bool);
-loff_t max_file_size(unsigned bits);
 int f2fs_sync_fs(struct super_block *, int);
 extern __printf(3, 4)
 void f2fs_msg(struct super_block *, const char *, const char *, ...);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f474355..4e5bbd4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -909,7 +909,7 @@ static const struct export_operations f2fs_export_ops = {
 	.get_parent = f2fs_get_parent,
 };
 
-loff_t max_file_size(unsigned bits)
+static loff_t max_file_blocks(void)
 {
 	loff_t result = (DEF_ADDRS_PER_INODE - F2FS_INLINE_XATTR_ADDRS);
 	loff_t leaf_count = ADDRS_PER_BLOCK;
@@ -925,7 +925,6 @@ loff_t max_file_size(unsigned bits)
 	leaf_count *= NIDS_PER_BLOCK;
 	result += leaf_count;
 
-	result <<= bits;
 	return result;
 }
 
@@ -1281,7 +1280,9 @@ try_onemore:
 	if (err)
 		goto free_options;
 
-	sb->s_maxbytes = max_file_size(le32_to_cpu(raw_super->log_blocksize));
+	sbi->max_file_blocks = max_file_blocks();
+	sb->s_maxbytes = sbi->max_file_blocks <<
+				le32_to_cpu(raw_super->log_blocksize);
 	sb->s_max_links = F2FS_LINK_MAX;
 	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 
-- 
2.6.3



------------------------------------------------------------------------------
