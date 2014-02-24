From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/2] f2fs: implement a lock-free stat_show
Date: Mon, 24 Feb 2014 16:18:04 +0900
Message-ID: <1393226284-22447-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1393226284-22447-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WHppR-0003Hs-NP
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Feb 2014 07:19:53 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WHppP-00019q-Hf
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Feb 2014 07:19:53 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N1H00HI8OCSCU30@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Feb 2014 16:19:40 +0900 (KST)
In-reply-to: <1393226284-22447-1-git-send-email-jaegeuk.kim@samsung.com>
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

The stat_show is just to show the current status of f2fs.
So, we can remove all the there-in locks.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/debug.c   |  3 ---
 fs/f2fs/f2fs.h    | 18 +++---------------
 fs/f2fs/segment.h | 27 +++------------------------
 3 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 46a12e4..b7111c4 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -86,7 +86,6 @@ static void update_sit_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_stat_info *si = F2FS_STAT(sbi);
 	unsigned int blks_per_sec, hblks_per_sec, total_vblocks, bimodal, dist;
-	struct sit_info *sit_i = SIT_I(sbi);
 	unsigned int segno, vblocks;
 	int ndirty = 0;
 
@@ -94,7 +93,6 @@ static void update_sit_info(struct f2fs_sb_info *sbi)
 	total_vblocks = 0;
 	blks_per_sec = sbi->segs_per_sec * (1 << sbi->log_blocks_per_seg);
 	hblks_per_sec = blks_per_sec / 2;
-	mutex_lock(&sit_i->sentry_lock);
 	for (segno = 0; segno < TOTAL_SEGS(sbi); segno += sbi->segs_per_sec) {
 		vblocks = get_valid_blocks(sbi, segno, sbi->segs_per_sec);
 		dist = abs(vblocks - hblks_per_sec);
@@ -105,7 +103,6 @@ static void update_sit_info(struct f2fs_sb_info *sbi)
 			ndirty++;
 		}
 	}
-	mutex_unlock(&sit_i->sentry_lock);
 	dist = TOTAL_SECS(sbi) * hblks_per_sec * hblks_per_sec / 100;
 	si->bimodal = bimodal / dist;
 	if (si->dirty_count)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 11fd8be..4beedcc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -704,11 +704,7 @@ static inline int get_blocktype_secs(struct f2fs_sb_info *sbi, int block_type)
 
 static inline block_t valid_user_blocks(struct f2fs_sb_info *sbi)
 {
-	block_t ret;
-	spin_lock(&sbi->stat_lock);
-	ret = sbi->total_valid_block_count;
-	spin_unlock(&sbi->stat_lock);
-	return ret;
+	return sbi->total_valid_block_count;
 }
 
 static inline unsigned long __bitmap_size(struct f2fs_sb_info *sbi, int flag)
@@ -804,11 +800,7 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
 
 static inline unsigned int valid_node_count(struct f2fs_sb_info *sbi)
 {
-	unsigned int ret;
-	spin_lock(&sbi->stat_lock);
-	ret = sbi->total_valid_node_count;
-	spin_unlock(&sbi->stat_lock);
-	return ret;
+	return sbi->total_valid_node_count;
 }
 
 static inline void inc_valid_inode_count(struct f2fs_sb_info *sbi)
@@ -829,11 +821,7 @@ static inline void dec_valid_inode_count(struct f2fs_sb_info *sbi)
 
 static inline unsigned int valid_inode_count(struct f2fs_sb_info *sbi)
 {
-	unsigned int ret;
-	spin_lock(&sbi->stat_lock);
-	ret = sbi->total_valid_inode_count;
-	spin_unlock(&sbi->stat_lock);
-	return ret;
+	return sbi->total_valid_inode_count;
 }
 
 static inline void f2fs_put_page(struct page *page, int unlock)
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 4024546..c3d5e36 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -380,26 +380,12 @@ static inline void get_sit_bitmap(struct f2fs_sb_info *sbi,
 
 static inline block_t written_block_count(struct f2fs_sb_info *sbi)
 {
-	struct sit_info *sit_i = SIT_I(sbi);
-	block_t vblocks;
-
-	mutex_lock(&sit_i->sentry_lock);
-	vblocks = sit_i->written_valid_blocks;
-	mutex_unlock(&sit_i->sentry_lock);
-
-	return vblocks;
+	return SIT_I(sbi)->written_valid_blocks;
 }
 
 static inline unsigned int free_segments(struct f2fs_sb_info *sbi)
 {
-	struct free_segmap_info *free_i = FREE_I(sbi);
-	unsigned int free_segs;
-
-	read_lock(&free_i->segmap_lock);
-	free_segs = free_i->free_segments;
-	read_unlock(&free_i->segmap_lock);
-
-	return free_segs;
+	return FREE_I(sbi)->free_segments;
 }
 
 static inline int reserved_segments(struct f2fs_sb_info *sbi)
@@ -409,14 +395,7 @@ static inline int reserved_segments(struct f2fs_sb_info *sbi)
 
 static inline unsigned int free_sections(struct f2fs_sb_info *sbi)
 {
-	struct free_segmap_info *free_i = FREE_I(sbi);
-	unsigned int free_secs;
-
-	read_lock(&free_i->segmap_lock);
-	free_secs = free_i->free_sections;
-	read_unlock(&free_i->segmap_lock);
-
-	return free_secs;
+	return FREE_I(sbi)->free_sections;
 }
 
 static inline unsigned int prefree_segments(struct f2fs_sb_info *sbi)
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
