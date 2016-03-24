From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: give -EINVAL for norecovery and rw
	mount
Date: Wed, 23 Mar 2016 18:31:27 -0700
Message-ID: <1458783087-32233-4-git-send-email-jaegeuk@kernel.org>
References: <1458783087-32233-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aiu7h-00076g-MS
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Mar 2016 01:31:41 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aiu7g-0007t4-TN
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Mar 2016 01:31:41 +0000
In-Reply-To: <1458783087-32233-1-git-send-email-jaegeuk@kernel.org>
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

Once detecting something to recover, f2fs should stop mounting, given norecovery
and rw mount options.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h     |  2 +-
 fs/f2fs/recovery.c | 11 +++++++----
 fs/f2fs/super.c    | 14 ++++++++++++--
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 286e917..5dcc04e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1907,7 +1907,7 @@ void build_gc_manager(struct f2fs_sb_info *);
 /*
  * recovery.c
  */
-int recover_fsync_data(struct f2fs_sb_info *);
+int recover_fsync_data(struct f2fs_sb_info *, bool);
 bool space_for_roll_forward(struct f2fs_sb_info *);
 
 /*
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 0b30cd2..e87f071 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -551,12 +551,13 @@ next:
 	return err;
 }
 
-int recover_fsync_data(struct f2fs_sb_info *sbi)
+int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
 	struct list_head inode_list;
 	block_t blkaddr;
 	int err;
+	int ret = 0;
 	bool need_writecp = false;
 
 	fsync_entry_slab = f2fs_kmem_cache_create("f2fs_fsync_inode_entry",
@@ -573,11 +574,13 @@ int recover_fsync_data(struct f2fs_sb_info *sbi)
 
 	/* step #1: find fsynced inode numbers */
 	err = find_fsync_dnodes(sbi, &inode_list);
-	if (err)
+	if (err || list_empty(&inode_list))
 		goto out;
 
-	if (list_empty(&inode_list))
+	if (check_only) {
+		ret = 1;
 		goto out;
+	}
 
 	need_writecp = true;
 
@@ -625,5 +628,5 @@ out:
 	} else {
 		mutex_unlock(&sbi->cp_mutex);
 	}
-	return err;
+	return ret ? ret: err;
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5718187..abc0d75 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1562,14 +1562,24 @@ try_onemore:
 		if (need_fsck)
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 
-		err = recover_fsync_data(sbi);
-		if (err) {
+		err = recover_fsync_data(sbi, false);
+		if (err < 0) {
 			need_fsck = true;
 			f2fs_msg(sb, KERN_ERR,
 				"Cannot recover all fsync data errno=%ld", err);
 			goto free_kobj;
 		}
+	} else {
+		err = recover_fsync_data(sbi, true);
+
+		if (!f2fs_readonly(sb) && err > 0) {
+			err = -EINVAL;
+			f2fs_msg(sb, KERN_ERR,
+				"Need to recover fsync data");
+			goto free_kobj;
+		}
 	}
+
 	/* recover_fsync_data() cleared this already */
 	clear_sbi_flag(sbi, SBI_POR_DOING);
 
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
