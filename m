From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v5 RESEND] f2fs: support soft block reservation
Date: Fri, 27 Oct 2017 20:45:05 +0800
Message-ID: <1509108305-125467-1-git-send-email-yunlong.song@huawei.com>
References: <1509104832-124189-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yunlong.song@huawei.com>)
 id 1e849q-0008Ce-9R
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Oct 2017 12:54:42 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1e849j-0002jS-M1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Oct 2017 12:54:42 +0000
In-Reply-To: <1509104832-124189-1-git-send-email-yunlong.song@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

It supports to extend reserved_blocks sysfs interface to be soft
threshold, which allows user configure it exceeding current available
user space. This patch also introduces a new sysfs interface called
current_reserved_blocks, which shows the current blocks that have
already been reserved.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 13 ++++++++++++-
 fs/f2fs/f2fs.h                          | 13 +++++++++++--
 fs/f2fs/super.c                         |  3 ++-
 fs/f2fs/sysfs.c                         | 15 ++++++++++++---
 4 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 11b7f4e..7562b0d 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -138,7 +138,18 @@ What:		/sys/fs/f2fs/<disk>/reserved_blocks
 Date:		June 2017
 Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:
-		 Controls current reserved blocks in system.
+		 Controls target reserved blocks in system, the threshold
+		 is soft, it could exceed current available user space.
+
+What:		/sys/fs/f2fs/<disk>/current_reserved_blocks
+Date:		October 2017
+Contact:	"Yunlong Song" <yunlong.song@huawei.com>
+Contact:	"Chao Yu" <yuchao0@huawei.com>
+Description:
+		 Shows current reserved blocks in system, it may be temporarily
+		 smaller than target_reserved_blocks, but will gradually
+		 increase to target_reserved_blocks when more free blocks are
+		 freed by user later.
 
 What:		/sys/fs/f2fs/<disk>/gc_urgent
 Date:		August 2017
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 13a96b8..5ed40fb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1082,6 +1082,7 @@ struct f2fs_sb_info {
 	block_t discard_blks;			/* discard command candidats */
 	block_t last_valid_block_count;		/* for recovery */
 	block_t reserved_blocks;		/* configurable reserved blocks */
+	block_t current_reserved_blocks;	/* current reserved blocks */
 
 	u32 s_next_generation;			/* for NFS support */
 
@@ -1557,7 +1558,8 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 
 	spin_lock(&sbi->stat_lock);
 	sbi->total_valid_block_count += (block_t)(*count);
-	avail_user_block_count = sbi->user_block_count - sbi->reserved_blocks;
+	avail_user_block_count = sbi->user_block_count -
+					sbi->current_reserved_blocks;
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
 		diff = sbi->total_valid_block_count - avail_user_block_count;
 		*count -= diff;
@@ -1591,6 +1593,10 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 	f2fs_bug_on(sbi, sbi->total_valid_block_count < (block_t) count);
 	f2fs_bug_on(sbi, inode->i_blocks < sectors);
 	sbi->total_valid_block_count -= (block_t)count;
+	if (sbi->reserved_blocks &&
+		sbi->current_reserved_blocks < sbi->reserved_blocks)
+		sbi->current_reserved_blocks = min(sbi->reserved_blocks,
+					sbi->current_reserved_blocks + count);
 	spin_unlock(&sbi->stat_lock);
 	f2fs_i_blocks_write(inode, count, false, true);
 }
@@ -1737,7 +1743,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 	spin_lock(&sbi->stat_lock);
 
 	valid_block_count = sbi->total_valid_block_count + 1;
-	if (unlikely(valid_block_count + sbi->reserved_blocks >
+	if (unlikely(valid_block_count + sbi->current_reserved_blocks >
 						sbi->user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
 		goto enospc;
@@ -1780,6 +1786,9 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
 
 	sbi->total_valid_node_count--;
 	sbi->total_valid_block_count--;
+	if (sbi->reserved_blocks &&
+		sbi->current_reserved_blocks < sbi->reserved_blocks)
+		sbi->current_reserved_blocks++;
 
 	spin_unlock(&sbi->stat_lock);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 213d2c1..dab1fed 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -987,7 +987,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks = total_count - start_count;
 	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
 	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
-						sbi->reserved_blocks;
+						sbi->current_reserved_blocks;
 
 	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
 
@@ -2458,6 +2458,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 				le64_to_cpu(sbi->ckpt->valid_block_count);
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	sbi->reserved_blocks = 0;
+	sbi->current_reserved_blocks = 0;
 
 	for (i = 0; i < NR_INODE_TYPE; i++) {
 		INIT_LIST_HEAD(&sbi->inode_list[i]);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index e09e59c..4166ac7 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -30,7 +30,7 @@ enum {
 	FAULT_INFO_RATE,	/* struct f2fs_fault_info */
 	FAULT_INFO_TYPE,	/* struct f2fs_fault_info */
 #endif
-	RESERVED_BLOCKS,
+	RESERVED_BLOCKS,	/* struct f2fs_sb_info */
 };
 
 struct f2fs_attr {
@@ -114,6 +114,12 @@ static ssize_t features_show(struct f2fs_attr *a,
 	return len;
 }
 
+static ssize_t current_reserved_blocks_show(struct f2fs_attr *a,
+					struct f2fs_sb_info *sbi, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%u\n", sbi->current_reserved_blocks);
+}
+
 static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 			struct f2fs_sb_info *sbi, char *buf)
 {
@@ -153,12 +159,13 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
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
+		sbi->current_reserved_blocks = min(sbi->reserved_blocks,
+				sbi->user_block_count - valid_user_blocks(sbi));
 		spin_unlock(&sbi->stat_lock);
 		return count;
 	}
@@ -293,6 +300,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 F2FS_GENERAL_RO_ATTR(dirty_segments);
 F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
 F2FS_GENERAL_RO_ATTR(features);
+F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
 
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
@@ -338,6 +346,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 	ATTR_LIST(lifetime_write_kbytes),
 	ATTR_LIST(features),
 	ATTR_LIST(reserved_blocks),
+	ATTR_LIST(current_reserved_blocks),
 	NULL,
 };
 
-- 
1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
