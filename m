From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v3 1/3] f2fs: introduce f2fs_replace_block() for reuse
Date: Wed, 06 May 2015 13:08:06 +0800
Message-ID: <004701d087ba$bdfbb180$39f31480$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Introduce a generic function replace_block base on recover_data_page,
and export it. So with it we can operate file's meta data which is in
CP/SSA area when we invoke fallocate with FALLOC_FL_COLLAPSE_RANGE
flag.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v3:
 * rename replace_block() to f2fs_replace_block() for readability.
 * fix incorrect usage of @recover_curseg in f2fs_replace_block().
 * recover old next blkaddr of current segment for fcollapse.

 fs/f2fs/f2fs.h     |  4 ++--
 fs/f2fs/recovery.c |  2 +-
 fs/f2fs/segment.c  | 31 ++++++++++++++++++++++++-------
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5fff184..160945f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1638,8 +1638,8 @@ void write_meta_page(struct f2fs_sb_info *, struct page *);
 void write_node_page(unsigned int, struct f2fs_io_info *);
 void write_data_page(struct dnode_of_data *, struct f2fs_io_info *);
 void rewrite_data_page(struct f2fs_io_info *);
-void recover_data_page(struct f2fs_sb_info *, struct page *,
-				struct f2fs_summary *, block_t, block_t);
+void f2fs_replace_block(struct f2fs_sb_info *, struct f2fs_summary *,
+					block_t, block_t, bool);
 void allocate_data_block(struct f2fs_sb_info *, struct page *,
 		block_t, block_t *, struct f2fs_summary *, int);
 void f2fs_wait_on_page_writeback(struct page *, enum page_type);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b80d9d4..f77a1be 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -412,7 +412,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 			set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
 
 			/* write dummy data page */
-			recover_data_page(sbi, NULL, &sum, src, dest);
+			f2fs_replace_block(sbi, &sum, src, dest, false);
 			dn.data_blkaddr = dest;
 			set_data_blkaddr(&dn);
 			f2fs_update_extent_cache(&dn);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 667bbf2..bdf487a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1279,32 +1279,41 @@ void rewrite_data_page(struct f2fs_io_info *fio)
 	f2fs_submit_page_mbio(fio);
 }
 
-void recover_data_page(struct f2fs_sb_info *sbi,
-			struct page *page, struct f2fs_summary *sum,
-			block_t old_blkaddr, block_t new_blkaddr)
+void f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
+				block_t old_blkaddr, block_t new_blkaddr,
+				bool recover_curseg)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg;
 	unsigned int segno, old_cursegno;
 	struct seg_entry *se;
 	int type;
+	unsigned short old_blkoff;
 
 	segno = GET_SEGNO(sbi, new_blkaddr);
 	se = get_seg_entry(sbi, segno);
 	type = se->type;
 
-	if (se->valid_blocks == 0 && !IS_CURSEG(sbi, segno)) {
-		if (old_blkaddr == NULL_ADDR)
-			type = CURSEG_COLD_DATA;
-		else
+	if (!recover_curseg) {
+		/* for recovery flow */
+		if (se->valid_blocks == 0 && !IS_CURSEG(sbi, segno)) {
+			if (old_blkaddr == NULL_ADDR)
+				type = CURSEG_COLD_DATA;
+			else
+				type = CURSEG_WARM_DATA;
+		}
+	} else {
+		if (!IS_CURSEG(sbi, segno))
 			type = CURSEG_WARM_DATA;
 	}
+
 	curseg = CURSEG_I(sbi, type);
 
 	mutex_lock(&curseg->curseg_mutex);
 	mutex_lock(&sit_i->sentry_lock);
 
 	old_cursegno = curseg->segno;
+	old_blkoff = curseg->next_blkoff;
 
 	/* change the current segment */
 	if (segno != curseg->segno) {
@@ -1318,6 +1327,14 @@ void recover_data_page(struct f2fs_sb_info *sbi,
 	refresh_sit_entry(sbi, old_blkaddr, new_blkaddr);
 	locate_dirty_segment(sbi, old_cursegno);
 
+	if (recover_curseg) {
+		if (old_cursegno != curseg->segno) {
+			curseg->next_segno = old_cursegno;
+			change_curseg(sbi, type, true);
+		}
+		curseg->next_blkoff = old_blkoff;
+	}
+
 	mutex_unlock(&sit_i->sentry_lock);
 	mutex_unlock(&curseg->curseg_mutex);
 }
-- 
2.3.3
