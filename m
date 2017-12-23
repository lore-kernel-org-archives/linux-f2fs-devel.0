From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: avoid f2fs_gc dead loop
Date: Sat, 23 Dec 2017 21:09:10 +0800
Message-ID: <1514034550-149813-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yunlong.song@huawei.com>) id 1eSjYe-0000Mt-Uf
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Dec 2017 13:09:44 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eSjYc-00062I-7Y
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Dec 2017 13:09:44 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, miaoxie@huawei.com

For some corner case, f2fs_gc selects one target victim but cannot free
that victim segment due to some reason (e.g. the segment has some blocks
of atomic file which is not commited yet), in this case, the victim
segment may probably be selected over and over, and then f2fs_gc will
go to dead loop. This patch identifies the dead-loop segment, and skips
it in __get_victim next time.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/f2fs.h  |  8 ++++++++
 fs/f2fs/gc.c    | 34 ++++++++++++++++++++++++++++++++++
 fs/f2fs/super.c |  3 +++
 3 files changed, 45 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ca6b0c9..b75851b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -115,6 +115,13 @@ struct f2fs_mount_info {
 	unsigned int	opt;
 };
 
+struct gc_loop_info {
+	int count;
+	unsigned int segno;
+	unsigned long *segmap;
+};
+#define GC_LOOP_MAX 10
+
 #define F2FS_FEATURE_ENCRYPT		0x0001
 #define F2FS_FEATURE_BLKZONED		0x0002
 #define F2FS_FEATURE_ATOMIC_WRITE	0x0004
@@ -1125,6 +1132,7 @@ struct f2fs_sb_info {
 
 	/* threshold for converting bg victims for fg */
 	u64 fggc_threshold;
+	struct gc_loop_info gc_loop;
 
 	/* maximum # of trials to find a victim segment for SSR and GC */
 	unsigned int max_victim_search;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5d5bba4..4ee9e1b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -229,6 +229,10 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
 		if (no_fggc_candidate(sbi, secno))
 			continue;
 
+		if (sbi->gc_loop.segmap &&
+			test_bit(GET_SEG_FROM_SEC(sbi, secno), sbi->gc_loop.segmap))
+			continue;
+
 		clear_bit(secno, dirty_i->victim_secmap);
 		return GET_SEG_FROM_SEC(sbi, secno);
 	}
@@ -371,6 +375,9 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 		if (gc_type == FG_GC && p.alloc_mode == LFS &&
 					no_fggc_candidate(sbi, secno))
 			goto next;
+		if (gc_type == FG_GC && p.alloc_mode == LFS &&
+			sbi->gc_loop.segmap && test_bit(segno, sbi->gc_loop.segmap))
+			goto next;
 
 		cost = get_gc_cost(sbi, segno, &p);
 
@@ -1042,6 +1049,27 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type);
 	if (gc_type == FG_GC && seg_freed == sbi->segs_per_sec)
 		sec_freed++;
+	else if (gc_type == FG_GC && seg_freed == 0) {
+		if (!sbi->gc_loop.segmap) {
+			sbi->gc_loop.segmap =
+				kvzalloc(f2fs_bitmap_size(MAIN_SEGS(sbi)), GFP_KERNEL);
+			sbi->gc_loop.count = 0;
+			sbi->gc_loop.segno = NULL_SEGNO;
+		}
+		if (segno == sbi->gc_loop.segno) {
+			if (sbi->gc_loop.count > GC_LOOP_MAX) {
+				f2fs_bug_on(sbi, 1);
+				set_bit(segno, sbi->gc_loop.segmap);
+				sbi->gc_loop.count = 0;
+				sbi->gc_loop.segno = NULL_SEGNO;
+			}
+			else
+				sbi->gc_loop.count++;
+		} else {
+			sbi->gc_loop.segno = segno;
+			sbi->gc_loop.count = 0;
+		}
+	}
 	total_freed += seg_freed;
 
 	if (gc_type == FG_GC)
@@ -1075,6 +1103,12 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 
 	if (sync)
 		ret = sec_freed ? 0 : -EAGAIN;
+	if (sbi->gc_loop.segmap) {
+		kvfree(sbi->gc_loop.segmap);
+		sbi->gc_loop.segmap = NULL;
+		sbi->gc_loop.count = 0;
+		sbi->gc_loop.segno = NULL_SEGNO;
+	}
 	return ret;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 031cb26..76f0b72 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2562,6 +2562,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	sbi->reserved_blocks = 0;
 	sbi->current_reserved_blocks = 0;
+	sbi->gc_loop.segmap = NULL;
+	sbi->gc_loop.count = 0;
+	sbi->gc_loop.segno = NULL_SEGNO;
 
 	for (i = 0; i < NR_INODE_TYPE; i++) {
 		INIT_LIST_HEAD(&sbi->inode_list[i]);
-- 
1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
