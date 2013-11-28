From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 5/5] f2fs: convert recover_orphan_inodes to void
Date: Thu, 28 Nov 2013 15:43:43 +0800
Message-ID: <003501ceec0d$a14d97f0$e3e8c7d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VlwGx-0002Q7-NC
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 07:44:27 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VlwGw-0004ur-P5
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 07:44:27 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MWY006E6QTV4OE0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 16:44:19 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c |    6 +++---
 fs/f2fs/f2fs.h       |    2 +-
 fs/f2fs/super.c      |    8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7fe69ff..b28e61b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -270,12 +270,12 @@ static void recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 	iput(inode);
 }
 
-int recover_orphan_inodes(struct f2fs_sb_info *sbi)
+void recover_orphan_inodes(struct f2fs_sb_info *sbi)
 {
 	block_t start_blk, orphan_blkaddr, i, j;
 
 	if (!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG))
-		return 0;
+		return;
 
 	sbi->por_doing = true;
 	start_blk = __start_cp_addr(sbi) + 1;
@@ -295,7 +295,7 @@ int recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	/* clear Orphan Flag */
 	clear_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG);
 	sbi->por_doing = false;
-	return 0;
+	return;
 }
 
 static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c8eb37e..bb96b64 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1114,7 +1114,7 @@ int acquire_orphan_inode(struct f2fs_sb_info *);
 void release_orphan_inode(struct f2fs_sb_info *);
 void add_orphan_inode(struct f2fs_sb_info *, nid_t);
 void remove_orphan_inode(struct f2fs_sb_info *, nid_t);
-int recover_orphan_inodes(struct f2fs_sb_info *);
+void recover_orphan_inodes(struct f2fs_sb_info *);
 int get_valid_checkpoint(struct f2fs_sb_info *);
 void set_dirty_dir_page(struct inode *, struct page *);
 void add_dirty_dir_inode(struct inode *);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9981b28..09a2b07 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -946,9 +946,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	/* if there are nt orphan nodes free them */
-	err = -EINVAL;
-	if (recover_orphan_inodes(sbi))
-		goto free_node_inode;
+	recover_orphan_inodes(sbi);
 
 	/* read root inode and dentry */
 	root = f2fs_iget(sb, F2FS_ROOT_INO(sbi));
@@ -957,8 +955,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		err = PTR_ERR(root);
 		goto free_node_inode;
 	}
-	if (!S_ISDIR(root->i_mode) || !root->i_blocks || !root->i_size)
+	if (!S_ISDIR(root->i_mode) || !root->i_blocks || !root->i_size) {
+		err = -EINVAL;
 		goto free_root_inode;
+	}
 
 	sb->s_root = d_make_root(root); /* allocate root dentry */
 	if (!sb->s_root) {
-- 
1.7.9.5


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
