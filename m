From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/2] f2fs: fix f2fs_write_meta_page at no
	checkpoint status
Date: Wed, 05 Feb 2014 14:36:35 +0900
Message-ID: <1391578595-854-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1391578595-854-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WAvBg-0004kW-9w
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Feb 2014 05:38:16 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WAvBe-0004LU-OJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Feb 2014 05:38:16 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N0I00L9TCZIQI10@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Feb 2014 14:38:06 +0900 (KST)
In-reply-to: <1391578595-854-1-git-send-email-jaegeuk.kim@samsung.com>
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

If f2fs entered errorneous checkpoint status, it should skip writing meta
pages instead of redirtying the pages out.
Otherwise, it cannot unmount the partition even though f2fs is under read-only
status.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c | 29 +++++++++++++++++++++--------
 fs/f2fs/gc.c         |  2 ++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 293d048..8f5dff1 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -81,17 +81,18 @@ static int f2fs_write_meta_page(struct page *page,
 	struct inode *inode = page->mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 
-	/* Should not write any meta pages, if any IO error was occurred */
-	if (unlikely(sbi->por_doing ||
-			is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ERROR_FLAG)))
+	if (unlikely(sbi->por_doing))
 		goto redirty_out;
-
 	if (wbc->for_reclaim)
 		goto redirty_out;
 
-	wait_on_page_writeback(page);
+	/* Should not write any meta pages, if any IO error was occurred */
+	if (unlikely(is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ERROR_FLAG)))
+		goto no_write;
 
+	wait_on_page_writeback(page);
 	write_meta_page(sbi, page);
+no_write:
 	dec_page_count(sbi, F2FS_DIRTY_META);
 	unlock_page(page);
 	return 0;
@@ -148,10 +149,22 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
+
 			lock_page(page);
-			f2fs_bug_on(page->mapping != mapping);
-			f2fs_bug_on(!PageDirty(page));
-			clear_page_dirty_for_io(page);
+
+			if (unlikely(page->mapping != mapping)) {
+continue_unlock:
+				unlock_page(page);
+				continue;
+			}
+			if (!PageDirty(page)) {
+				/* someone wrote it for us */
+				goto continue_unlock;
+			}
+
+			if (!clear_page_dirty_for_io(page))
+				goto continue_unlock;
+
 			if (f2fs_write_meta_page(page, &wbc)) {
 				unlock_page(page);
 				break;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ea0371e..b0f5762 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -701,6 +701,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi)
 gc_more:
 	if (unlikely(!(sbi->sb->s_flags & MS_ACTIVE)))
 		goto stop;
+	if (unlikely(is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ERROR_FLAG)))
+		goto stop;
 
 	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, nfree)) {
 		gc_type = FG_GC;
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
