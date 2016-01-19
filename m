From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/3] f2fs: simplify __allocate_data_blocks
Date: Tue, 19 Jan 2016 18:54:30 +0800
Message-ID: <001801d152a7$de4b06d0$9ae11470$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aLTwW-0007Dx-4I
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Jan 2016 10:55:20 +0000
Received: from [203.254.224.25] (helo=mailout2.samsung.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aLTwU-0005Df-9t
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Jan 2016 10:55:20 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O1702GVK4ZG8L00@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Jan 2016 19:55:11 +0900 (KST)
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

This patch uses existing function f2fs_map_block to simplify implementation
of __allocate_data_blocks.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 60 ++++------------------------------------------------------
 1 file changed, 4 insertions(+), 56 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3564e8e..284a123 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -500,64 +500,12 @@ alloc:
 static int __allocate_data_blocks(struct inode *inode, loff_t offset,
 							size_t count)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct dnode_of_data dn;
-	u64 start = F2FS_BYTES_TO_BLK(offset);
-	u64 len = F2FS_BYTES_TO_BLK(count);
-	bool allocated;
-	u64 end_offset;
-	int err = 0;
-
-	while (len) {
-		f2fs_lock_op(sbi);
-
-		/* When reading holes, we need its node page */
-		set_new_dnode(&dn, inode, NULL, NULL, 0);
-		err = get_dnode_of_data(&dn, start, ALLOC_NODE);
-		if (err)
-			goto out;
-
-		allocated = false;
-		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
-
-		while (dn.ofs_in_node < end_offset && len) {
-			block_t blkaddr;
-
-			if (unlikely(f2fs_cp_error(sbi))) {
-				err = -EIO;
-				goto sync_out;
-			}
-
-			blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
-			if (blkaddr == NULL_ADDR || blkaddr == NEW_ADDR) {
-				err = __allocate_data_block(&dn);
-				if (err)
-					goto sync_out;
-				allocated = true;
-			}
-			len--;
-			start++;
-			dn.ofs_in_node++;
-		}
-
-		if (allocated)
-			sync_inode_page(&dn);
-
-		f2fs_put_dnode(&dn);
-		f2fs_unlock_op(sbi);
+	struct f2fs_map_blocks map;
 
-		f2fs_balance_fs(sbi, dn.node_changed);
-	}
-	return err;
+	map.m_lblk = F2FS_BYTES_TO_BLK(offset);
+	map.m_len = F2FS_BYTES_TO_BLK(count);
 
-sync_out:
-	if (allocated)
-		sync_inode_page(&dn);
-	f2fs_put_dnode(&dn);
-out:
-	f2fs_unlock_op(sbi);
-	f2fs_balance_fs(sbi, dn.node_changed);
-	return err;
+	return f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_DIO);
 }
 
 /*
-- 
2.6.3



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
