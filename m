From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v3] f2fs: add cur_reserved_blocks to support soft block reservation
Date: Fri, 18 Aug 2017 23:09:03 +0800
Message-ID: <1503068943-162538-1-git-send-email-yunlong.song@huawei.com>
References: <1502199825-15218-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502199825-15218-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds cur_reserved_blocks to extend reserved_blocks sysfs
interface to be soft threshold, which allows user configure it exceeding
current available user space. To ensure there is enough space for
supporting system's activation, this patch does not set the reserved space
to the configured reserved_blocks value at once, instead, it safely
increase cur_reserved_blocks in dev_valid_block(,node)_count to only take
up the blocks which are just obsoleted.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  3 ++-
 fs/f2fs/f2fs.h                          | 13 +++++++++++--
 fs/f2fs/super.c                         |  3 ++-
 fs/f2fs/sysfs.c                         | 15 +++++++++++++--
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 11b7f4e..ba282ca 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -138,7 +138,8 @@ What:		/sys/fs/f2fs/<disk>/reserved_blocks
 Date:		June 2017
 Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:
-		 Controls current reserved blocks in system.
+		 Controls current reserved blocks in system, the threshold
+		 is soft, it could exceed current available user space.
 
 What:		/sys/fs/f2fs/<disk>/gc_urgent
 Date:		August 2017
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2f20b6b..84ccbdc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1041,6 +1041,7 @@ struct f2fs_sb_info {
 	block_t discard_blks;			/* discard command candidats */
 	block_t last_valid_block_count;		/* for recovery */
 	block_t reserved_blocks;		/* configurable reserved blocks */
+	block_t cur_reserved_blocks;		/* current reserved blocks */
 
 	u32 s_next_generation;			/* for NFS support */
 
@@ -1515,7 +1516,8 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 
 	spin_lock(&sbi->stat_lock);
 	sbi->total_valid_block_count += (block_t)(*count);
-	avail_user_block_count = sbi->user_block_count - sbi->reserved_blocks;
+	avail_user_block_count = sbi->user_block_count -
+						sbi->cur_reserved_blocks;
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
 		diff = sbi->total_valid_block_count - avail_user_block_count;
 		*count -= diff;
@@ -1549,6 +1551,10 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 	f2fs_bug_on(sbi, sbi->total_valid_block_count < (block_t) count);
 	f2fs_bug_on(sbi, inode->i_blocks < sectors);
 	sbi->total_valid_block_count -= (block_t)count;
+	if (sbi->reserved_blocks &&
+		sbi->reserved_blocks != sbi->cur_reserved_blocks)
+		sbi->cur_reserved_blocks = min(sbi->reserved_blocks,
+					sbi->cur_reserved_blocks + count);
 	spin_unlock(&sbi->stat_lock);
 	f2fs_i_blocks_write(inode, count, false, true);
 }
@@ -1695,7 +1701,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 	spin_lock(&sbi->stat_lock);
 
 	valid_block_count = sbi->total_valid_block_count + 1;
-	if (unlikely(valid_block_count + sbi->reserved_blocks >
+	if (unlikely(valid_block_count + sbi->cur_reserved_blocks >
 						sbi->user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
 		goto enospc;
@@ -1738,6 +1744,9 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
 
 	sbi->total_valid_node_count--;
 	sbi->total_valid_block_count--;
+	if (sbi->reserved_blocks &&
+		sbi->reserved_blocks != sbi->cur_reserved_blocks)
+		sbi->cur_reserved_blocks++;
 
 	spin_unlock(&sbi->stat_lock);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4c1bdcb..16a805f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -957,7 +957,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks = total_count - start_count;
 	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
 	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
-						sbi->reserved_blocks;
+						sbi->cur_reserved_blocks;
 
 	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
 
@@ -2411,6 +2411,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 				le64_to_cpu(sbi->ckpt->valid_block_count);
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	sbi->reserved_blocks = 0;
+	sbi->cur_reserved_blocks = 0;
 
 	for (i = 0; i < NR_INODE_TYPE; i++) {
 		INIT_LIST_HEAD(&sbi->inode_list[i]);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index a1be5ac..75c37bb 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -104,12 +104,22 @@ static ssize_t features_show(struct f2fs_attr *a,
 	return len;
 }
 
+static ssize_t f2fs_reserved_blocks_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "expected: %u\ncurrent: %u\n",
+			sbi->reserved_blocks, sbi->cur_reserved_blocks);
+}
+
 static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 			struct f2fs_sb_info *sbi, char *buf)
 {
 	unsigned char *ptr = NULL;
 	unsigned int *ui;
 
+	if (a->struct_type == RESERVED_BLOCKS)
+		return f2fs_reserved_blocks_show(a, sbi, buf);
+
 	ptr = __struct_ptr(sbi, a->struct_type);
 	if (!ptr)
 		return -EINVAL;
@@ -143,12 +153,13 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 #endif
 	if (a->struct_type == RESERVED_BLOCKS) {
 		spin_lock(&sbi->stat_lock);
-		if ((unsigned long)sbi->total_valid_block_count + t >
-				(unsigned long)sbi->user_block_count) {
+		if (t > (unsigned long)sbi->user_block_count) {
 			spin_unlock(&sbi->stat_lock);
 			return -EINVAL;
 		}
 		*ui = t;
+		if (t < (unsigned long)sbi->cur_reserved_blocks)
+			sbi->cur_reserved_blocks = t;
 		spin_unlock(&sbi->stat_lock);
 		return count;
 	}
-- 
1.8.5.2
