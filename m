From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: call update_inode_page for orphan
	inodes
Date: Tue, 14 Jun 2016 11:43:22 -0700
Message-ID: <20160614184322.88117-2-jaegeuk@kernel.org>
References: <20160614184322.88117-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bCtJQ-0002Ka-Va
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Jun 2016 18:43:44 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bCtJQ-00006z-3g
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Jun 2016 18:43:44 +0000
In-Reply-To: <20160614184322.88117-1-jaegeuk@kernel.org>
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

Let's store orphan inode pages right away.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  6 +++---
 fs/f2fs/dir.c        |  2 +-
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/inode.c      |  5 +++--
 fs/f2fs/namei.c      |  4 ++--
 fs/f2fs/super.c      | 16 +---------------
 6 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f671683..afc03cb 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -508,10 +508,11 @@ void release_orphan_inode(struct f2fs_sb_info *sbi)
 	spin_unlock(&im->ino_lock);
 }
 
-void add_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
+void add_orphan_inode(struct inode *inode)
 {
 	/* add new orphan ino entry into list */
-	__add_ino_entry(sbi, ino, ORPHAN_INO);
+	__add_ino_entry(F2FS_I_SB(inode), inode->i_ino, ORPHAN_INO);
+	update_inode_page(inode);
 }
 
 void remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
@@ -535,7 +536,6 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 	}
 
 	clear_nlink(inode);
-	mark_inode_dirty_sync(inode);
 
 	/* truncate all the data during iput */
 	iput(inode);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 72a0207..7ba52a0 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -666,7 +666,7 @@ void f2fs_drop_nlink(struct inode *dir, struct inode *inode)
 	up_write(&F2FS_I(inode)->i_sem);
 
 	if (inode->i_nlink == 0)
-		add_orphan_inode(sbi, inode->i_ino);
+		add_orphan_inode(inode);
 	else
 		release_orphan_inode(sbi);
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1a19c02..3019286 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2061,7 +2061,7 @@ bool exist_written_data(struct f2fs_sb_info *, nid_t, int);
 int f2fs_sync_inode_meta(struct f2fs_sb_info *);
 int acquire_orphan_inode(struct f2fs_sb_info *);
 void release_orphan_inode(struct f2fs_sb_info *);
-void add_orphan_inode(struct f2fs_sb_info *, nid_t);
+void add_orphan_inode(struct inode *);
 void remove_orphan_inode(struct f2fs_sb_info *, nid_t);
 int recover_orphan_inodes(struct f2fs_sb_info *);
 int get_valid_checkpoint(struct f2fs_sb_info *);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 63c4326..9dd6642 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -394,7 +394,8 @@ no_delete:
 out_clear:
 	fscrypt_put_encryption_info(inode, NULL);
 
-	f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
+	f2fs_bug_on(sbi, !f2fs_cp_error(sbi) &&
+			is_inode_flag_set(inode, FI_DIRTY_INODE));
 	clear_inode(inode);
 }
 
@@ -421,7 +422,7 @@ void handle_failed_inode(struct inode *inode)
 			f2fs_msg(sbi->sb, KERN_WARNING,
 				"Too many orphan inodes, run fsck to fix.");
 		} else {
-			add_orphan_inode(sbi, inode->i_ino);
+			add_orphan_inode(inode);
 		}
 		alloc_nid_done(sbi, inode->i_ino);
 	} else {
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 618829e..4460400 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -598,7 +598,7 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 	 * add this non-linked tmpfile to orphan list, in this way we could
 	 * remove all unused data of tmpfile after abnormal power-off.
 	 */
-	add_orphan_inode(sbi, inode->i_ino);
+	add_orphan_inode(inode);
 	alloc_nid_done(sbi, inode->i_ino);
 
 	if (whiteout) {
@@ -712,7 +712,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		up_write(&F2FS_I(new_inode)->i_sem);
 
 		if (!new_inode->i_nlink)
-			add_orphan_inode(sbi, new_inode->i_ino);
+			add_orphan_inode(new_inode);
 		else
 			release_orphan_inode(sbi);
 	} else {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 71b6066..d78e46b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -583,8 +583,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 
 static int f2fs_drop_inode(struct inode *inode)
 {
-	int ret;
-
 	/*
 	 * This is to avoid a deadlock condition like below.
 	 * writeback_single_inode(inode)
@@ -620,19 +618,7 @@ static int f2fs_drop_inode(struct inode *inode)
 		return 0;
 	}
 
-	ret = generic_drop_inode(inode);
-	if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
-		if (ret)
-			inode->i_state |= I_WILL_FREE;
-		spin_unlock(&inode->i_lock);
-
-		update_inode_page(inode);
-
-		spin_lock(&inode->i_lock);
-		if (ret)
-			inode->i_state &= ~I_WILL_FREE;
-	}
-	return ret;
+	return generic_drop_inode(inode);
 }
 
 /*
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports. http://pubads.g.doubleclick.net/gampad/clk?id=1444514421&iu=/41014381
