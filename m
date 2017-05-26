From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs.f2fs: avoid wrong discard of dnode
Date: Thu, 25 May 2017 19:19:58 -0700
Message-ID: <20170526021958.54322-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dE4rJ-0006t2-Hh
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 May 2017 02:20:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dE4rI-0000gM-Ri
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 May 2017 02:20:09 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This can drop root inode, which can be caused by previous stale data.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 2e9c19a..67965ed 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -847,6 +847,10 @@ static int f2fs_write_super_block(void)
 static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 {
 	u_int64_t next_blkaddr = 0;
+	u_int64_t root_inode_pos = get_sb(main_blkaddr);
+
+	/* only root inode was written before truncating dnodes */
+	root_inode_pos += c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg;
 
 	if (c.zoned_mode)
 		return 0;
@@ -869,6 +873,9 @@ static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 			return -1;
 		}
 		offset = next_blkaddr;
+		/* should avoid recursive chain due to stale data */
+		if (offset == root_inode_pos)
+			break;
 	} while (1);
 
 	return 0;
-- 
2.13.0.rc1.294.g07d810a77f-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
