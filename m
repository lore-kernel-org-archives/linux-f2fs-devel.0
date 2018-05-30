From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/2] f2fs: fix to update mtime correctly
Date: Wed, 30 May 2018 23:10:41 +0800
Message-ID: <20180530151041.24726-2-chao@kernel.org>
References: <20180530151041.24726-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fO2l9-0004ps-51
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 May 2018 15:11:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fO2l6-0095Fo-7w
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 May 2018 15:11:31 +0000
In-Reply-To: <20180530151041.24726-1-chao@kernel.org>
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

If we change system time to the past, get_mtime() will return a
overflowed time, and SIT_I(sbi)->max_mtime will be udpated
incorrectly, this patch fixes the two issues.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix to cover base time updating. 
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/segment.c    |  7 ++++---
 fs/f2fs/segment.h    | 16 +++++++++++++---
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8eb184c3de84..40b39db317ea 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1233,7 +1233,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * modify checkpoint
 	 * version number is already updated
 	 */
-	ckpt->elapsed_time = cpu_to_le64(get_mtime(sbi));
+	ckpt->elapsed_time = cpu_to_le64(get_mtime(sbi, true));
 	ckpt->free_segment_count = cpu_to_le32(free_segments(sbi));
 	for (i = 0; i < NR_CURSEG_NODE_TYPE; i++) {
 		ckpt->cur_node_segno[i] =
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 66983acaad16..c1bd31da772d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1822,8 +1822,9 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 				(new_vblocks > sbi->blocks_per_seg)));
 
 	se->valid_blocks = new_vblocks;
-	se->mtime = get_mtime(sbi);
-	SIT_I(sbi)->max_mtime = se->mtime;
+	se->mtime = get_mtime(sbi, false);
+	if (se->mtime > SIT_I(sbi)->max_mtime)
+		SIT_I(sbi)->max_mtime = se->mtime;
 
 	/* Update valid block bitmap */
 	if (del > 0) {
@@ -3879,7 +3880,7 @@ static void init_min_max_mtime(struct f2fs_sb_info *sbi)
 		if (sit_i->min_mtime > mtime)
 			sit_i->min_mtime = mtime;
 	}
-	sit_i->max_mtime = get_mtime(sbi);
+	sit_i->max_mtime = get_mtime(sbi, false);
 	up_write(&sit_i->sentry_lock);
 }
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index c574131ac7e1..11e62cd76269 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -745,12 +745,22 @@ static inline void set_to_next_sit(struct sit_info *sit_i, unsigned int start)
 #endif
 }
 
-static inline unsigned long long get_mtime(struct f2fs_sb_info *sbi)
+static inline unsigned long long get_mtime(struct f2fs_sb_info *sbi,
+						bool base_time)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	time64_t now = ktime_get_real_seconds();
+	time64_t diff, now = ktime_get_real_seconds();
 
-	return sit_i->elapsed_time + now - sit_i->mounted_time;
+	if (now >= sit_i->mounted_time)
+		return sit_i->elapsed_time + now - sit_i->mounted_time;
+
+	/* system time is set to the past */
+	if (!base_time) {
+		diff = sit_i->mounted_time - now;
+		if (sit_i->elapsed_time >= diff)
+			return sit_i->elapsed_time - diff;
+	}
+	return sit_i->elapsed_time;
 }
 
 static inline void set_summary(struct f2fs_summary *sum, nid_t nid,
-- 
2.16.2.17.g38e79b1fd


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
