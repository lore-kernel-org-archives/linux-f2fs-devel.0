From: Hou Pengyang <houpengyang@huawei.com>
Subject: [RFC] add ovp valid_blocks check for bg gc victim to
	fg_gc
Date: Thu, 16 Feb 2017 12:34:31 +0000
Message-ID: <20170216123431.14811-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1ceLH1-0001PE-1E
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Feb 2017 12:34:59 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ceLGw-0004VN-Mq
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Feb 2017 12:34:59 +0000
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

For foreground gc, greedy algorithm should be adapted, which makes
this formula work well:

	(2 * (100 / config.overprovision + 1) + 6)

But currently, we fg_gc have a prior to select bg_gc victim segments to gc first,
these victims are selected by cost-benefit algorithm, we can't guarantee such segments
have the small valid blocks, which may destroy the f2fs rule, on the worstest case, would 
consume all the free segments.

This patch fix this by add a filter in check_bg_victims, if segment's has # of valid blocks
over overprovision ratio, skip such segments.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/gc.c      |  4 ++++
 fs/f2fs/segment.h | 12 ++++++++++++
 fs/f2fs/super.c   | 10 ++++++++++
 4 files changed, 27 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c9a97c3..0afe94f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -881,6 +881,7 @@ struct f2fs_sb_info {
 	struct mutex gc_mutex;			/* mutex for GC */
 	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
 	unsigned int cur_victim_sec;		/* current victim section num */
+	unsigned int fggc_threshold;	/* threshold for converting bg victims for fg */
 
 	/* maximum # of trials to find a victim segment for SSR and GC */
 	unsigned int max_victim_search;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 88e5e7b..18f3efa 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -199,6 +199,10 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
 	for_each_set_bit(secno, dirty_i->victim_secmap, MAIN_SECS(sbi)) {
 		if (sec_usage_check(sbi, secno))
 			continue;
+
+		if (valid_blocks_ovp_check(sbi, secno))
+			continue;
+
 		clear_bit(secno, dirty_i->victim_secmap);
 		return secno * sbi->segs_per_sec;
 	}
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5cb5755..2a6a1a9 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -716,6 +716,18 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
 				- (base + 1) + type;
 }
 
+static inline bool valid_blocks_ovp_check(struct f2fs_sb_info *sbi, unsigned int secno)
+{
+	struct sit_info *sit_i = SIT_I(sbi);
+	unsigned int valid_blocks;
+
+	valid_blocks = sit_i->sec_entries[secno].valid_blocks;
+	if (valid_blocks >= sbi->fggc_threshold)
+		return true;
+	return false;
+
+}
+
 static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
 {
 	if (IS_CURSEC(sbi, secno) || (sbi->cur_victim_sec == secno))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 68a555b..54c4dac 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2090,6 +2090,16 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		if (err)
 			goto free_kobj;
 	}
+
+	sbi->fggc_threshold = (le32_to_cpu(sbi->ckpt->overprov_segment_count) -
+					le32_to_cpu(sbi->ckpt->rsvd_segment_count)) * 100 /
+					(le32_to_cpu(sbi->raw_super->segment_count_main) -
+					le32_to_cpu(sbi->ckpt->rsvd_segment_count)) *
+					sbi->blocks_per_seg * sbi->segs_per_sec / 100;
+
+	sbi->fggc_threshold = sbi->blocks_per_seg * sbi->segs_per_sec -
+					sbi->fggc_threshold;
+
 	kfree(options);
 
 	/* recover broken superblock */
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
