From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: introduce reserved_blocks in sysfs
Date: Thu, 15 Jun 2017 19:42:56 +0800
Message-ID: <20170615114256.5154-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dLTBV-00026B-Cw
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 15 Jun 2017 11:43:33 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dLTBT-00034n-OT
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 15 Jun 2017 11:43:33 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In this patch, we add a new sysfs interface, with it, we can control
number of reserved blocks in system which could not be used by user,
it enable f2fs to let user to configure for adjusting over-provision
ratio dynamically instead of changing it by mkfs.

So we can expect it will help to reserve more free space for relieving
GC in both filesystem and flash device.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
 fs/f2fs/f2fs.h                          |  8 ++++++--
 fs/f2fs/sysfs.c                         | 15 ++++++++++++++-
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index b09108811ff1..84c606fb3ca4 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -124,3 +124,9 @@ Date:		May 2016
 Contact:	"Sheng Yong" <shengyong1@huawei.com>
 Description:
 		 Controls the injection type.
+
+What:		/sys/fs/f2fs/<disk>/reserved_blocks
+Date:		June 2017
+Contact:	"Chao Yu" <yuchao0@huawei.com>
+Description:
+		 Controls current reserved blocks in system.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 91db1d07f9f8..cef4c5336c70 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -958,6 +958,8 @@ struct f2fs_sb_info {
 	block_t total_valid_block_count;	/* # of valid blocks */
 	block_t discard_blks;			/* discard command candidats */
 	block_t last_valid_block_count;		/* for recovery */
+	block_t reserved_blocks;		/* configurable reserved blocks */
+
 	u32 s_next_generation;			/* for NFS support */
 
 	/* # of pages, see count_type */
@@ -1383,7 +1385,8 @@ static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
 
 	spin_lock(&sbi->stat_lock);
 	sbi->total_valid_block_count += (block_t)(*count);
-	if (unlikely(sbi->total_valid_block_count > sbi->user_block_count)) {
+	if (unlikely(sbi->total_valid_block_count + sbi->reserved_blocks >
+						sbi->user_block_count)) {
 		diff = sbi->total_valid_block_count - sbi->user_block_count;
 		*count -= diff;
 		sbi->total_valid_block_count = sbi->user_block_count;
@@ -1548,7 +1551,8 @@ static inline bool inc_valid_node_count(struct f2fs_sb_info *sbi,
 	spin_lock(&sbi->stat_lock);
 
 	valid_block_count = sbi->total_valid_block_count + 1;
-	if (unlikely(valid_block_count > sbi->user_block_count)) {
+	if (unlikely(valid_block_count + sbi->reserved_blocks >
+						sbi->user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
 		return false;
 	}
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 714a3e47bbe8..a8ceb5f93eae 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -30,6 +30,7 @@ enum {
 	FAULT_INFO_RATE,	/* struct f2fs_fault_info */
 	FAULT_INFO_TYPE,	/* struct f2fs_fault_info */
 #endif
+	RESERVED_BLOCKS,
 };
 
 struct f2fs_attr {
@@ -51,7 +52,7 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 		return (unsigned char *)SM_I(sbi)->dcc_info;
 	else if (struct_type == NM_INFO)
 		return (unsigned char *)NM_I(sbi);
-	else if (struct_type == F2FS_SBI)
+	else if (struct_type == F2FS_SBI || struct_type == RESERVED_BLOCKS)
 		return (unsigned char *)sbi;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	else if (struct_type == FAULT_INFO_RATE ||
@@ -111,6 +112,16 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	if (a->struct_type == FAULT_INFO_TYPE && t >= (1 << FAULT_MAX))
 		return -EINVAL;
 #endif
+	if (a->struct_type == RESERVED_BLOCKS) {
+		spin_lock(&sbi->stat_lock);
+		if (sbi->total_valid_block_count + t > sbi->user_block_count) {
+			spin_unlock(&sbi->stat_lock);
+			return -EINVAL;
+		}
+		*ui = t;
+		spin_unlock(&sbi->stat_lock);
+		return count;
+	}
 	*ui = t;
 	return count;
 }
@@ -165,6 +176,7 @@ F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_idle, gc_idle);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_small_discards, max_discards);
+F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
@@ -208,6 +220,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(inject_type),
 #endif
 	ATTR_LIST(lifetime_write_kbytes),
+	ATTR_LIST(reserved_blocks),
 	NULL,
 };
 
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
