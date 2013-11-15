From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/5] f2fs: add key functions for small discards
Date: Fri, 15 Nov 2013 14:20:21 +0900
Message-ID: <1384492824-32483-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1384492824-32483-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VhBqT-0003XJ-MU
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Nov 2013 05:21:29 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VhBqS-0005wy-Nj for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Nov 2013 05:21:29 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWA00FCWHJE4QO0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Nov 2013 14:21:14 +0900 (KST)
In-reply-to: <1384492824-32483-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds key functions to activate the small discard feature.

Note that this procedure is conducted during the checkpoint only.

In flush_sit_entries(), when a new dirty sit entry is flushed, f2fs calls
add_discard_addrs() which searches candidates to be discarded.
The candidates should be marked *invalidated* and also previous checkpoint
recognizes it as *valid*.

At the end of a checkpoint procedure, f2fs throws discards based on the
discard entry list.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/segment.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 823526e..505a889 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -266,6 +266,47 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 	mutex_unlock(&dirty_i->seglist_lock);
 }
 
+static void add_discard_addrs(struct f2fs_sb_info *sbi,
+			unsigned int segno, struct seg_entry *se)
+{
+	struct list_head *head = &SM_I(sbi)->discard_list;
+	struct discard_entry *new;
+	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
+	int max_blocks = sbi->blocks_per_seg;
+	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
+	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
+	unsigned long dmap[entries];
+	unsigned int start = 0, end = -1;
+	int i;
+
+	if (!test_opt(sbi, DISCARD))
+		return;
+
+	/* zero block will be discarded through the prefree list */
+	if (!se->valid_blocks || se->valid_blocks == max_blocks)
+		return;
+
+	/* SIT_VBLOCK_MAP_SIZE should be multiple of sizeof(unsigned long) */
+	for (i = 0; i < entries; i++)
+		dmap[i] = (cur_map[i] ^ ckpt_map[i]) & ckpt_map[i];
+
+	while (SM_I(sbi)->nr_discards <= SM_I(sbi)->max_discards) {
+		start = __find_rev_next_bit(dmap, max_blocks, end + 1);
+		if (start >= max_blocks)
+			break;
+
+		end = __find_rev_next_zero_bit(dmap, max_blocks, start + 1);
+
+		new = f2fs_kmem_cache_alloc(discard_entry_slab, GFP_NOFS);
+		INIT_LIST_HEAD(&new->list);
+		new->blkaddr = START_BLOCK(sbi, segno) + start;
+		new->len = end - start;
+
+		list_add_tail(&new->list, head);
+		SM_I(sbi)->nr_discards += end - start;
+	}
+}
+
 /*
  * Should call clear_prefree_segments after checkpoint is done.
  */
@@ -288,6 +329,9 @@ static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
 
 void clear_prefree_segments(struct f2fs_sb_info *sbi)
 {
+	struct list_head *head = &(SM_I(sbi)->discard_list);
+	struct list_head *this, *next;
+	struct discard_entry *entry;
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	unsigned long *prefree_map = dirty_i->dirty_segmap[PRE];
 	unsigned int total_segs = TOTAL_SEGS(sbi);
@@ -318,6 +362,18 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi)
 				GFP_NOFS, 0);
 	}
 	mutex_unlock(&dirty_i->seglist_lock);
+
+	/* send small discards */
+	list_for_each_safe(this, next, head) {
+		entry = list_entry(this, struct discard_entry, list);
+		blkdev_issue_discard(sbi->sb->s_bdev,
+				entry->blkaddr << sbi->log_sectors_per_block,
+				(1 << sbi->log_sectors_per_block) * entry->len,
+				GFP_NOFS, 0);
+		list_del(&entry->list);
+		SM_I(sbi)->nr_discards -= entry->len;
+		kmem_cache_free(discard_entry_slab, entry);
+	}
 }
 
 static void __mark_sit_entry_dirty(struct f2fs_sb_info *sbi, unsigned int segno)
@@ -1469,6 +1525,10 @@ void flush_sit_entries(struct f2fs_sb_info *sbi)
 
 		sit_offset = SIT_ENTRY_OFFSET(sit_i, segno);
 
+		/* add discard candidates */
+		if (SM_I(sbi)->nr_discards < SM_I(sbi)->max_discards)
+			add_discard_addrs(sbi, segno, se);
+
 		if (flushed)
 			goto to_sit_page;
 
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
