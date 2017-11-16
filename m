From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: reserve nid resource for quota sysfile
Date: Thu, 16 Nov 2017 16:59:14 +0800
Message-ID: <20171116085914.91539-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eFG1R-0004Bs-MY
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 08:59:45 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eFG1P-0003VY-EW
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 08:59:45 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

During mkfs, quota sysfiles have already occupied nid resource,
it needs to adjust remaining available nid count in kernel side.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c |  9 +--------
 fs/f2fs/f2fs.h  |  2 ++
 fs/f2fs/node.c  |  2 +-
 fs/f2fs/super.c | 10 +++++++++-
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index ecada8425268..4d929627e210 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -49,14 +49,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ndirty_imeta = get_pages(sbi, F2FS_DIRTY_IMETA);
 	si->ndirty_dirs = sbi->ndirty_inode[DIR_INODE];
 	si->ndirty_files = sbi->ndirty_inode[FILE_INODE];
-
-	si->nquota_files = 0;
-	if (f2fs_sb_has_quota_ino(sbi->sb)) {
-		for (i = 0; i < MAXQUOTAS; i++) {
-			if (f2fs_qf_ino(sbi->sb, i))
-				si->nquota_files++;
-		}
-	}
+	si->nquota_files = sbi->nquota_files;
 	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
 	si->inmem_pages = get_pages(sbi, F2FS_INMEM_PAGES);
 	si->aw_cnt = atomic_read(&sbi->aw_cnt);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ca6b0c9bc621..70a982435960 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1103,6 +1103,8 @@ struct f2fs_sb_info {
 	block_t reserved_blocks;		/* configurable reserved blocks */
 	block_t current_reserved_blocks;	/* current reserved blocks */
 
+	unsigned int nquota_files;		/* # of quota sysfile */
+
 	u32 s_next_generation;			/* for NFS support */
 
 	/* # of pages, see count_type */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fe1fc662af2a..64c9b9050c4c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2680,7 +2680,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 
 	/* not used nids: 0, node, meta, (and root counted as valid node) */
 	nm_i->available_nids = nm_i->max_nid - sbi->total_valid_node_count -
-							F2FS_RESERVED_NODE_NUM;
+				sbi->nquota_files - F2FS_RESERVED_NODE_NUM;
 	nm_i->nid_cnt[FREE_NID] = 0;
 	nm_i->nid_cnt[PREALLOC_NID] = 0;
 	nm_i->nat_cnt = 0;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 031cb26a3a76..1df28b508c3e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1008,7 +1008,8 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
 						sbi->current_reserved_blocks;
 
-	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
+	avail_node_count = sbi->total_node_count - sbi->nquota_files -
+						F2FS_RESERVED_NODE_NUM;
 
 	if (avail_node_count > user_block_count) {
 		buf->f_files = user_block_count;
@@ -2467,6 +2468,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	else
 		sb->s_qcop = &f2fs_quotactl_ops;
 	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
+
+	if (f2fs_sb_has_quota_ino(sbi->sb)) {
+		for (i = 0; i < MAXQUOTAS; i++) {
+			if (f2fs_qf_ino(sbi->sb, i))
+				sbi->nquota_files++;
+		}
+	}
 #endif
 
 	sb->s_op = &f2fs_sops;
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
