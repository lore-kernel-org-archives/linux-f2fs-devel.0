From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 15/19] f2fs: fix counting the number of
	inline_data inodes
Date: Fri,  1 May 2015 17:48:42 -0700
Message-ID: <1430527726-68547-15-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YoLcn-0003sl-Og
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:45 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YoLcm-0004Ti-T4 for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:45 +0000
In-Reply-To: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
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

This patch fixes to count the missing symlink case.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index c0ba8e3..90a9640 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -61,6 +61,9 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (f2fs_may_inline_dentry(inode))
 		set_inode_flag(F2FS_I(inode), FI_INLINE_DENTRY);
 
+	stat_inc_inline_inode(inode);
+	stat_inc_inline_dir(inode);
+
 	trace_f2fs_new_inode(inode, 0);
 	mark_inode_dirty(inode);
 	return inode;
@@ -136,7 +139,6 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	alloc_nid_done(sbi, ino);
 
-	stat_inc_inline_inode(inode);
 	d_instantiate(dentry, inode);
 	unlock_new_inode(inode);
 
@@ -384,7 +386,6 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		goto out_fail;
 	f2fs_unlock_op(sbi);
 
-	stat_inc_inline_dir(inode);
 	alloc_nid_done(sbi, inode->i_ino);
 
 	d_instantiate(dentry, inode);
@@ -770,7 +771,6 @@ static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 	alloc_nid_done(sbi, inode->i_ino);
 
-	stat_inc_inline_inode(inode);
 	d_tmpfile(dentry, inode);
 	unlock_new_inode(inode);
 	return 0;
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
