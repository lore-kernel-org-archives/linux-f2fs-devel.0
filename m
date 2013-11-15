From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 4/5] f2fs: introduce f2fs_issue_discard() to
	clean up
Date: Fri, 15 Nov 2013 14:20:23 +0900
Message-ID: <1384492824-32483-4-git-send-email-jaegeuk.kim@samsung.com>
References: <1384492824-32483-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VhBqY-0003Y9-HD
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Nov 2013 05:21:34 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VhBqX-0005wy-NY for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Nov 2013 05:21:34 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWA00FCWHJE4QO0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Nov 2013 14:21:14 +0900 (KST)
In-reply-to: <1384492824-32483-1-git-send-email-jaegeuk.kim@samsung.com>
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

This patch adds f2fs_issue_discard() to clean up blkdev_issue_discard() flows.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/segment.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 505a889..d021cf3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -266,6 +266,16 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 	mutex_unlock(&dirty_i->seglist_lock);
 }
 
+static void f2fs_issue_discard(struct f2fs_sb_info *sbi,
+				block_t blkstart, block_t blklen)
+{
+	sector_t sector_addr = blkstart << sbi->log_sectors_per_block;
+	sector_t sector_len = blklen << sbi->log_sectors_per_block;
+
+	blkdev_issue_discard(sbi->sb->s_bdev, sector_addr, sector_len,
+							GFP_NOFS, 0);
+}
+
 static void add_discard_addrs(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct seg_entry *se)
 {
@@ -354,22 +364,15 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi)
 		if (!test_opt(sbi, DISCARD))
 			continue;
 
-		blkdev_issue_discard(sbi->sb->s_bdev,
-				START_BLOCK(sbi, start) <<
-				sbi->log_sectors_per_block,
-				(1 << (sbi->log_sectors_per_block +
-				sbi->log_blocks_per_seg)) * (end - start),
-				GFP_NOFS, 0);
+		f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
+				(end - start) << sbi->log_blocks_per_seg);
 	}
 	mutex_unlock(&dirty_i->seglist_lock);
 
 	/* send small discards */
 	list_for_each_safe(this, next, head) {
 		entry = list_entry(this, struct discard_entry, list);
-		blkdev_issue_discard(sbi->sb->s_bdev,
-				entry->blkaddr << sbi->log_sectors_per_block,
-				(1 << sbi->log_sectors_per_block) * entry->len,
-				GFP_NOFS, 0);
+		f2fs_issue_discard(sbi, entry->blkaddr, entry->len);
 		list_del(&entry->list);
 		SM_I(sbi)->nr_discards -= entry->len;
 		kmem_cache_free(discard_entry_slab, entry);
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
