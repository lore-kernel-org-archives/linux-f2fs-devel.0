From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: add fast path for find_next_{zero}bit
Date: Thu, 20 Oct 2016 19:28:45 -0700
Message-ID: <20161021022847.55629-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bxPZr-0003Mn-9v
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Oct 2016 02:28:59 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bxPZp-0002oT-T1
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Oct 2016 02:28:59 +0000
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

This patch adds checking the first two bits when searching zero or one bits to
avoid costly find_next_{zero}bit operations.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c     | 10 +++++-----
 fs/f2fs/f2fs.h    | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/gc.c      |  3 ++-
 fs/f2fs/inline.c  |  2 +-
 fs/f2fs/segment.c | 14 ++++++++------
 fs/f2fs/segment.h | 11 ++++++-----
 6 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 5f5678e..f3a4fce 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -480,11 +480,11 @@ int room_for_filename(const void *bitmap, int slots, int max_slots)
 	int bit_start = 0;
 	int zero_start, zero_end;
 next:
-	zero_start = find_next_zero_bit_le(bitmap, max_slots, bit_start);
+	zero_start = f2fs_find_next_zero_bit_le(bitmap, max_slots, bit_start);
 	if (zero_start >= max_slots)
 		return max_slots;
 
-	zero_end = find_next_bit_le(bitmap, max_slots, zero_start);
+	zero_end = f2fs_find_next_bit_le(bitmap, max_slots, zero_start);
 	if (zero_end - zero_start >= slots)
 		return zero_start;
 
@@ -724,7 +724,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		clear_bit_le(bit_pos + i, &dentry_blk->dentry_bitmap);
 
 	/* Let's check and deallocate this dentry page */
-	bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
+	bit_pos = f2fs_find_next_bit_le(&dentry_blk->dentry_bitmap,
 			NR_DENTRY_IN_BLOCK,
 			0);
 	kunmap(page); /* kunmap - pair of f2fs_find_entry */
@@ -772,7 +772,7 @@ bool f2fs_empty_dir(struct inode *dir)
 			bit_pos = 2;
 		else
 			bit_pos = 0;
-		bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
+		bit_pos = f2fs_find_next_bit_le(&dentry_blk->dentry_bitmap,
 						NR_DENTRY_IN_BLOCK,
 						bit_pos);
 		kunmap_atomic(dentry_blk);
@@ -796,7 +796,7 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 	bit_pos = ((unsigned long)ctx->pos % d->max);
 
 	while (bit_pos < d->max) {
-		bit_pos = find_next_bit_le(d->bitmap, d->max, bit_pos);
+		bit_pos = f2fs_find_next_bit_le(d->bitmap, d->max, bit_pos);
 		if (bit_pos >= d->max)
 			break;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e6d057c..168f939 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1912,6 +1912,54 @@ static inline void *f2fs_kvzalloc(size_t size, gfp_t flags)
 	return ret;
 }
 
+static inline unsigned long f2fs_find_next_zero_bit_le(const void *addr,
+		unsigned long size, unsigned long offset)
+{
+	if (!test_bit_le(offset, addr))
+		return offset;
+	if (offset + 1 >= size)
+		return size;
+	if (!test_bit_le(offset + 1, addr))
+		return offset + 1;
+	return find_next_zero_bit_le(addr, size, offset + 2);
+}
+
+static inline unsigned long f2fs_find_next_bit_le(const void *addr,
+		unsigned long size, unsigned long offset)
+{
+	if (test_bit_le(offset, addr))
+		return offset;
+	if (offset + 1 >= size)
+		return size;
+	if (test_bit_le(offset + 1, addr))
+		return offset + 1;
+	return find_next_bit_le(addr, size, offset + 2);
+}
+
+static inline unsigned long f2fs_find_next_zero_bit(const void *addr,
+		unsigned long size, unsigned long offset)
+{
+	if (!test_bit(offset, addr))
+		return offset;
+	if (offset + 1 >= size)
+		return size;
+	if (!test_bit(offset + 1, addr))
+		return offset + 1;
+	return find_next_zero_bit(addr, size, offset + 2);
+}
+
+static inline unsigned long f2fs_find_next_bit(const void *addr,
+		unsigned long size, unsigned long offset)
+{
+	if (test_bit(offset, addr))
+		return offset;
+	if (offset + 1 >= size)
+		return size;
+	if (test_bit(offset + 1, addr))
+		return offset + 1;
+	return find_next_bit(addr, size, offset + 2);
+}
+
 #define get_inode_mode(i) \
 	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 9c18917..f35fca5 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -301,7 +301,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 		unsigned long cost;
 		unsigned int segno;
 
