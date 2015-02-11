From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: avoid variable length array
Date: Tue, 10 Feb 2015 17:25:22 -0800
Message-ID: <1423617922-87948-2-git-send-email-jaegeuk@kernel.org>
References: <1423617922-87948-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YLM3g-0007XZ-8m
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 11 Feb 2015 01:25:40 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YLM3f-0007EH-1z for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 11 Feb 2015 01:25:40 +0000
In-Reply-To: <1423617922-87948-1-git-send-email-jaegeuk@kernel.org>
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

Instead of using variable length array, this patch let preallocate memory for
them.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c   |  1 +
 fs/f2fs/segment.c | 10 ++++++++--
 fs/f2fs/segment.h |  1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index ac2bd8e..e671373 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -142,6 +142,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	si->base_mem += MAIN_SEGS(sbi) * sizeof(struct seg_entry);
 	si->base_mem += f2fs_bitmap_size(MAIN_SEGS(sbi));
 	si->base_mem += 2 * SIT_VBLOCK_MAP_SIZE * MAIN_SEGS(sbi);
+	si->base_mem += SIT_VBLOCK_MAP_SIZE;
 	if (sbi->segs_per_sec > 1)
 		si->base_mem += MAIN_SECS(sbi) * sizeof(struct sec_entry);
 	si->base_mem += __bitmap_size(sbi, SIT_BITMAP);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 877a272..c9d314f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -505,7 +505,7 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct seg_entry *se = get_seg_entry(sbi, cpc->trim_start);
 	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
 	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
-	unsigned long dmap[entries];
+	unsigned long *dmap = SIT_I(sbi)->tmp_map;
 	unsigned int start = 0, end = -1;
 	bool force = (cpc->reason == CP_DISCARD);
 	int i;
@@ -924,7 +924,7 @@ static void __next_free_blkoff(struct f2fs_sb_info *sbi,
 {
 	struct seg_entry *se = get_seg_entry(sbi, seg->segno);
 	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
-	unsigned long target_map[entries];
+	unsigned long *target_map = SIT_I(sbi)->tmp_map;
 	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
 	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
 	int i, pos;
@@ -1855,6 +1855,10 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 			return -ENOMEM;
 	}
 
+	sit_i->tmp_map = kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
+	if (!sit_i->tmp_map)
+		return -ENOMEM;
+
 	if (sbi->segs_per_sec > 1) {
 		sit_i->sec_entries = vzalloc(MAIN_SECS(sbi) *
 					sizeof(struct sec_entry));
@@ -2236,6 +2240,8 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
 			kfree(sit_i->sentries[start].ckpt_valid_map);
 		}
 	}
+	kfree(sit_i->tmp_map);
+
 	vfree(sit_i->sentries);
 	vfree(sit_i->sec_entries);
 	kfree(sit_i->dirty_sentries_bitmap);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 421d579..ba858ca 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -189,6 +189,7 @@ struct sit_info {
 	char *sit_bitmap;		/* SIT bitmap pointer */
 	unsigned int bitmap_size;	/* SIT bitmap size */
 
+	unsigned long *tmp_map;			/* bitmap for temporal use */
 	unsigned long *dirty_sentries_bitmap;	/* bitmap for dirty sentries */
 	unsigned int dirty_sentries;		/* # of dirty sentries */
 	unsigned int sents_per_block;		/* # of SIT entries per block */
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
