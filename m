From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/5] f2fs: use percpu_counter for
	alloc_valid_block_count
Date: Mon, 16 May 2016 15:30:46 -0700
Message-ID: <1463437847-40412-4-git-send-email-jaegeuk@kernel.org>
References: <1463437847-40412-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b2R2T-0002Ba-L1
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 22:31:01 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b2R2S-00060r-LW
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 22:31:01 +0000
In-Reply-To: <1463437847-40412-1-git-send-email-jaegeuk@kernel.org>
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

This patch uses percpu_count for sbi->alloc_valid_block_count.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 2 +-
 fs/f2fs/f2fs.h       | 8 +++++---
 fs/f2fs/recovery.c   | 5 +++--
 fs/f2fs/super.c      | 7 +++++--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d04113b..140643d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1079,7 +1079,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* update user_block_counts */
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
-	sbi->alloc_valid_block_count = 0;
+	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
 
 	/* Here, we only have one bio having CP pack */
 	sync_meta_pages(sbi, META_FLUSH, LONG_MAX);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ae978a1..43aa692 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -829,13 +829,14 @@ struct f2fs_sb_info {
 
 	block_t user_block_count;		/* # of user blocks */
 	block_t total_valid_block_count;	/* # of valid blocks */
-	block_t alloc_valid_block_count;	/* # of allocated blocks */
 	block_t discard_blks;			/* discard command candidats */
 	block_t last_valid_block_count;		/* for recovery */
 	u32 s_next_generation;			/* for NFS support */
 
 	/* # of pages, see count_type */
 	struct percpu_counter nr_pages[NR_COUNT_TYPE];
+	/* # of allocated blocks */
+	struct percpu_counter alloc_valid_block_count;
 
 	struct f2fs_mount_info mount_opt;	/* mount options */
 
@@ -1161,8 +1162,9 @@ static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
 	inode->i_blocks += *count;
 	sbi->total_valid_block_count =
 		sbi->total_valid_block_count + (block_t)(*count);
-	sbi->alloc_valid_block_count += (block_t)(*count);
 	spin_unlock(&sbi->stat_lock);
+
+	percpu_counter_add(&sbi->alloc_valid_block_count, (*count));
 	return true;
 }
 
@@ -1310,11 +1312,11 @@ static inline bool inc_valid_node_count(struct f2fs_sb_info *sbi,
 	if (inode)
 		inode->i_blocks++;
 
-	sbi->alloc_valid_block_count++;
 	sbi->total_valid_node_count++;
 	sbi->total_valid_block_count++;
 	spin_unlock(&sbi->stat_lock);
 
+	percpu_counter_inc(&sbi->alloc_valid_block_count);
 	return true;
 }
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 6303b2a..f89b70e 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -49,8 +49,9 @@ static struct kmem_cache *fsync_entry_slab;
 
 bool space_for_roll_forward(struct f2fs_sb_info *sbi)
 {
-	if (sbi->last_valid_block_count + sbi->alloc_valid_block_count
-			> sbi->user_block_count)
+	s64 nalloc = percpu_counter_sum_positive(&sbi->alloc_valid_block_count);
+
+	if (sbi->last_valid_block_count + nalloc > sbi->user_block_count)
 		return false;
 	return true;
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 56f177b..c0fd075 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -618,6 +618,7 @@ static void destroy_percpu_info(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < NR_COUNT_TYPE; i++)
 		percpu_counter_destroy(&sbi->nr_pages[i]);
+	percpu_counter_destroy(&sbi->alloc_valid_block_count);
 }
 
 static void f2fs_put_super(struct super_block *sb)
@@ -1384,7 +1385,9 @@ static int init_percpu_info(struct f2fs_sb_info *sbi)
 		if (err)
 			return err;
 	}
-	return 0;
+
+	return percpu_counter_init(&sbi->alloc_valid_block_count, 0,
+								GFP_KERNEL);
 }
 
 /*
@@ -1603,7 +1606,7 @@ try_onemore:
 	sbi->total_valid_block_count =
 				le64_to_cpu(sbi->ckpt->valid_block_count);
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
-	sbi->alloc_valid_block_count = 0;
+
 	for (i = 0; i < NR_INODE_TYPE; i++) {
 		INIT_LIST_HEAD(&sbi->inode_list[i]);
 		spin_lock_init(&sbi->inode_lock[i]);
-- 
2.6.3


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
