From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: use spinlock for segmap_lock instead of rwlock
Date: Wed, 11 Feb 2015 18:20:38 +0800
Message-ID: <000001d045e4$7ca0fe10$75e2fa30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

rwlock can provide better concurrency when there are much more readers than
writers because readers can hold the rwlock simultaneously.

But now, for segmap_lock rwlock in struct free_segmap_info, there is only one
reader 'mount' from below call path:
->f2fs_fill_super
  ->build_segment_manager
    ->build_dirty_segmap
      ->init_dirty_segmap
        ->find_next_inuse
          read_lock
          ...
          read_unlock

Now that our concurrency can not be improved since there is no other reader for
this lock, we do not need to use rwlock_t type for segmap_lock, let's replace it
with spinlock_t type.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/segment.c |  6 +++---
 fs/f2fs/segment.h | 18 +++++++++---------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c542f63..5a6c818 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -800,7 +800,7 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 	int go_left = 0;
 	int i;
 
-	write_lock(&free_i->segmap_lock);
+	spin_lock(&free_i->segmap_lock);
 
 	if (!new_sec && ((*newseg + 1) % sbi->segs_per_sec)) {
 		segno = find_next_zero_bit(free_i->free_segmap,
@@ -873,7 +873,7 @@ got_it:
 	f2fs_bug_on(sbi, test_bit(segno, free_i->free_segmap));
 	__set_inuse(sbi, segno);
 	*newseg = segno;
-	write_unlock(&free_i->segmap_lock);
+	spin_unlock(&free_i->segmap_lock);
 }
 
 static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
@@ -1920,7 +1920,7 @@ static int build_free_segmap(struct f2fs_sb_info *sbi)
 	free_i->start_segno = GET_SEGNO_FROM_SEG0(sbi, MAIN_BLKADDR(sbi));
 	free_i->free_segments = 0;
 	free_i->free_sections = 0;
-	rwlock_init(&free_i->segmap_lock);
+	spin_lock_init(&free_i->segmap_lock);
 	return 0;
 }
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 421d579..9002df1 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -207,7 +207,7 @@ struct free_segmap_info {
 	unsigned int start_segno;	/* start segment number logically */
 	unsigned int free_segments;	/* # of free segments */
 	unsigned int free_sections;	/* # of free sections */
-	rwlock_t segmap_lock;		/* free segmap lock */
+	spinlock_t segmap_lock;		/* free segmap lock */
 	unsigned long *free_segmap;	/* free segment bitmap */
 	unsigned long *free_secmap;	/* free section bitmap */
 };
@@ -318,9 +318,9 @@ static inline unsigned int find_next_inuse(struct free_segmap_info *free_i,
 		unsigned int max, unsigned int segno)
 {
 	unsigned int ret;
-	read_lock(&free_i->segmap_lock);
+	spin_lock(&free_i->segmap_lock);
 	ret = find_next_bit(free_i->free_segmap, max, segno);
-	read_unlock(&free_i->segmap_lock);
+	spin_unlock(&free_i->segmap_lock);
 	return ret;
 }
 
@@ -331,7 +331,7 @@ static inline void __set_free(struct f2fs_sb_info *sbi, unsigned int segno)
 	unsigned int start_segno = secno * sbi->segs_per_sec;
 	unsigned int next;
 
-	write_lock(&free_i->segmap_lock);
+	spin_lock(&free_i->segmap_lock);
 	clear_bit(segno, free_i->free_segmap);
 	free_i->free_segments++;
 
@@ -340,7 +340,7 @@ static inline void __set_free(struct f2fs_sb_info *sbi, unsigned int segno)
 		clear_bit(secno, free_i->free_secmap);
 		free_i->free_sections++;
 	}
-	write_unlock(&free_i->segmap_lock);
+	spin_unlock(&free_i->segmap_lock);
 }
 
 static inline void __set_inuse(struct f2fs_sb_info *sbi,
@@ -362,7 +362,7 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
 	unsigned int start_segno = secno * sbi->segs_per_sec;
 	unsigned int next;
 
-	write_lock(&free_i->segmap_lock);
+	spin_lock(&free_i->segmap_lock);
 	if (test_and_clear_bit(segno, free_i->free_segmap)) {
 		free_i->free_segments++;
 
@@ -373,7 +373,7 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
 				free_i->free_sections++;
 		}
 	}
-	write_unlock(&free_i->segmap_lock);
+	spin_unlock(&free_i->segmap_lock);
 }
 
 static inline void __set_test_and_inuse(struct f2fs_sb_info *sbi,
@@ -381,13 +381,13 @@ static inline void __set_test_and_inuse(struct f2fs_sb_info *sbi,
 {
 	struct free_segmap_info *free_i = FREE_I(sbi);
 	unsigned int secno = segno / sbi->segs_per_sec;
-	write_lock(&free_i->segmap_lock);
+	spin_lock(&free_i->segmap_lock);
 	if (!test_and_set_bit(segno, free_i->free_segmap)) {
 		free_i->free_segments--;
 		if (!test_and_set_bit(secno, free_i->free_secmap))
 			free_i->free_sections--;
 	}
-	write_unlock(&free_i->segmap_lock);
+	spin_unlock(&free_i->segmap_lock);
 }
 
 static inline void get_sit_bitmap(struct f2fs_sb_info *sbi,
-- 
2.2.2
