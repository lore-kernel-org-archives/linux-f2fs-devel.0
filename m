From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 19/19] f2fs: issue discard with finally produced
	len and minlen
Date: Fri,  1 May 2015 17:48:46 -0700
Message-ID: <1430527726-68547-19-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YoLd3-0001hA-4B
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:50:01 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YoLd2-0000q6-3i for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:50:01 +0000
In-Reply-To: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
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

This patch determines to issue discard commands by comparing given minlen and
the length of produced final candidates.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/segment.c    | 10 ++++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d076e7e..1da20a6 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1043,7 +1043,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	if (unlikely(f2fs_cp_error(sbi)))
 		return;
 
-	clear_prefree_segments(sbi);
+	clear_prefree_segments(sbi, cpc);
 	clear_sbi_flag(sbi, SBI_IS_DIRTY);
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 98fc719..0b8c454 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1628,7 +1628,7 @@ int create_flush_cmd_control(struct f2fs_sb_info *);
 void destroy_flush_cmd_control(struct f2fs_sb_info *);
 void invalidate_blocks(struct f2fs_sb_info *, block_t);
 void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
-void clear_prefree_segments(struct f2fs_sb_info *);
+void clear_prefree_segments(struct f2fs_sb_info *, struct cp_control *);
 void release_discard_addrs(struct f2fs_sb_info *);
 void discard_next_dnode(struct f2fs_sb_info *, block_t);
 int npages_for_summary_flush(struct f2fs_sb_info *, bool);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5a4ec01..667bbf2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -597,7 +597,7 @@ static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
 	mutex_unlock(&dirty_i->seglist_lock);
 }
 
-void clear_prefree_segments(struct f2fs_sb_info *sbi)
+void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct list_head *head = &(SM_I(sbi)->discard_list);
 	struct discard_entry *entry, *this;
@@ -630,7 +630,10 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi)
 
 	/* send small discards */
 	list_for_each_entry_safe(entry, this, head, list) {
+		if (cpc->reason == CP_DISCARD && entry->len < cpc->trim_minlen)
+			goto skip;
 		f2fs_issue_discard(sbi, entry->blkaddr, entry->len);
+skip:
 		list_del(&entry->list);
 		SM_I(sbi)->nr_discards -= entry->len;
 		kmem_cache_free(discard_entry_slab, entry);
@@ -1072,8 +1075,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	unsigned int start_segno, end_segno;
 	struct cp_control cpc;
 
-	if (range->minlen > SEGMENT_SIZE(sbi) || start >= MAX_BLKADDR(sbi) ||
-						range->len < sbi->blocksize)
+	if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
 		return -EINVAL;
 
 	cpc.trimmed = 0;
@@ -1085,7 +1087,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	end_segno = (end >= MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
 						GET_SEGNO(sbi, end);
 	cpc.reason = CP_DISCARD;
-	cpc.trim_minlen = F2FS_BYTES_TO_BLK(range->minlen);
+	cpc.trim_minlen = max_t(__u64, 1, F2FS_BYTES_TO_BLK(range->minlen));
 
 	/* do checkpoint to issue discard commands safely */
 	for (; start_segno <= end_segno; start_segno = cpc.trim_end + 1) {
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
