From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v2] This reverts commit
 5e443818fa0b2a2845561ee25bec181424fb2889
Date: Sat, 28 Oct 2017 23:43:31 +0800
Message-ID: <1509205411-144669-1-git-send-email-yunlong.song@huawei.com>
References: <20171028115709.4622-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yunlong.song@huawei.com>)
 id 1e8TIF-0007dA-Hb
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Oct 2017 15:45:03 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1e8TID-0005je-KD
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Oct 2017 15:45:03 +0000
In-Reply-To: <20171028115709.4622-1-chao@kernel.org>
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
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

The commit should be reverted because call sequence of below two parts
of code must be kept:
a. update sit information, it needs to be updated before segment
allocation since latter allocation may trigger SSR, and SSR allocation
needs latest valid block information of all segments.
b. update segment status, it needs to be updated after segment allocation
since we can skip updating current opened segment status.

Fixes: 5e443818fa0b ("f2fs: handle dirty segments inside refresh_sit_entry")
Suggested-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/f2fs.h    |  1 -
 fs/f2fs/segment.c | 20 +++++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 13a96b8..f166112 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2567,7 +2567,6 @@ int restore_node_summary(struct f2fs_sb_info *sbi,
 bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 void init_discard_policy(struct discard_policy *dpolicy, int discard_type,
 						unsigned int granularity);
-void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new);
 void stop_discard_thread(struct f2fs_sb_info *sbi);
 bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
 void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 46dfbca..a3509e9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1884,14 +1884,11 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 		get_sec_entry(sbi, segno)->valid_blocks += del;
 }
 
-void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new)
+static void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new)
 {
 	update_sit_entry(sbi, new, 1);
 	if (GET_SEGNO(sbi, old) != NULL_SEGNO)
 		update_sit_entry(sbi, old, -1);
-
-	locate_dirty_segment(sbi, GET_SEGNO(sbi, old));
-	locate_dirty_segment(sbi, GET_SEGNO(sbi, new));
 }
 
 void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
@@ -2529,13 +2526,22 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 
 	stat_inc_block_count(sbi, curseg);
 
+	/*
+	 * SIT information should be updated before segment allocation,
+	 * since SSR needs latest valid block information.
+	 */
+	refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
+
 	if (!__has_curseg_space(sbi, type))
 		sit_i->s_ops->allocate_segment(sbi, type, false);
+
 	/*
-	 * SIT information should be updated after segment allocation,
-	 * since we need to keep dirty segments precisely under SSR.
+	 * segment dirty status should be updated after segment allocation,
+	 * so we just need to update status only one time after previous
+	 * segment being closed.
 	 */
-	refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
+	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
+	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
 
 	mutex_unlock(&sit_i->sentry_lock);
 
-- 
1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
