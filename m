From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 08/13] f2fs: do checkpoint at f2fs_put_super
Date: Tue, 12 Aug 2014 12:49:22 -0700
Message-ID: <1407872967-26423-8-git-send-email-jaegeuk@kernel.org>
References: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XHI4i-0007Q0-Nd
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:40 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XHI4g-0001by-GC for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:40 +0000
In-Reply-To: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
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

The generic_shutdown_super calls sync_filesystem, evict_inode, and then
f2fs_put_super. In f2fs_evict_inode, we remain some dirty inode information
so we should release them at f2fs_put_super.

But normally, it's more reasonable to set its superblock as dirty when
evict_inode is called.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 1 +
 fs/f2fs/super.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 2c39999..eeaf5aa 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -303,6 +303,7 @@ no_delete:
 		add_dirty_inode(sbi, inode->i_ino, APPEND_INO);
 	if (is_inode_flag_set(F2FS_I(inode), FI_UPDATE_WRITE))
 		add_dirty_inode(sbi, inode->i_ino, UPDATE_INO);
+	F2FS_SET_SB_DIRT(sbi);
 out_clear:
 	clear_inode(inode);
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 633315a..60e3554 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -432,7 +432,7 @@ static void f2fs_put_super(struct super_block *sb)
 	stop_gc_thread(sbi);
 
 	/* We don't need to do checkpoint when it's clean */
-	if (sbi->s_dirty && get_pages(sbi, F2FS_DIRTY_NODES))
+	if (sbi->s_dirty)
 		write_checkpoint(sbi, true);
 
 	iput(sbi->node_inode);
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
