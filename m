From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 01/11] f2fs: reuse room_for_filename for inline dentry operation
Date: Sun, 19 Oct 2014 22:19:29 -0700
Message-ID: <1413782379-11758-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduces to reuse the existing room_for_filename for inline dentry
operation.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c    | 21 +++++++++------------
 fs/f2fs/f2fs.h   |  1 +
 fs/f2fs/inline.c | 27 ++-------------------------
 3 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index cc6474a..164c6c9 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -427,27 +427,23 @@ void update_parent_metadata(struct inode *dir, struct inode *inode,
 		clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
 }
 
-static int room_for_filename(struct f2fs_dentry_block *dentry_blk, int slots)
+int room_for_filename(const void *bitmap, int slots, int max_slots)
 {
 	int bit_start = 0;
 	int zero_start, zero_end;
 next:
-	zero_start = find_next_zero_bit_le(&dentry_blk->dentry_bitmap,
-						NR_DENTRY_IN_BLOCK,
-						bit_start);
-	if (zero_start >= NR_DENTRY_IN_BLOCK)
-		return NR_DENTRY_IN_BLOCK;
+	zero_start = find_next_zero_bit_le(bitmap, max_slots, bit_start);
+	if (zero_start >= max_slots)
+		return max_slots;
 
-	zero_end = find_next_bit_le(&dentry_blk->dentry_bitmap,
-						NR_DENTRY_IN_BLOCK,
-						zero_start);
+	zero_end = find_next_bit_le(bitmap, max_slots, zero_start);
 	if (zero_end - zero_start >= slots)
 		return zero_start;
 
 	bit_start = zero_end + 1;
 
-	if (zero_end + 1 >= NR_DENTRY_IN_BLOCK)
-		return NR_DENTRY_IN_BLOCK;
+	if (zero_end + 1 >= max_slots)
+		return max_slots;
 	goto next;
 }
 
@@ -509,7 +505,8 @@ start:
 			return PTR_ERR(dentry_page);
 
 		dentry_blk = kmap(dentry_page);
-		bit_pos = room_for_filename(dentry_blk, slots);
+		bit_pos = room_for_filename(&dentry_blk->dentry_bitmap,
+						slots, NR_DENTRY_IN_BLOCK);
 		if (bit_pos < NR_DENTRY_IN_BLOCK)
 			goto add_dentry;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c537699..aa055e3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1248,6 +1248,7 @@ void set_de_type(struct f2fs_dir_entry *, struct inode *);
 struct page *init_inode_metadata(struct inode *, struct inode *,
 							const struct qstr *);
 void update_parent_metadata(struct inode *, struct inode *, unsigned int);
+int room_for_filename(const void *, int, int);
 void f2fs_drop_nlink(struct inode *, struct inode *, struct page *);
 struct f2fs_dir_entry *f2fs_find_entry(struct inode *, struct qstr *,
 							struct page **);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 02e2449..5d9dabb 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -363,30 +363,6 @@ int make_empty_inline_dir(struct inode *inode, struct inode *parent,
 	return 0;
 }
 
-int room_in_inline_dir(struct f2fs_inline_dentry *dentry_blk, int slots)
-{
-	int bit_start = 0;
-	int zero_start, zero_end;
-next:
-	zero_start = find_next_zero_bit_le(&dentry_blk->dentry_bitmap,
-						NR_INLINE_DENTRY,
-						bit_start);
-	if (zero_start >= NR_INLINE_DENTRY)
-		return NR_INLINE_DENTRY;
-
-	zero_end = find_next_bit_le(&dentry_blk->dentry_bitmap,
-						NR_INLINE_DENTRY,
-						zero_start);
-	if (zero_end - zero_start >= slots)
-		return zero_start;
-
-	bit_start = zero_end + 1;
-
-	if (zero_end + 1 >= NR_INLINE_DENTRY)
-		return NR_INLINE_DENTRY;
-	goto next;
-}
-
 int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
 				struct f2fs_inline_dentry *inline_dentry)
 {
@@ -462,7 +438,8 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
 		return PTR_ERR(ipage);
 
 	dentry_blk = inline_data_addr(ipage);
-	bit_pos = room_in_inline_dir(dentry_blk, slots);
+	bit_pos = room_for_filename(&dentry_blk->dentry_bitmap,
+						slots, NR_INLINE_DENTRY);
 	if (bit_pos >= NR_INLINE_DENTRY) {
 		err = f2fs_convert_inline_dir(dir, ipage, dentry_blk);
 		if (!err)
-- 
2.1.1
