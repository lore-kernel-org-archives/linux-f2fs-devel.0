From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 08/13 v2] f2fs: do checkpoint at
	f2fs_put_super
Date: Fri, 15 Aug 2014 14:58:18 -0700
Message-ID: <20140815215818.GB53769@jaegeuk-mac02.mot.com>
References: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
	<1407872967-26423-8-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XIPV3-0003S7-2a
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Aug 2014 21:57:29 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XIPV2-0000a3-2h for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Aug 2014 21:57:29 +0000
Content-Disposition: inline
In-Reply-To: <1407872967-26423-8-git-send-email-jaegeuk@kernel.org>
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

Change log from v1:
 o relocate F2FS_SET_SB_DIRT to avoid unnecessary checkpoints

The generic_shutdown_super calls sync_filesystem, evict_inode, and then
f2fs_put_super. In f2fs_evict_inode, we remain some dirty inode information
so we should release them at f2fs_put_super.

But normally, it's more reasonable to set its superblock as dirty when
evict_inode is called.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 1 +
 fs/f2fs/super.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7e1c13b..01e1796 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -330,6 +330,7 @@ void add_dirty_inode(struct f2fs_sb_info *sbi, nid_t ino, int type)
 {
 	/* add new dirty ino entry into list */
 	__add_ino_entry(sbi, ino, type);
+	F2FS_SET_SB_DIRT(sbi);
 }
 
 void remove_dirty_inode(struct f2fs_sb_info *sbi, nid_t ino, int type)
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
