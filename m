From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/3] f2fs: fix incorrect upper bound when
 iterating inode mapping tree
Date: Wed, 24 Feb 2016 17:20:44 +0800
Message-ID: <00e601d16ee4$c359b4d0$4a0d1e70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aYVdn-0000aY-PB
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 24 Feb 2016 09:21:51 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aYVdm-0003DI-JF
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 24 Feb 2016 09:21:51 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O3102LAGOO41AA0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 24 Feb 2016 18:21:42 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

1. Inode mapping tree can index page in range of [0, ULONG_MAX], however,
in some places, f2fs only search or iterate page in ragne of [0, LONG_MAX],
result in miss hitting in page cache.

2. filemap_fdatawait_range accepts range parameters in unit of bytes, so
the max range it covers should be [0, LLONG_MAX], if we use [0, LONG_MAX]
as range for waiting on writeback, big number of pages will not be covered.

This patch corrects above two issues.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 8 ++++----
 fs/f2fs/file.c       | 2 +-
 fs/f2fs/node.c       | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 64bbd06..9d277f8 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -282,7 +282,7 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 						long nr_to_write)
 {
 	struct address_space *mapping = META_MAPPING(sbi);
-	pgoff_t index = 0, end = LONG_MAX, prev = LONG_MAX;
+	pgoff_t index = 0, end = ULONG_MAX, prev = ULONG_MAX;
 	struct pagevec pvec;
 	long nwritten = 0;
 	struct writeback_control wbc = {
@@ -305,7 +305,7 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
-			if (prev == LONG_MAX)
+			if (prev == ULONG_MAX)
 				prev = page->index - 1;
 			if (nr_to_write != LONG_MAX && page->index != prev + 1) {
 				pagevec_release(&pvec);
@@ -1077,8 +1077,8 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
 
-	filemap_fdatawait_range(NODE_MAPPING(sbi), 0, LONG_MAX);
-	filemap_fdatawait_range(META_MAPPING(sbi), 0, LONG_MAX);
+	filemap_fdatawait_range(NODE_MAPPING(sbi), 0, LLONG_MAX);
+	filemap_fdatawait_range(META_MAPPING(sbi), 0, LLONG_MAX);
 
 	/* update user_block_counts */
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 935a60a..f326764 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -301,7 +301,7 @@ static pgoff_t __get_first_dirty_index(struct address_space *mapping,
 	pagevec_init(&pvec, 0);
 	nr_pages = pagevec_lookup_tag(&pvec, mapping, &pgofs,
 					PAGECACHE_TAG_DIRTY, 1);
-	pgofs = nr_pages ? pvec.pages[0]->index : LONG_MAX;
+	pgofs = nr_pages ? pvec.pages[0]->index : ULONG_MAX;
 	pagevec_release(&pvec);
 	return pgofs;
 }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 68506f4..7b613dd 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1238,7 +1238,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
 
 next_step:
 	index = 0;
-	end = LONG_MAX;
+	end = ULONG_MAX;
 
 	while (index <= end) {
 		int i, nr_pages;
@@ -1354,7 +1354,7 @@ continue_unlock:
 
 int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
 {
-	pgoff_t index = 0, end = LONG_MAX;
+	pgoff_t index = 0, end = ULONG_MAX;
 	struct pagevec pvec;
 	int ret2 = 0, ret = 0;
 
-- 
2.7.0



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
