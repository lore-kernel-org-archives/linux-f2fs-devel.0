From: Liu Xue <liuxueliu.liu@huawei.com>
Subject: [PATCH] mkfs.f2fs: fix wrong end blkaddr
Date: Tue, 10 Oct 2017 20:49:35 +0800
Message-ID: <1507639775-68398-1-git-send-email-liuxueliu.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <liuxueliu.liu@huawei.com>)
 id 1e1tz7-0003JP-G7
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Oct 2017 12:50:09 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e1tz5-0007i8-1i
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Oct 2017 12:50:09 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: liuxueliu.liu@huawei.com, linux-f2fs-devel@lists.sourceforge.net

The end blkaddr should use main blkaddr and add main area segments.
---
 mkfs/f2fs_format.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index b57f925..8a821d3 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -856,6 +856,8 @@ static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 {
 	u_int64_t next_blkaddr = 0;
 	u_int64_t root_inode_pos = get_sb(main_blkaddr);
+	u64 end_blkaddr = (get_sb(segment_count_main) <<
+			get_sb(log_blocks_per_seg)) + get_sb(main_blkaddr);
 
 	/* only root inode was written before truncating dnodes */
 	root_inode_pos += c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg;
@@ -863,8 +865,7 @@ static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 	if (c.zoned_mode)
 		return 0;
 	do {
-		if (offset < get_sb(main_blkaddr) ||
-			offset >= get_sb(main_blkaddr) + get_sb(block_count))
+		if (offset < get_sb(main_blkaddr) || offset >= end_blkaddr)
 			break;
 
 		if (dev_read_block(raw_node, offset)) {
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
