From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: skip ->writepages for {mete,
 node}_inode during recovery
Date: Thu, 29 Jun 2017 23:20:45 +0800
Message-ID: <20170629152046.2610-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1dQbHX-0006dN-4x
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Jun 2017 15:22:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dQbHW-0008W5-Ck
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Jun 2017 15:22:59 +0000
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

From: Chao Yu <yuchao0@huawei.com>

Skip ->writepages in prior to ->writepage for {meta,node}_inode during
recovery, hence unneeded loop in ->writepages can be avoided.

Moreover, check SBI_POR_DOING earlier while writebacking pages.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  3 +++
 fs/f2fs/data.c       | 13 +++++++------
 fs/f2fs/node.c       |  3 +++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 12559a4b6c24..954917d582f8 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -269,6 +269,9 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
 	long diff, written;
 
+	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
+		goto skip_write;
+
 	/* collect a number of dirty meta pages and write together */
 	if (wbc->for_kupdate ||
 		get_pages(sbi, F2FS_DIRTY_META) < nr_pages_to_skip(sbi, META))
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9141bd19a902..d58b81213a86 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1493,6 +1493,9 @@ static int __write_data_page(struct page *page, bool *submitted,
 
 	trace_f2fs_writepage(page, DATA);
 
+	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
+		goto redirty_out;
+
 	if (page->index < end_index)
 		goto write;
 
@@ -1506,8 +1509,6 @@ static int __write_data_page(struct page *page, bool *submitted,
 
 	zero_user_segment(page, offset, PAGE_SIZE);
 write:
-	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
-		goto redirty_out;
 	if (f2fs_is_drop_cache(inode))
 		goto out;
 	/* we should not write 0'th page having journal header */
@@ -1755,6 +1756,10 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	if (!get_dirty_pages(inode) && wbc->sync_mode == WB_SYNC_NONE)
 		return 0;
 
+	/* during POR, we don't need to trigger writepage at all. */
+	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
+		goto skip_write;
+
 	if (S_ISDIR(inode->i_mode) && wbc->sync_mode == WB_SYNC_NONE &&
 			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
 			available_free_memory(sbi, DIRTY_DENTS))
@@ -1764,10 +1769,6 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	if (is_inode_flag_set(inode, FI_DO_DEFRAG))
 		goto skip_write;
 
-	/* during POR, we don't need to trigger writepage at all. */
-	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
-		goto skip_write;
-
 	trace_f2fs_writepages(mapping->host, wbc, DATA);
 
 	/* to avoid spliting IOs due to mixed WB_SYNC_ALL and WB_SYNC_NONE */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f6f46be139f4..fd57ffd88508 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1687,6 +1687,9 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	struct blk_plug plug;
 	long diff;
 
+	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
+		goto skip_write;
+
 	/* balancing f2fs's metadata in background */
 	f2fs_balance_fs_bg(sbi);
 
-- 
2.13.0.90.g1eb437020


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
