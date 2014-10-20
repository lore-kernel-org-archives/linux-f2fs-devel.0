From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 05/09] f2fs: use highmem for directory pages
Date: Sun, 19 Oct 2014 22:18:28 -0700
Message-ID: <1413782312-11631-5-git-send-email-jaegeuk@kernel.org>
References: <1413782312-11631-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xg5Mk-0008Ot-A5
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:18:46 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xg5Mj-0000qs-EK for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:18:46 +0000
In-Reply-To: <1413782312-11631-1-git-send-email-jaegeuk@kernel.org>
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

This patch fixes to use highmem for directory pages.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c         | 2 +-
 include/linux/f2fs_fs.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 0deead4..52d6f54 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -156,7 +156,7 @@ make_now:
 		inode->i_op = &f2fs_dir_inode_operations;
 		inode->i_fop = &f2fs_dir_operations;
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
-		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
+		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_HIGH_ZERO);
 	} else if (S_ISLNK(inode->i_mode)) {
 		inode->i_op = &f2fs_symlink_inode_operations;
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 860313a..6d7381b 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -33,7 +33,8 @@
 #define F2FS_META_INO(sbi)	(sbi->meta_ino_num)
 
 /* This flag is used by node and meta inodes, and by recovery */
-#define GFP_F2FS_ZERO	(GFP_NOFS | __GFP_ZERO)
+#define GFP_F2FS_ZERO		(GFP_NOFS | __GFP_ZERO)
+#define GFP_F2FS_HIGH_ZERO	(GFP_NOFS | __GFP_ZERO | __GFP_HIGHMEM)
 
 /*
  * For further optimization on multi-head logs, on-disk layout supports maximum
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
