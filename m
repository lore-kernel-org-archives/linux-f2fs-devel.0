From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [f2fs-dev] [PATCH] f2fs: add a help func F2FS_STAT() to get the
	f2fs_stat_info
Date: Fri, 12 Jul 2013 14:47:11 +0800
Message-ID: <51DFA66F.7070809@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1UxXBq-0002Yb-14
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 12 Jul 2013 06:50:50 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UxXBl-0008Tq-Pz for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 12 Jul 2013 06:50:49 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim <jaegeuk.kim@samsung.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>

Add a help func F2FS_STAT() to get the f2fs_stat_info.


Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/debug.c |   16 ++++++++--------
 fs/f2fs/f2fs.h  |   11 ++++++++---
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 0d6c6aa..fd12b7f 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -29,7 +29,7 @@ static DEFINE_MUTEX(f2fs_stat_mutex);

 static void update_general_status(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_stat_info *si = sbi->stat_info;
+	struct f2fs_stat_info *si = F2FS_STAT(sbi);
 	int i;

 	/* valid check of the segment numbers */
@@ -83,7 +83,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
  */
 static void update_sit_info(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_stat_info *si = sbi->stat_info;
+	struct f2fs_stat_info *si = F2FS_STAT(sbi);
 	unsigned int blks_per_sec, hblks_per_sec, total_vblocks, bimodal, dist;
 	struct sit_info *sit_i = SIT_I(sbi);
 	unsigned int segno, vblocks;
@@ -118,7 +118,7 @@ static void update_sit_info(struct f2fs_sb_info *sbi)
  */
 static void update_mem_info(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_stat_info *si = sbi->stat_info;
+	struct f2fs_stat_info *si = F2FS_STAT(sbi);
 	unsigned npages;

 	if (si->base_mem)
@@ -305,11 +305,10 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	struct f2fs_stat_info *si;

-	sbi->stat_info = kzalloc(sizeof(struct f2fs_stat_info), GFP_KERNEL);
-	if (!sbi->stat_info)
+	si = kzalloc(sizeof(struct f2fs_stat_info), GFP_KERNEL);
+	if (!si)
 		return -ENOMEM;

-	si = sbi->stat_info;
 	si->all_area_segs = le32_to_cpu(raw_super->segment_count);
 	si->sit_area_segs = le32_to_cpu(raw_super->segment_count_sit);
 	si->nat_area_segs = le32_to_cpu(raw_super->segment_count_nat);
@@ -319,6 +318,7 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	si->main_area_zones = si->main_area_sections /
 				le32_to_cpu(raw_super->secs_per_zone);
 	si->sbi = sbi;
+	sbi->stat_info = si;

 	mutex_lock(&f2fs_stat_mutex);
 	list_add_tail(&si->stat_list, &f2fs_stat_list);
@@ -329,13 +329,13 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)

 void f2fs_destroy_stats(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_stat_info *si = sbi->stat_info;
+	struct f2fs_stat_info *si = F2FS_STAT(sbi);

 	mutex_lock(&f2fs_stat_mutex);
 	list_del(&si->stat_list);
 	mutex_unlock(&f2fs_stat_mutex);

-	kfree(sbi->stat_info);
+	kfree(si);
 }

 void __init f2fs_create_root_stats(void)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c7620b9..0a352b6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1113,11 +1113,16 @@ struct f2fs_stat_info {
 	unsigned base_mem, cache_mem;
 };

+static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
+{
+	return (struct f2fs_stat_info*)sbi->stat_info;
+}
+
 #define stat_inc_call_count(si)	((si)->call_count++)

 #define stat_inc_seg_count(sbi, type)					\
 	do {								\
-		struct f2fs_stat_info *si = sbi->stat_info;		\
+		struct f2fs_stat_info *si = F2FS_STAT(sbi);		\
 		(si)->tot_segs++;					\
 		if (type == SUM_TYPE_DATA)				\
 			si->data_segs++;				\
@@ -1130,14 +1135,14 @@ struct f2fs_stat_info {

 #define stat_inc_data_blk_count(sbi, blks)				\
 	do {								\
-		struct f2fs_stat_info *si = sbi->stat_info;		\
+		struct f2fs_stat_info *si = F2FS_STAT(sbi);		\
 		stat_inc_tot_blk_count(si, blks);			\
 		si->data_blks += (blks);				\
 	} while (0)

 #define stat_inc_node_blk_count(sbi, blks)				\
 	do {								\
-		struct f2fs_stat_info *si = sbi->stat_info;		\
+		struct f2fs_stat_info *si = F2FS_STAT(sbi);		\
 		stat_inc_tot_blk_count(si, blks);			\
 		si->node_blks += (blks);				\
 	} while (0)
-- 
1.7.7


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
