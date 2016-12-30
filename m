From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 08/10] f2fs: relax async discard commands more
Date: Fri, 30 Dec 2016 10:51:15 -0800
Message-ID: <20161230185117.3832-8-jaegeuk@kernel.org>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cN2HB-000377-I6
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Dec 2016 18:51:37 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cN2HA-0004hK-J3
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Dec 2016 18:51:37 +0000
In-Reply-To: <20161230185117.3832-1-jaegeuk@kernel.org>
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

This patch relaxes async discard commands to avoid waiting its end_io during
checkpoint.
Instead of waiting them during checkpoint, it will be done when actually reusing
them.

Test on initial partition of nvme drive.

 # time fstrim /mnt/test

Before : 6.158s
After : 4.822s

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  3 ---
 fs/f2fs/f2fs.h       |  4 +++-
 fs/f2fs/segment.c    | 25 +++++++++++++++++++++----
 fs/f2fs/super.c      |  3 +++
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 34bfe2b494ae..1a9ba69a22ba 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1254,7 +1254,6 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		f2fs_bug_on(sbi, prefree_segments(sbi));
 		flush_sit_entries(sbi, cpc);
 		clear_prefree_segments(sbi, cpc);
-		f2fs_wait_all_discard_bio(sbi);
 		unblock_operations(sbi);
 		goto out;
 	}
@@ -1278,8 +1277,6 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	else
 		clear_prefree_segments(sbi, cpc);
 
-	f2fs_wait_all_discard_bio(sbi);
-
 	unblock_operations(sbi);
 	stat_inc_cp_count(sbi->stat_info);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bdcfe2a9b532..f2f40fce9d31 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -183,6 +183,8 @@ struct discard_entry {
 
 struct bio_entry {
 	struct list_head list;
+	unsigned int start_segno;
+	unsigned int end_segno;
 	struct bio *bio;
 	struct completion event;
 	int error;
@@ -2111,7 +2113,7 @@ void destroy_flush_cmd_control(struct f2fs_sb_info *, bool);
 void invalidate_blocks(struct f2fs_sb_info *, block_t);
 bool is_checkpointed_data(struct f2fs_sb_info *, block_t);
 void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
-void f2fs_wait_all_discard_bio(struct f2fs_sb_info *);
+void f2fs_wait_discard_bio(struct f2fs_sb_info *, unsigned int);
 void clear_prefree_segments(struct f2fs_sb_info *, struct cp_control *);
 void release_discard_addrs(struct f2fs_sb_info *);
 int npages_for_summary_flush(struct f2fs_sb_info *, bool);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6d197f0c8151..9a38424c3c1f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -624,20 +624,24 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 }
 
 static struct bio_entry *__add_bio_entry(struct f2fs_sb_info *sbi,
-							struct bio *bio)
+			struct bio *bio, unsigned int start_segno,
+					unsigned int end_segno)
 {
 	struct list_head *wait_list = &(SM_I(sbi)->wait_list);
 	struct bio_entry *be = f2fs_kmem_cache_alloc(bio_entry_slab, GFP_NOFS);
 
 	INIT_LIST_HEAD(&be->list);
 	be->bio = bio;
+	be->start_segno = start_segno;
+	be->end_segno = end_segno;
 	init_completion(&be->event);
 	list_add_tail(&be->list, wait_list);
 
 	return be;
 }
 
-void f2fs_wait_all_discard_bio(struct f2fs_sb_info *sbi)
+/* This should be covered by global mutex, &sit_i->sentry_lock */
+void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	struct list_head *wait_list = &(SM_I(sbi)->wait_list);
 	struct bio_entry *be, *tmp;
@@ -646,7 +650,15 @@ void f2fs_wait_all_discard_bio(struct f2fs_sb_info *sbi)
 		struct bio *bio = be->bio;
 		int err;
 
-		wait_for_completion_io(&be->event);
+		if (!completion_done(&be->event)) {
+			if ((be->start_segno >= segno &&
+					be->end_segno <= segno) ||
+					segno == NULL_SEGNO)
+				wait_for_completion_io(&be->event);
+			else
+				continue;
+		}
+
 		err = be->error;
 		if (err == -EOPNOTSUPP)
 			err = 0;
@@ -674,6 +686,8 @@ static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
 		struct block_device *bdev, block_t blkstart, block_t blklen)
 {
 	struct bio *bio = NULL;
+	unsigned int start_segno = GET_SEGNO(sbi, blkstart);
+	unsigned int end_segno = GET_SEGNO(sbi, blkstart + blklen);
 	int err;
 
 	trace_f2fs_issue_discard(sbi->sb, blkstart, blklen);
@@ -688,7 +702,8 @@ static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
 				SECTOR_FROM_BLOCK(blklen),
 				GFP_NOFS, 0, &bio);
 	if (!err && bio) {
-		struct bio_entry *be = __add_bio_entry(sbi, bio);
+		struct bio_entry *be = __add_bio_entry(sbi, bio,
+					start_segno, end_segno);
 
 		bio->bi_private = be;
 		bio->bi_end_io = f2fs_submit_bio_wait_endio;
@@ -1574,6 +1589,8 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 
 	*new_blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
 
+	f2fs_wait_discard_bio(sbi, GET_SEGNO(sbi, *new_blkaddr));
+
 	/*
 	 * __add_sum_entry should be resided under the curseg_mutex
 	 * because, this function updates a summary entry in the
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f3697f97e527..16e2bc5209bb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -770,6 +770,9 @@ static void f2fs_put_super(struct super_block *sb)
 		write_checkpoint(sbi, &cpc);
 	}
 
+	/* be sure to wait for any on-going discard commands */
+	f2fs_wait_discard_bio(sbi, NULL_SEGNO);
+
 	/* write_checkpoint can update stat informaion */
 	f2fs_destroy_stats(sbi);
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
