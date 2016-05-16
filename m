From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/5] f2fs: use percpu_counter for page counters
Date: Mon, 16 May 2016 15:30:44 -0700
Message-ID: <1463437847-40412-2-git-send-email-jaegeuk@kernel.org>
References: <1463437847-40412-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b2R2R-0002BH-UC
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 22:30:59 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b2R2P-0005Rj-N6
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 22:30:59 +0000
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

This patch substitutes percpu_counter for atomic_counter when counting
various types of pages.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c |  1 +
 fs/f2fs/f2fs.h  | 12 +++++++-----
 fs/f2fs/super.c | 31 +++++++++++++++++++++++++++----
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 37615b2..2210c7c 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -144,6 +144,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	si->base_mem = sizeof(struct f2fs_sb_info) + sbi->sb->s_blocksize;
 	si->base_mem += 2 * sizeof(struct f2fs_inode_info);
 	si->base_mem += sizeof(*sbi->ckpt);
+	si->base_mem += sizeof(struct percpu_counter) * NR_COUNT_TYPE;
 
 	/* build sm */
 	si->base_mem += sizeof(struct f2fs_sm_info);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 24f8170..2851078 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -833,7 +833,9 @@ struct f2fs_sb_info {
 	block_t discard_blks;			/* discard command candidats */
 	block_t last_valid_block_count;		/* for recovery */
 	u32 s_next_generation;			/* for NFS support */
-	atomic_t nr_pages[NR_COUNT_TYPE];	/* # of pages, see count_type */
+
+	/* # of pages, see count_type */
+	struct percpu_counter nr_pages[NR_COUNT_TYPE];
 
 	struct f2fs_mount_info mount_opt;	/* mount options */
 
@@ -1178,7 +1180,7 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 
 static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
 {
-	atomic_inc(&sbi->nr_pages[count_type]);
+	percpu_counter_inc(&sbi->nr_pages[count_type]);
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 }
 
@@ -1191,7 +1193,7 @@ static inline void inode_inc_dirty_pages(struct inode *inode)
 
 static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
 {
-	atomic_dec(&sbi->nr_pages[count_type]);
+	percpu_counter_dec(&sbi->nr_pages[count_type]);
 }
 
 static inline void inode_dec_dirty_pages(struct inode *inode)
@@ -1205,9 +1207,9 @@ static inline void inode_dec_dirty_pages(struct inode *inode)
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA);
 }
 
-static inline int get_pages(struct f2fs_sb_info *sbi, int count_type)
+static inline s64 get_pages(struct f2fs_sb_info *sbi, int count_type)
 {
-	return atomic_read(&sbi->nr_pages[count_type]);
+	return percpu_counter_sum_positive(&sbi->nr_pages[count_type]);
 }
 
 static inline int get_dirty_pages(struct inode *inode)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9df6d72..b3030ed 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -606,6 +606,14 @@ static void f2fs_destroy_inode(struct inode *inode)
 	call_rcu(&inode->i_rcu, f2fs_i_callback);
 }
 
+static void destroy_percpu_info(struct f2fs_sb_info *sbi)
+{
+	int i;
+
+	for (i = 0; i < NR_COUNT_TYPE; i++)
+		percpu_counter_destroy(&sbi->nr_pages[i]);
+}
+
 static void f2fs_put_super(struct super_block *sb)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -667,6 +675,8 @@ static void f2fs_put_super(struct super_block *sb)
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
 	kfree(sbi->raw_super);
+
+	destroy_percpu_info(sbi);
 	kfree(sbi);
 }
 
@@ -1325,7 +1335,6 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 static void init_sb_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = sbi->raw_super;
-	int i;
 
 	sbi->log_sectors_per_block =
 		le32_to_cpu(raw_super->log_sectors_per_block);
@@ -1345,9 +1354,6 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->cur_victim_sec = NULL_SECNO;
 	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
 
-	for (i = 0; i < NR_COUNT_TYPE; i++)
-		atomic_set(&sbi->nr_pages[i], 0);
-
 	sbi->dir_level = DEF_DIR_LEVEL;
 	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
 	sbi->interval_time[REQ_TIME] = DEF_IDLE_INTERVAL;
@@ -1363,6 +1369,18 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 #endif
 }
 
+static int init_percpu_info(struct f2fs_sb_info *sbi)
+{
+	int i, err;
+
+	for (i = 0; i < NR_COUNT_TYPE; i++) {
+		err = percpu_counter_init(&sbi->nr_pages[i], 0, GFP_KERNEL);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 /*
  * Read f2fs raw super block.
  * Because we have two copies of super block, so read both of them
@@ -1553,6 +1571,10 @@ try_onemore:
 	init_waitqueue_head(&sbi->cp_wait);
 	init_sb_info(sbi);
 
+	err = init_percpu_info(sbi);
+	if (err)
+		goto free_options;
+
 	/* get an inode for meta space */
 	sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
 	if (IS_ERR(sbi->meta_inode)) {
@@ -1755,6 +1777,7 @@ free_meta_inode:
 	make_bad_inode(sbi->meta_inode);
 	iput(sbi->meta_inode);
 free_options:
+	destroy_percpu_info(sbi);
 	kfree(options);
 free_sb_buf:
 	kfree(raw_super);
-- 
2.6.3


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
