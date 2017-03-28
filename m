From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: use bitmap in discard_entry
Date: Tue, 28 Mar 2017 18:18:50 +0800
Message-ID: <20170328101850.27356-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1csoDo-0002zX-Mj
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Mar 2017 10:19:28 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1csoDm-0007XU-V5
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Mar 2017 10:19:28 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch changes to use bitmap instead of extent in struct discard_entry
to indicate discard range in one segment, for fragmented space, this
implementation can save memory footprint.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  6 ++---
 fs/f2fs/segment.c | 72 ++++++++++++++++++++++++++++++-------------------------
 2 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index aa6fdeada83c..32d6f674c114 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -182,11 +182,11 @@ struct inode_entry {
 	struct inode *inode;	/* vfs inode pointer */
 };
 
-/* for the list of blockaddresses to be discarded */
+/* for the bitmap indicate blocks to be discarded */
 struct discard_entry {
 	struct list_head list;	/* list head */
-	block_t blkaddr;	/* block address to be discarded */
-	int len;		/* # of consecutive blocks of the discard */
+	block_t start_blkaddr;	/* start blockaddr of current segment */
+	unsigned char discard_map[SIT_VBLOCK_MAP_SIZE];	/* segment discard bitmap */
 };
 
 enum {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9f9542c9fe47..21b0bb4aba26 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -973,32 +973,6 @@ static int f2fs_issue_discard(struct f2fs_sb_info *sbi,
 	return err;
 }
 
-static void __add_discard_entry(struct f2fs_sb_info *sbi,
-		struct cp_control *cpc, struct seg_entry *se,
-		unsigned int start, unsigned int end)
-{
-	struct list_head *head = &SM_I(sbi)->dcc_info->discard_entry_list;
-	struct discard_entry *new, *last;
-
-	if (!list_empty(head)) {
-		last = list_last_entry(head, struct discard_entry, list);
-		if (START_BLOCK(sbi, cpc->trim_start) + start ==
-				last->blkaddr + last->len &&
-				last->len < MAX_DISCARD_BLOCKS(sbi)) {
-			last->len += end - start;
-			goto done;
-		}
-	}
-
-	new = f2fs_kmem_cache_alloc(discard_entry_slab, GFP_NOFS);
-	INIT_LIST_HEAD(&new->list);
-	new->blkaddr = START_BLOCK(sbi, cpc->trim_start) + start;
-	new->len = end - start;
-	list_add_tail(&new->list, head);
-done:
-	SM_I(sbi)->dcc_info->nr_discards += end - start;
-}
-
 static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 							bool check_only)
 {
@@ -1011,6 +985,8 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 	unsigned long *dmap = SIT_I(sbi)->tmp_map;
 	unsigned int start = 0, end = -1;
 	bool force = (cpc->reason == CP_DISCARD);
+	struct discard_entry *de = NULL;
+	struct list_head *head = &SM_I(sbi)->dcc_info->discard_entry_list;
 	int i;
 
 	if (se->valid_blocks == max_blocks || !f2fs_discard_en(sbi))
@@ -1042,7 +1018,17 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 		if (check_only)
 			return true;
 
-		__add_discard_entry(sbi, cpc, se, start, end);
+		if (!de) {
+			de = f2fs_kmem_cache_alloc(discard_entry_slab,
+								GFP_F2FS_ZERO);
+			de->start_blkaddr = START_BLOCK(sbi, cpc->trim_start);
+			list_add_tail(&de->list, head);
+		}
+
+		for (i = start; i < end; i++)
+			__set_bit_le(i, (void *)de->discard_map);
+
+		SM_I(sbi)->dcc_info->nr_discards += end - start;
 	}
 	return false;
 }
@@ -1128,13 +1114,35 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* send small discards */
 	list_for_each_entry_safe(entry, this, head, list) {
-		if (force && entry->len < cpc->trim_minlen)
-			goto skip;
-		f2fs_issue_discard(sbi, entry->blkaddr, entry->len);
-		cpc->trimmed += entry->len;
+		unsigned int cur_pos = 0, next_pos, len, total_len = 0;
+		bool is_valid = test_bit_le(0, entry->discard_map);
+
+find_next:
+		if (is_valid) {
+			next_pos = find_next_zero_bit_le(entry->discard_map,
+					sbi->blocks_per_seg, cur_pos);
+			len = next_pos - cur_pos;
+
+			if (force && len < cpc->trim_minlen)
+				goto skip;
+
+			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
+									len);
+			cpc->trimmed += len;
+			total_len += len;
+		} else {
+			next_pos = find_next_bit_le(entry->discard_map,
+					sbi->blocks_per_seg, cur_pos);
+		}
 skip:
+		cur_pos = next_pos;
+		is_valid = !is_valid;
+
+		if (cur_pos < sbi->blocks_per_seg)
+			goto find_next;
+
 		list_del(&entry->list);
-		SM_I(sbi)->dcc_info->nr_discards -= entry->len;
+		SM_I(sbi)->dcc_info->nr_discards -= total_len;
 		kmem_cache_free(discard_entry_slab, entry);
 	}
 }
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
