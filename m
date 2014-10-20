From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 06/11] f2fs: fix counting inline_data inode
	numbers
Date: Sun, 19 Oct 2014 22:19:34 -0700
Message-ID: <1413782379-11758-6-git-send-email-jaegeuk@kernel.org>
References: <1413782379-11758-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xg5Nv-0007pu-26
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:19:59 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xg5Nu-0006iD-7y for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:19:59 +0000
In-Reply-To: <1413782379-11758-1-git-send-email-jaegeuk@kernel.org>
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

This patch fixes wrongly counting inline_data inode numbers.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 4 ++--
 fs/f2fs/namei.c | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index b9b1d6b..4131e3c 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -169,6 +169,7 @@ make_now:
 		goto bad_inode;
 	}
 	unlock_new_inode(inode);
+	stat_inc_inline_inode(inode);
 	stat_inc_inline_dir(inode);
 	trace_f2fs_iget(inode);
 	return inode;
@@ -296,12 +297,12 @@ void f2fs_evict_inode(struct inode *inode)
 
 	f2fs_lock_op(sbi);
 	remove_inode_page(inode);
-	stat_dec_inline_inode(inode);
 	f2fs_unlock_op(sbi);
 
 	sb_end_intwrite(inode->i_sb);
 no_delete:
 	stat_dec_inline_dir(inode);
+	stat_dec_inline_inode(inode);
 	invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino, inode->i_ino);
 	if (xnid)
 		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
@@ -327,7 +328,6 @@ void handle_failed_inode(struct inode *inode)
 		f2fs_truncate(inode);
 
 	remove_inode_page(inode);
-	stat_dec_inline_inode(inode);
 
 	clear_inode_flag(F2FS_I(inode), FI_INLINE_DENTRY);
 	alloc_nid_failed(sbi, inode->i_ino);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 94ba291..a004a97 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -198,8 +198,6 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		inode = f2fs_iget(dir->i_sb, ino);
 		if (IS_ERR(inode))
 			return ERR_CAST(inode);
-
-		stat_inc_inline_inode(inode);
 	}
 
 	return d_splice_alias(inode, dentry);
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
