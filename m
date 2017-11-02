From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/4] f2fs: fix summary info corruption
Date: Thu, 2 Nov 2017 20:41:03 +0800
Message-ID: <20171102124104.75298-3-yuchao0@huawei.com>
References: <20171102124104.75298-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1eAEoL-0006xd-Lg
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 12:41:29 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1eAEoJ-0001C3-Rf
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 12:41:29 +0000
In-Reply-To: <20171102124104.75298-1-yuchao0@huawei.com>
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

Sometimes, after running generic/270 of fstest, fsck reports summary
info and actual position of block address in direct node becoming
inconsistent.

The root cause is race in between __f2fs_replace_block and change_curseg
as below:

Thread A				Thread B
- __clone_blkaddrs
 - f2fs_replace_block
  - __f2fs_replace_block
   - segnoA = GET_SEGNO(sbi, blkaddrA);
   - type = se->type:=CURSEG_HOT_DATA
   - if (!IS_CURSEG(sbi, segnoA))
         type = CURSEG_WARM_DATA
					- allocate_data_block
					 - allocate_segment
					  - get_ssr_segment
					  - change_curseg(segnoA, CURSEG_HOT_DATA)
   - change_curseg(segnoA, CURSEG_WARM_DATA)
    - reset_curseg
     - __set_sit_entry_type
      - change se->type from CURSEG_HOT_DATA to CURSEG_WARM_DATA

So finally, hot curseg locates in segnoA, but type of segnoA becomes
CURSEG_WARM_DATA.

Then if we invoke __f2fs_replace_block(blkaddrB, blkaddrA, true, false),
as blkaddrA locates in segnoA, so we will move warm type curseg to segnoA,
then change its summary cache and writeback it to summary block.

But segnoA is used by hot type curseg too, once it moves or persist, it
will cover summary block content with inner old summary cache, result in
inconsistent status.

This patch tries to fix this issue by introduce global curseg lock to avoid
race in between __f2fs_replace_block and change_curseg.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/segment.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e1d3a940d9f8..4109489afa14 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -820,6 +820,8 @@ struct f2fs_sm_info {
 	struct dirty_seglist_info *dirty_info;	/* dirty segment information */
 	struct curseg_info *curseg_array;	/* active segment information */
 
+	struct rw_semaphore curseg_lock;	/* for preventing curseg change */
+
 	block_t seg0_blkaddr;		/* block address of 0'th segment */
 	block_t main_blkaddr;		/* start block address of main area */
 	block_t ssa_blkaddr;		/* start block address of SSA area */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index eece3804c049..9a3a386155e8 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2549,6 +2549,8 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 
+	down_read(&SM_I(sbi)->curseg_lock);
+
 	mutex_lock(&curseg->curseg_mutex);
 	down_write(&sit_i->sentry_lock);
 
@@ -2606,6 +2608,8 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	}
 
 	mutex_unlock(&curseg->curseg_mutex);
+
+	up_read(&SM_I(sbi)->curseg_lock);
 }
 
 static void update_device_state(struct f2fs_io_info *fio)
@@ -2713,6 +2717,18 @@ int rewrite_data_page(struct f2fs_io_info *fio)
 	return err;
 }
 
+static inline int __f2fs_get_curseg(struct f2fs_sb_info *sbi,
+						unsigned int segno)
+{
+	int i;
+
+	for (i = CURSEG_HOT_DATA; i < NO_CHECK_TYPE; i++) {
+		if (CURSEG_I(sbi, i)->segno == segno)
+			break;
+	}
+	return i;
+}
+
 void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				block_t old_blkaddr, block_t new_blkaddr,
 				bool recover_curseg, bool recover_newaddr)
@@ -2728,6 +2744,8 @@ void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	se = get_seg_entry(sbi, segno);
 	type = se->type;
 
+	down_write(&SM_I(sbi)->curseg_lock);
+
 	if (!recover_curseg) {
 		/* for recovery flow */
 		if (se->valid_blocks == 0 && !IS_CURSEG(sbi, segno)) {
@@ -2737,8 +2755,13 @@ void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				type = CURSEG_WARM_DATA;
 		}
 	} else {
-		if (!IS_CURSEG(sbi, segno))
+		if (IS_CURSEG(sbi, segno)) {
+			/* se->type is volatile as SSR allocation */
+			type = __f2fs_get_curseg(sbi, segno);
+			f2fs_bug_on(sbi, type == NO_CHECK_TYPE);
+		} else {
 			type = CURSEG_WARM_DATA;
+		}
 	}
 
 	curseg = CURSEG_I(sbi, type);
@@ -2778,6 +2801,7 @@ void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 	up_write(&sit_i->sentry_lock);
 	mutex_unlock(&curseg->curseg_mutex);
+	up_write(&SM_I(sbi)->curseg_lock);
 }
 
 void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
@@ -3715,6 +3739,8 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 
 	INIT_LIST_HEAD(&sm_info->sit_entry_set);
 
+	init_rwsem(&sm_info->curseg_lock);
+
 	if (!f2fs_readonly(sbi->sb)) {
 		err = create_flush_cmd_control(sbi);
 		if (err)
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
