From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs: use percpu_counter for
	total_valid_inode_count
Date: Mon, 16 May 2016 15:30:47 -0700
Message-ID: <1463437847-40412-5-git-send-email-jaegeuk@kernel.org>
References: <1463437847-40412-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b2R2V-0002C6-8R
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 22:31:03 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b2R2U-00060t-Bi
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 22:31:03 +0000
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

This patch uses percpu_counter to avoid stat_lock.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 18 +++++++-----------
 fs/f2fs/super.c | 11 ++++++++---
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 43aa692..c965897 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -822,7 +822,6 @@ struct f2fs_sb_info {
 	unsigned int total_sections;		/* total section count */
 	unsigned int total_node_count;		/* total node block count */
 	unsigned int total_valid_node_count;	/* valid node block count */
-	unsigned int total_valid_inode_count;	/* valid inode count */
 	loff_t max_file_blocks;			/* max block index of file */
 	int active_logs;			/* # of active logs */
 	int dir_level;				/* directory level */
@@ -838,6 +837,9 @@ struct f2fs_sb_info {
 	/* # of allocated blocks */
 	struct percpu_counter alloc_valid_block_count;
 
+	/* valid inode count */
+	struct percpu_counter total_valid_inode_count;
+
 	struct f2fs_mount_info mount_opt;	/* mount options */
 
 	/* for cleaning operations */
@@ -1343,23 +1345,17 @@ static inline unsigned int valid_node_count(struct f2fs_sb_info *sbi)
 
 static inline void inc_valid_inode_count(struct f2fs_sb_info *sbi)
 {
-	spin_lock(&sbi->stat_lock);
-	f2fs_bug_on(sbi, sbi->total_valid_inode_count == sbi->total_node_count);
-	sbi->total_valid_inode_count++;
-	spin_unlock(&sbi->stat_lock);
+	percpu_counter_inc(&sbi->total_valid_inode_count);
 }
 
 static inline void dec_valid_inode_count(struct f2fs_sb_info *sbi)
 {
-	spin_lock(&sbi->stat_lock);
-	f2fs_bug_on(sbi, !sbi->total_valid_inode_count);
-	sbi->total_valid_inode_count--;
-	spin_unlock(&sbi->stat_lock);
+	percpu_counter_dec(&sbi->total_valid_inode_count);
 }
 
-static inline unsigned int valid_inode_count(struct f2fs_sb_info *sbi)
+static inline s64 valid_inode_count(struct f2fs_sb_info *sbi)
 {
-	return sbi->total_valid_inode_count;
+	return percpu_counter_sum_positive(&sbi->total_valid_inode_count);
 }
 
 static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c0fd075..bbfeb6a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -619,6 +619,7 @@ static void destroy_percpu_info(struct f2fs_sb_info *sbi)
 	for (i = 0; i < NR_COUNT_TYPE; i++)
 		percpu_counter_destroy(&sbi->nr_pages[i]);
 	percpu_counter_destroy(&sbi->alloc_valid_block_count);
+	percpu_counter_destroy(&sbi->total_valid_inode_count);
 }
 
 static void f2fs_put_super(struct super_block *sb)
@@ -1386,7 +1387,11 @@ static int init_percpu_info(struct f2fs_sb_info *sbi)
 			return err;
 	}
 
-	return percpu_counter_init(&sbi->alloc_valid_block_count, 0,
+	err = percpu_counter_init(&sbi->alloc_valid_block_count, 0, GFP_KERNEL);
+	if (err)
+		return err;
+
+	return percpu_counter_init(&sbi->total_valid_inode_count, 0,
 								GFP_KERNEL);
 }
 
@@ -1600,8 +1605,8 @@ try_onemore:
 
 	sbi->total_valid_node_count =
 				le32_to_cpu(sbi->ckpt->valid_node_count);
-	sbi->total_valid_inode_count =
-				le32_to_cpu(sbi->ckpt->valid_inode_count);
+	percpu_counter_set(&sbi->total_valid_inode_count,
+				le32_to_cpu(sbi->ckpt->valid_inode_count));
 	sbi->user_block_count = le64_to_cpu(sbi->ckpt->user_block_count);
 	sbi->total_valid_block_count =
 				le64_to_cpu(sbi->ckpt->valid_block_count);
-- 
2.6.3


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
