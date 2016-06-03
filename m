From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/8] f2fs: remove obsolete parameter in
	f2fs_truncate
Date: Thu,  2 Jun 2016 20:55:36 -0700
Message-ID: <1464926139-58252-5-git-send-email-jaegeuk@kernel.org>
References: <1464926139-58252-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b8gDB-0008PO-Ll
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jun 2016 03:55:53 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b8gDA-00030d-Tm
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jun 2016 03:55:53 +0000
In-Reply-To: <1464926139-58252-1-git-send-email-jaegeuk@kernel.org>
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

We don't need lock parameter, which is always true.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 2 +-
 fs/f2fs/file.c  | 6 +++---
 fs/f2fs/inode.c | 2 +-
 fs/f2fs/super.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 498c736..d1702ee 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1874,7 +1874,7 @@ static inline void *f2fs_kvzalloc(size_t size, gfp_t flags)
 int f2fs_sync_file(struct file *, loff_t, loff_t, int);
 void truncate_data_blocks(struct dnode_of_data *);
 int truncate_blocks(struct inode *, u64, bool);
-int f2fs_truncate(struct inode *, bool);
+int f2fs_truncate(struct inode *);
 int f2fs_getattr(struct vfsmount *, struct dentry *, struct kstat *);
 int f2fs_setattr(struct dentry *, struct iattr *);
 int truncate_hole(struct inode *, pgoff_t, pgoff_t);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6f93e07..e66d223 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -647,7 +647,7 @@ free_partial:
 	return err;
 }
 
-int f2fs_truncate(struct inode *inode, bool lock)
+int f2fs_truncate(struct inode *inode)
 {
 	int err;
 
@@ -664,7 +664,7 @@ int f2fs_truncate(struct inode *inode, bool lock)
 			return err;
 	}
 
-	err = truncate_blocks(inode, i_size_read(inode), lock);
+	err = truncate_blocks(inode, i_size_read(inode), true);
 	if (err)
 		return err;
 
@@ -728,7 +728,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 
 		if (attr->ia_size <= i_size_read(inode)) {
 			truncate_setsize(inode, attr->ia_size);
-			err = f2fs_truncate(inode, true);
+			err = f2fs_truncate(inode);
 			if (err)
 				return err;
 			f2fs_balance_fs(F2FS_I_SB(inode), true);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 11cb60a..fb3d9bd 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -355,7 +355,7 @@ void f2fs_evict_inode(struct inode *inode)
 	i_size_write(inode, 0);
 retry:
 	if (F2FS_HAS_BLOCKS(inode))
-		err = f2fs_truncate(inode, true);
+		err = f2fs_truncate(inode);
 
 	if (!err) {
 		f2fs_lock_op(sbi);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9e75433..94bb87d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -590,7 +590,7 @@ static int f2fs_drop_inode(struct inode *inode)
 			f2fs_i_size_write(inode, 0);
 
 			if (F2FS_HAS_BLOCKS(inode))
-				f2fs_truncate(inode, true);
+				f2fs_truncate(inode);
 
 			sb_end_intwrite(inode->i_sb);
 
-- 
2.6.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
