From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: do not skip dentry block writes
Date: Fri, 25 Sep 2015 19:54:53 -0700
Message-ID: <1443236093-13099-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Zffe1-0005eX-4z
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 02:55:25 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Zffe0-0004kS-1R for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 02:55:25 +0000
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

Previously, we skip dentry block writes when wbc is SYNC_NONE with no memory
pressure and the number of dirty pages is pretty small.

But, we didn't skip for normal data writes, which gives us not much big impact
on overall performance.
Moreover, by skipping some data writes, kworker falls into infinite loop to try
to write blocks, when many dir inodes have only one dentry block.

So, this patch removes skipping data writes.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    | 5 -----
 fs/f2fs/node.c    | 5 -----
 fs/f2fs/node.h    | 1 -
 fs/f2fs/segment.h | 4 +---
 4 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bc04e92..a903423 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1340,11 +1340,6 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	if (!get_dirty_pages(inode) && wbc->sync_mode == WB_SYNC_NONE)
 		return 0;
 
-	if (S_ISDIR(inode->i_mode) && wbc->sync_mode == WB_SYNC_NONE &&
-			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
-			available_free_memory(sbi, DIRTY_DENTS))
-		goto skip_write;
-
 	/* during POR, we don't need to trigger writepage at all. */
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto skip_write;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4d9bedf..1fe49ca 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -52,11 +52,6 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 		mem_size = (nm_i->nat_cnt * sizeof(struct nat_entry)) >>
 							PAGE_CACHE_SHIFT;
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
-	} else if (type == DIRTY_DENTS) {
-		if (sbi->sb->s_bdi->wb.dirty_exceeded)
-			return false;
-		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
-		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
 	} else if (type == INO_ENTRIES) {
 		int i;
 
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 7427e95..51c62ed 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -118,7 +118,6 @@ static inline void raw_nat_from_node_info(struct f2fs_nat_entry *raw_ne,
 enum mem_type {
 	FREE_NIDS,	/* indicates the free nid list */
 	NAT_ENTRIES,	/* indicates the cached nat entry */
-	DIRTY_DENTS,	/* indicates dirty dentry pages */
 	INO_ENTRIES,	/* indicates inode entries */
 	EXTENT_CACHE,	/* indicates extent cache */
 	BASE_CHECK,	/* check kernel status */
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b6e4ed1..a294da7 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -697,9 +697,7 @@ static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
 	if (sbi->sb->s_bdi->wb.dirty_exceeded)
 		return 0;
 
-	if (type == DATA)
-		return sbi->blocks_per_seg;
-	else if (type == NODE)
+	if (type == NODE)
 		return 3 * sbi->blocks_per_seg;
 	else if (type == META)
 		return MAX_BIO_BLOCKS(sbi);
-- 
2.1.1


------------------------------------------------------------------------------
