From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] mkfs.f2fs: remove extent_cache entry for
	parent directory
Date: Tue, 15 Dec 2015 13:19:32 -0800
Message-ID: <1450214374-65696-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a8x0Z-0004rr-Js
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 21:19:43 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a8x0Y-0004GG-Ns for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 21:19:43 +0000
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

Currently, directory should not have any extent cache entry.
Otherwise, fsck.f2fs will trigger a false-alarmed report.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index fff74a9..98a6bce 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -769,8 +769,8 @@ static int f2fs_write_root_inode(void)
 	raw_node->i.i_addr[0] = cpu_to_le32(data_blk_nor);
 
 	raw_node->i.i_ext.fofs = 0;
-	raw_node->i.i_ext.blk_addr = cpu_to_le32(data_blk_nor);
-	raw_node->i.i_ext.len = cpu_to_le32(1);
+	raw_node->i.i_ext.blk_addr = 0;
+	raw_node->i.i_ext.len = 0;
 
 	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
 	main_area_node_seg_blk_offset += config.cur_seg[CURSEG_HOT_NODE] *
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
