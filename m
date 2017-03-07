From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: build stat_info before orphan inode
	recovery
Date: Tue,  7 Mar 2017 14:13:01 -0800
Message-ID: <20170307221303.6757-2-jaegeuk@kernel.org>
References: <20170307221303.6757-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1clNM3-0007pg-QC
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 22:13:15 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1clNM2-0005gM-T2
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 22:13:15 +0000
In-Reply-To: <20170307221303.6757-1-jaegeuk@kernel.org>
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

f2fs_sync_fs() -> write_checkpoint() calls stat_inc_cp_count(sbi->stat_info),
which needs stat_info allocation.
Otherwise, we can hit:

[254042.598623]  ? count_shadow_nodes+0xa0/0xa0
[254042.598633]  f2fs_sync_fs+0x65/0xd0 [f2fs]
[254042.598645]  f2fs_balance_fs_bg+0xe4/0x1c0 [f2fs]
[254042.598657]  f2fs_write_node_pages+0x34/0x1a0 [f2fs]
[254042.598664]  ? pagevec_lookup_entries+0x1e/0x30
[254042.598673]  do_writepages+0x1e/0x30
[254042.598682]  __writeback_single_inode+0x45/0x330
[254042.598688]  writeback_single_inode+0xd7/0x190
[254042.598694]  write_inode_now+0x86/0xa0
[254042.598699]  iput+0x122/0x200
[254042.598709]  f2fs_fill_super+0xd4a/0x14d0 [f2fs]
[254042.598717]  mount_bdev+0x184/0x1c0
[254042.598934]  ? f2fs_commit_super+0x100/0x100 [f2fs]
[254042.599142]  f2fs_mount+0x15/0x20 [f2fs]
[254042.599349]  mount_fs+0x39/0x160
[254042.599554]  ? __alloc_percpu+0x15/0x20
[254042.599759]  vfs_kern_mount+0x67/0x110
[254042.599972]  do_mount+0x1bb/0xc80
[254042.600175]  ? memdup_user+0x42/0x60
[254042.600380]  SyS_mount+0x83/0xd0
[254042.600583]  entry_SYSCALL_64_fastpath+0x1e/0xad

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 96fe8ed73100..cfb40d3fd875 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2022,6 +2022,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	f2fs_join_shrinker(sbi);
 
+	err = f2fs_build_stats(sbi);
+	if (err)
+		goto free_nm;
+
 	/* if there are nt orphan nodes free them */
 	err = recover_orphan_inodes(sbi);
 	if (err)
@@ -2046,10 +2050,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_root_inode;
 	}
 
-	err = f2fs_build_stats(sbi);
-	if (err)
-		goto free_root_inode;
-
 	if (f2fs_proc_root)
 		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
 
@@ -2143,7 +2143,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		remove_proc_entry("segment_bits", sbi->s_proc);
 		remove_proc_entry(sb->s_id, f2fs_proc_root);
 	}
-	f2fs_destroy_stats(sbi);
 free_root_inode:
 	dput(sb->s_root);
 	sb->s_root = NULL;
@@ -2161,6 +2160,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	truncate_inode_pages_final(META_MAPPING(sbi));
 	iput(sbi->node_inode);
 	mutex_unlock(&sbi->umount_mutex);
+	f2fs_destroy_stats(sbi);
 free_nm:
 	destroy_node_manager(sbi);
 free_sm:
-- 
2.11.0


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
