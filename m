From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 5/5] f2fs: do not __punch_discard_cmd in lfs mode
Date: Thu, 12 Jul 2018 23:09:30 +0800
Message-ID: <1531408170-45758-6-git-send-email-yunlong.song@huawei.com>
References: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yunlong.song@huawei.com>) id 1fddF6-0005LY-O7
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Jul 2018 15:10:52 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fddF4-007Asf-Kr
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Jul 2018 15:10:52 +0000
In-Reply-To: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, miaoxie@huawei.com

In lfs mode, it is better to submit and wait for discard of the
new_blkaddr's overall section, rather than punch it which makes
more small discards and is not friendly with flash alignment. And
f2fs does not have to wait discard of each new_blkaddr except for the
start_block of each section with this patch.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/f2fs/segment.h |  7 ++++-
 2 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f6c20e0..bce321a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -893,7 +893,19 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
 static void f2fs_submit_discard_endio(struct bio *bio)
 {
 	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(dc->bdev->bd_super);
 
+	if (test_opt(sbi, LFS)) {
+		unsigned int segno = GET_SEGNO(sbi, dc->lstart);
+		unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
+		int cnt = (dc->len >> sbi->log_blocks_per_seg) /
+				sbi->segs_per_sec;
+
+		while (cnt--) {
+			set_bit(secno, FREE_I(sbi)->discard_secmap);
+			secno++;
+		}
+	}
 	dc->error = blk_status_to_errno(bio->bi_status);
 	dc->state = D_DONE;
 	complete_all(&dc->wait);
@@ -1349,8 +1361,15 @@ static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 	dc = (struct discard_cmd *)f2fs_lookup_rb_tree(&dcc->root,
 							NULL, blkaddr);
 	if (dc) {
-		if (dc->state == D_PREP) {
+		if (dc->state == D_PREP && !test_opt(sbi, LFS))
 			__punch_discard_cmd(sbi, dc, blkaddr);
+		else if (dc->state == D_PREP && test_opt(sbi, LFS)) {
+			struct discard_policy dpolicy;
+
+			__init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE, 1);
+			__submit_discard_cmd(sbi, &dpolicy, dc);
+			dc->ref++;
+			need_wait = true;
 		} else {
 			dc->ref++;
 			need_wait = true;
@@ -2071,9 +2090,10 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 	unsigned int hint = GET_SEC_FROM_SEG(sbi, *newseg);
 	unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
 	unsigned int left_start = hint;
-	bool init = true;
+	bool init = true, check_discard = test_opt(sbi, LFS) ? true : false;
 	int go_left = 0;
 	int i;
+	unsigned long *free_secmap;
 
 	spin_lock(&free_i->segmap_lock);
 
@@ -2084,11 +2104,25 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 			goto got_it;
 	}
 find_other_zone:
-	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
+	if (check_discard) {
+		int entries = f2fs_bitmap_size(MAIN_SECS(sbi)) / sizeof(unsigned long);
+
+		free_secmap = free_i->tmp_secmap;
+		for (i = 0; i < entries; i++)
+			free_secmap[i] = (!(free_i->free_secmap[i] ^
+				free_i->discard_secmap[i])) | free_i->free_secmap[i];
+	} else
+		free_secmap = free_i->free_secmap;
+
+	secno = find_next_zero_bit(free_secmap, MAIN_SECS(sbi), hint);
 	if (secno >= MAIN_SECS(sbi)) {
 		if (dir == ALLOC_RIGHT) {
-			secno = find_next_zero_bit(free_i->free_secmap,
+			secno = find_next_zero_bit(free_secmap,
 							MAIN_SECS(sbi), 0);
+			if (secno >= MAIN_SECS(sbi) && check_discard) {
+				check_discard = false;
+				goto find_other_zone;
+			}
 			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
 		} else {
 			go_left = 1;
@@ -2098,13 +2132,17 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 	if (go_left == 0)
 		goto skip_left;
 
-	while (test_bit(left_start, free_i->free_secmap)) {
+	while (test_bit(left_start, free_secmap)) {
 		if (left_start > 0) {
 			left_start--;
 			continue;
 		}
-		left_start = find_next_zero_bit(free_i->free_secmap,
+		left_start = find_next_zero_bit(free_secmap,
 							MAIN_SECS(sbi), 0);
+		if (left_start >= MAIN_SECS(sbi) && check_discard) {
+			check_discard = false;
+			goto find_other_zone;
+		}
 		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
 		break;
 	}
@@ -2719,7 +2757,18 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 
 	*new_blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
 
-	f2fs_wait_discard_bio(sbi, *new_blkaddr);
+	if (test_opt(sbi, LFS)) {
+		unsigned int start_segno, secno;
+
+		secno = GET_SEC_FROM_SEG(sbi, curseg->segno);
+		start_segno = secno * sbi->segs_per_sec;
+		if (*new_blkaddr == START_BLOCK(sbi, start_segno) &&
+				!test_bit(secno, FREE_I(sbi)->discard_secmap))
+			f2fs_wait_discard_bio(sbi, *new_blkaddr);
+		f2fs_bug_on(sbi, !test_bit(secno, FREE_I(sbi)->discard_secmap));
+	}
+	else
+		f2fs_wait_discard_bio(sbi, *new_blkaddr);
 
 	/*
 	 * __add_sum_entry should be resided under the curseg_mutex
@@ -3648,10 +3697,21 @@ static int build_free_segmap(struct f2fs_sb_info *sbi)
 	if (!free_i->free_secmap)
 		return -ENOMEM;
 
+	free_i->discard_secmap = f2fs_kvmalloc(sbi, sec_bitmap_size, GFP_KERNEL);
+	if (!free_i->discard_secmap)
+		return -ENOMEM;
+
+	free_i->tmp_secmap = f2fs_kvmalloc(sbi, sec_bitmap_size, GFP_KERNEL);
+	if (!free_i->tmp_secmap)
+		return -ENOMEM;
+
 	/* set all segments as dirty temporarily */
 	memset(free_i->free_segmap, 0xff, bitmap_size);
 	memset(free_i->free_secmap, 0xff, sec_bitmap_size);
 
+	/* set all sections as discarded temporarily */
+	memset(free_i->discard_secmap, 0xff, sec_bitmap_size);
+
 	/* init free segmap information */
 	free_i->start_segno = GET_SEGNO_FROM_SEG0(sbi, MAIN_BLKADDR(sbi));
 	free_i->free_segments = 0;
@@ -4047,6 +4107,8 @@ static void destroy_free_segmap(struct f2fs_sb_info *sbi)
 	SM_I(sbi)->free_info = NULL;
 	kvfree(free_i->free_segmap);
 	kvfree(free_i->free_secmap);
+	kvfree(free_i->discard_secmap);
+	kvfree(free_i->tmp_secmap);
 	kfree(free_i);
 }
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5049551..b37a909 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -259,6 +259,8 @@ struct free_segmap_info {
 	spinlock_t segmap_lock;		/* free segmap lock */
 	unsigned long *free_segmap;	/* free segment bitmap */
 	unsigned long *free_secmap;	/* free section bitmap */
+	unsigned long *discard_secmap;	/* discard section bitmap */
+	unsigned long *tmp_secmap;	/* bitmap for temporal use */
 };
 
 /* Notice: The order of dirty type is same with CURSEG_XXX in f2fs.h */
@@ -453,8 +455,11 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
 		next = find_next_bit(free_i->free_segmap,
 				start_segno + sbi->segs_per_sec, start_segno);
 		if (next >= start_segno + sbi->segs_per_sec) {
-			if (test_and_clear_bit(secno, free_i->free_secmap))
+			if (test_and_clear_bit(secno, free_i->free_secmap)) {
 				free_i->free_sections++;
+				if (test_opt(sbi, LFS))
+					clear_bit(secno, free_i->discard_secmap);
+			}
 		}
 	}
 skip_free:
-- 
1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
