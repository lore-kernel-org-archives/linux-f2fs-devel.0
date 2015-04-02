From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 8/8] fsck.f2fs: fix orphan inode's link count
Date: Thu,  2 Apr 2015 10:50:55 -0700
Message-ID: <1427997055-10715-8-git-send-email-jaegeuk@kernel.org>
References: <1427997055-10715-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YdjH0-0001K3-FN
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:22 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YdjGz-0002eK-NV for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:22 +0000
In-Reply-To: <1427997055-10715-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch fixes orphan inode's link count as 0.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 8211159..f3fbdfa 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -493,7 +493,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		if (f2fs_test_main_bitmap(sbi, ni->blk_addr) == 0) {
 			f2fs_set_main_bitmap(sbi, ni->blk_addr,
 							CURSEG_WARM_NODE);
-			if (i_links > 1) {
+			if (i_links > 1 && ftype != F2FS_FT_ORPHAN) {
 				/* First time. Create new hard link node */
 				add_into_hard_link_list(sbi, nid, i_links);
 				fsck->chk.multi_hard_link_files++;
@@ -666,9 +666,16 @@ skip_blkcnt_fix:
 		}
 	}
 
-	if (ftype == F2FS_FT_ORPHAN && i_links)
+	if (ftype == F2FS_FT_ORPHAN && i_links) {
 		ASSERT_MSG("ino: 0x%x is orphan inode, but has i_links: %u",
 				nid, i_links);
+		if (config.fix_on) {
+			node_blk->i.i_links = 0;
+			need_fix = 1;
+			FIX_MSG("ino: 0x%x orphan_inode, i_links= 0x%x -> 0",
+					nid, i_links);
+		}
+	}
 	if (need_fix) {
 		ret = dev_write_block(node_blk, ni->blk_addr);
 		ASSERT(ret >= 0);
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
