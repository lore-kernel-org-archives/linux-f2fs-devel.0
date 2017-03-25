From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/5] f2fs: allocate node and hot data in the
	beginning of partition
Date: Sat, 25 Mar 2017 00:59:31 -0700
Message-ID: <20170325075933.21072-3-jaegeuk@kernel.org>
References: <20170325075933.21072-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1crgc2-0000LB-F9
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 07:59:50 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1crgc1-0003wv-Of
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 07:59:50 +0000
In-Reply-To: <20170325075933.21072-1-jaegeuk@kernel.org>
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

In order to give more spatial locality, this patch changes the block allocation
policy to assign beginning of partition for small and hot blocks.

So, in main area, it tries to split cold data from all the other data types.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c      | 6 +++++-
 fs/f2fs/segment.c | 9 +++++++++
 fs/f2fs/super.c   | 1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index bbeee41aaf73..9d4158d55dbb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -172,7 +172,11 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 	if (gc_type != FG_GC && p->max_search > sbi->max_victim_search)
 		p->max_search = sbi->max_victim_search;
 
-	p->offset = sbi->last_victim[p->gc_mode];
+	/* let's select beginning hot/small space first */
+	if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
+		p->offset = 0;
+	else
+		p->offset = sbi->last_victim[p->gc_mode];
 }
 
 static unsigned int get_max_cost(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0cba28f95bb8..302d2accfe17 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1519,6 +1519,14 @@ static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
 	__set_sit_entry_type(sbi, type, curseg->segno, modified);
 }
 
+static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
+{
+	if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
+		return 0;
+
+	return CURSEG_I(sbi, type)->segno;
+}
+
 /*
  * Allocate a current working segment.
  * This function always allocates a free segment in LFS manner.
@@ -1537,6 +1545,7 @@ static void new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
 	if (test_opt(sbi, NOHEAP))
 		dir = ALLOC_RIGHT;
 
+	segno = __get_next_segno(sbi, type);
 	get_new_segment(sbi, &segno, new_sec, dir);
 	curseg->next_segno = segno;
 	reset_curseg(sbi, type, 1);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c4fa1ace8e55..32f08aeddcc5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1049,6 +1049,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
 	set_opt(sbi, EXTENT_CACHE);
+	set_opt(sbi, NOHEAP);
 	sbi->sb->s_flags |= MS_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
 	if (f2fs_sb_mounted_blkzoned(sbi->sb)) {
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
