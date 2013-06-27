From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 1/2] f2fs: remove reusing any prefree segments
Date: Thu, 27 Jun 2013 13:17:27 +0900
Message-ID: <1372306648-26438-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Us3eN-0005iB-LZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Jun 2013 04:17:39 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Us3eJ-000312-QH for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Jun 2013 04:17:39 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MP100626AL5C730@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Jun 2013 13:17:29 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch removes check_prefree_segments initially designed to enhance the
performance by narrowing the range of LBA usage across the whole block device.

When allocating a new segment, previous f2fs tries to find proper prefree
segments, and then, if finds a segment, it reuses the segment for further
data or node block allocation.

However, I found that this was totally wrong approach since the prefree segments
have several data or node blocks that will be used by the roll-forward mechanism
operated after sudden-power-off.

Let's assume the following scenario.

/* write 8MB with fsync */
for (i = 0; i < 2048; i++) {
	offset = i * 4096;
	write(fd, offset, 4KB);
	fsync(fd);
}

In this case, naive segment allocation sequence will be like:
 data segment: x, x+1, x+2, x+3
 node segment: y, y+1, y+2, y+3.

But, if we can reuse prefree segments, the sequence can be like:
 data segment: x, x+1, y, y+1
 node segment: y, y+1, y+2, y+3.
Because, y, y+1, and y+2 became prefree segments one by one, and those are
reused by data allocation.

After conducting this workload, we should consider how to recover the latest
inode with its data.
If we reuse the prefree segments such as y or y+1, we lost the old node blocks
so that f2fs even cannot start roll-forward recovery.

Therefore, I suggest that we should remove reusing prefree segments.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/segment.c | 56 +------------------------------------------------------
 1 file changed, 1 insertion(+), 55 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3ac4d29..a86d125 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -309,56 +309,6 @@ static void write_sum_page(struct f2fs_sb_info *sbi,
 	f2fs_put_page(page, 1);
 }
 
-static unsigned int check_prefree_segments(struct f2fs_sb_info *sbi, int type)
-{
-	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
-	unsigned long *prefree_segmap = dirty_i->dirty_segmap[PRE];
-	unsigned int segno;
-	unsigned int ofs = 0;
-
-	/*
-	 * If there is not enough reserved sections,
-	 * we should not reuse prefree segments.
-	 */
-	if (has_not_enough_free_secs(sbi, 0))
-		return NULL_SEGNO;
-
-	/*
-	 * NODE page should not reuse prefree segment,
-	 * since those information is used for SPOR.
-	 */
-	if (IS_NODESEG(type))
-		return NULL_SEGNO;
-next:
-	segno = find_next_bit(prefree_segmap, TOTAL_SEGS(sbi), ofs);
-	ofs += sbi->segs_per_sec;
-
-	if (segno < TOTAL_SEGS(sbi)) {
-		int i;
-
-		/* skip intermediate segments in a section */
-		if (segno % sbi->segs_per_sec)
-			goto next;
-
-		/* skip if the section is currently used */
-		if (sec_usage_check(sbi, GET_SECNO(sbi, segno)))
-			goto next;
-
-		/* skip if whole section is not prefree */
-		for (i = 1; i < sbi->segs_per_sec; i++)
-			if (!test_bit(segno + i, prefree_segmap))
-				goto next;
-
-		/* skip if whole section was not free at the last checkpoint */
-		for (i = 0; i < sbi->segs_per_sec; i++)
-			if (get_seg_entry(sbi, segno + i)->ckpt_valid_blocks)
-				goto next;
-
-		return segno;
-	}
-	return NULL_SEGNO;
-}
-
 static int is_next_segment_free(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
@@ -597,11 +547,7 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 		goto out;
 	}
 
-	curseg->next_segno = check_prefree_segments(sbi, type);
-
-	if (curseg->next_segno != NULL_SEGNO)
-		change_curseg(sbi, type, false);
-	else if (type == CURSEG_WARM_NODE)
+	if (type == CURSEG_WARM_NODE)
 		new_curseg(sbi, type, false);
 	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type))
 		new_curseg(sbi, type, false);
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