-		segno = find_next_bit(p.dirty_segmap, last_segment, p.offset);
+		segno = f2fs_find_next_bit(p.dirty_segmap, last_segment,
+								p.offset);
 		if (segno >= last_segment) {
 			if (sbi->last_victim[p.gc_mode]) {
 				last_segment = sbi->last_victim[p.gc_mode];
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 8cab5df..def731a 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -593,7 +593,7 @@ bool f2fs_empty_inline_dir(struct inode *dir)
 		return false;
 
 	dentry_blk = inline_data_addr(ipage);
-	bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
+	bit_pos = f2fs_find_next_bit_le(&dentry_blk->dentry_bitmap,
 					NR_INLINE_DENTRY,
 					bit_pos);
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bbb9355..0d70155 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -785,10 +785,11 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	while (1) {
 		int i;
-		start = find_next_bit(prefree_map, MAIN_SEGS(sbi), end + 1);
+		start = f2fs_find_next_bit(prefree_map, MAIN_SEGS(sbi),
+								end + 1);
 		if (start >= MAIN_SEGS(sbi))
 			break;
-		end = find_next_zero_bit(prefree_map, MAIN_SEGS(sbi),
+		end = f2fs_find_next_zero_bit(prefree_map, MAIN_SEGS(sbi),
 								start + 1);
 
 		for (i = start; i < end; i++)
@@ -1078,16 +1079,17 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 	spin_lock(&free_i->segmap_lock);
 
 	if (!new_sec && ((*newseg + 1) % sbi->segs_per_sec)) {
-		segno = find_next_zero_bit(free_i->free_segmap,
+		segno = f2fs_find_next_zero_bit(free_i->free_segmap,
 				(hint + 1) * sbi->segs_per_sec, *newseg + 1);
 		if (segno < (hint + 1) * sbi->segs_per_sec)
 			goto got_it;
 	}
 find_other_zone:
-	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
+	secno = f2fs_find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi),
+								hint);
 	if (secno >= MAIN_SECS(sbi)) {
 		if (dir == ALLOC_RIGHT) {
-			secno = find_next_zero_bit(free_i->free_secmap,
+			secno = f2fs_find_next_zero_bit(free_i->free_secmap,
 							MAIN_SECS(sbi), 0);
 			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
 		} else {
@@ -1103,7 +1105,7 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 			left_start--;
 			continue;
 		}
-		left_start = find_next_zero_bit(free_i->free_secmap,
+		left_start = f2fs_find_next_zero_bit(free_i->free_secmap,
 							MAIN_SECS(sbi), 0);
 		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
 		break;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index d8ff069..fb58925 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -336,7 +336,7 @@ static inline unsigned int find_next_inuse(struct free_segmap_info *free_i,
 {
 	unsigned int ret;
 	spin_lock(&free_i->segmap_lock);
-	ret = find_next_bit(free_i->free_segmap, max, segno);
+	ret = f2fs_find_next_bit(free_i->free_segmap, max, segno);
 	spin_unlock(&free_i->segmap_lock);
 	return ret;
 }
@@ -352,7 +352,7 @@ static inline void __set_free(struct f2fs_sb_info *sbi, unsigned int segno)
 	clear_bit(segno, free_i->free_segmap);
 	free_i->free_segments++;
 
-	next = find_next_bit(free_i->free_segmap,
+	next = f2fs_find_next_bit(free_i->free_segmap,
 			start_segno + sbi->segs_per_sec, start_segno);
 	if (next >= start_segno + sbi->segs_per_sec) {
 		clear_bit(secno, free_i->free_secmap);
@@ -384,7 +384,7 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
 	if (test_and_clear_bit(segno, free_i->free_segmap)) {
 		free_i->free_segments++;
 
-		next = find_next_bit(free_i->free_segmap,
+		next = f2fs_find_next_bit(free_i->free_segmap,
 				start_segno + sbi->segs_per_sec, start_segno);
 		if (next >= start_segno + sbi->segs_per_sec) {
 			if (test_and_clear_bit(secno, free_i->free_secmap))
@@ -607,12 +607,13 @@ static inline void check_block_count(struct f2fs_sb_info *sbi,
 	/* check bitmap with valid block count */
 	do {
 		if (is_valid) {
-			next_pos = find_next_zero_bit_le(&raw_sit->valid_map,
+			next_pos = f2fs_find_next_zero_bit_le(
+					&raw_sit->valid_map,
 					sbi->blocks_per_seg,
 					cur_pos);
 			valid_blocks += next_pos - cur_pos;
 		} else
-			next_pos = find_next_bit_le(&raw_sit->valid_map,
+			next_pos = f2fs_find_next_bit_le(&raw_sit->valid_map,
 					sbi->blocks_per_seg,
 					cur_pos);
 		cur_pos = next_pos;
-- 
2.8.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
