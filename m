From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: don't access node/meta inode mapping after iput
Date: Thu,  3 Jan 2019 20:20:25 -0800
Message-ID: <20190104042025.31982-2-jaegeuk@kernel.org>
References: <20190104042025.31982-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104042025.31982-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This fixes wrong access of address spaces of node and meta inodes after iput.

Fixes: 60aa4d5536ab ("f2fs: fix use-after-free issue when accessing sbi->stat_info")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c | 19 ++++++++++++-------
 fs/f2fs/super.c |  5 +++++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index ebcc121920ba..503fde8349e6 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -96,8 +96,10 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->free_secs = free_sections(sbi);
 	si->prefree_count = prefree_segments(sbi);
 	si->dirty_count = dirty_segments(sbi);
-	si->node_pages = NODE_MAPPING(sbi)->nrpages;
-	si->meta_pages = META_MAPPING(sbi)->nrpages;
+	if (sbi->node_inode)
+		si->node_pages = NODE_MAPPING(sbi)->nrpages;
+	if (sbi->meta_inode)
+		si->meta_pages = META_MAPPING(sbi)->nrpages;
 	si->nats = NM_I(sbi)->nat_cnt;
 	si->dirty_nats = NM_I(sbi)->dirty_nat_cnt;
 	si->sits = MAIN_SEGS(sbi);
@@ -175,7 +177,6 @@ static void update_sit_info(struct f2fs_sb_info *sbi)
 static void update_mem_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_stat_info *si = F2FS_STAT(sbi);
-	unsigned npages;
 	int i;
 
 	if (si->base_mem)
@@ -258,10 +259,14 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 						sizeof(struct extent_node);
 
 	si->page_mem = 0;
-	npages = NODE_MAPPING(sbi)->nrpages;
-	si->page_mem += (unsigned long long)npages << PAGE_SHIFT;
-	npages = META_MAPPING(sbi)->nrpages;
-	si->page_mem += (unsigned long long)npages << PAGE_SHIFT;
+	if (sbi->node_inode) {
+		unsigned npages = NODE_MAPPING(sbi)->nrpages;
+		si->page_mem += (unsigned long long)npages << PAGE_SHIFT;
+	}
+	if (sbi->meta_inode) {
+		unsigned npages = META_MAPPING(sbi)->nrpages;
+		si->page_mem += (unsigned long long)npages << PAGE_SHIFT;
+	}
 }
 
 static int stat_show(struct seq_file *s, void *v)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c46a1d4318d4..14f033e1ab42 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1075,7 +1075,10 @@ static void f2fs_put_super(struct super_block *sb)
 	f2fs_bug_on(sbi, sbi->fsync_node_num);
 
 	iput(sbi->node_inode);
+	sbi->node_inode = NULL;
+
 	iput(sbi->meta_inode);
+	sbi->meta_inode = NULL;
 
 	/*
 	 * iput() can update stat information, if f2fs_write_checkpoint()
@@ -3410,6 +3413,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	f2fs_release_ino_entry(sbi, true);
 	truncate_inode_pages_final(NODE_MAPPING(sbi));
 	iput(sbi->node_inode);
+	sbi->node_inode = NULL;
 free_stats:
 	f2fs_destroy_stats(sbi);
 free_nm:
@@ -3422,6 +3426,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_meta_inode:
 	make_bad_inode(sbi->meta_inode);
 	iput(sbi->meta_inode);
+	sbi->meta_inode = NULL;
 free_io_dummy:
 	mempool_destroy(sbi->write_io_dummy);
 free_percpu:
-- 
2.19.0.605.g01d371f741-goog
