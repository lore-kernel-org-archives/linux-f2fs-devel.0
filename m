From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 1/3] f2fs: init local extent_info to avoid stale
	stack info in tp
Date: Thu, 23 Feb 2017 09:18:05 +0000
Message-ID: <20170223091807.36175-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1cgpXg-0004by-OU
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 09:18:28 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cgpXe-0001IQ-EZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 09:18:28 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

To avoid such stale(fops, blk, len) info in f2fs_lookup_extent_tree_end tp

dio-23095 [005] ...1 17878.856859: f2fs_lookup_extent_tree_end: 
			dev = (259,30), ino = 856, pgofs = 0, 
			ext_info(fofs: 3441207040, blk: 4294967232, len: 3481143808)

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/data.c | 8 ++++----
 fs/f2fs/file.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5f3bc98..f72493d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -511,7 +511,7 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 
 int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index)
 {
-	struct extent_info ei;
+	struct extent_info ei  = {0,0,0};
 	struct inode *inode = dn->inode;
 
 	if (f2fs_lookup_extent_cache(inode, index, &ei)) {
@@ -528,7 +528,7 @@ struct page *get_read_data_page(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	struct dnode_of_data dn;
 	struct page *page;
-	struct extent_info ei;
+	struct extent_info ei = {0,0,0};
 	int err;
 	struct f2fs_io_info fio = {
 		.sbi = F2FS_I_SB(inode),
@@ -803,7 +803,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	int err = 0, ofs = 1;
 	unsigned int ofs_in_node, last_ofs_in_node;
 	blkcnt_t prealloc;
-	struct extent_info ei;
+	struct extent_info ei = {0,0,0};
 	block_t blkaddr;
 
 	if (!maxblocks)
@@ -1667,7 +1667,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	struct dnode_of_data dn;
 	struct page *ipage;
 	bool locked = false;
-	struct extent_info ei;
+	struct extent_info ei = {0,0,0};
 	int err = 0;
 
 	/*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1201648..36c1565 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1877,7 +1877,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_map_blocks map = { .m_next_pgofs = NULL };
-	struct extent_info ei;
+	struct extent_info ei = {0,0,0};
 	pgoff_t pg_start, pg_end;
 	unsigned int blk_per_seg = sbi->blocks_per_seg;
 	unsigned int total = 0, sec_num;
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
