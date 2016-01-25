From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/6] f2fs: do f2fs_balance_fs when block is
	allocated
Date: Mon, 25 Jan 2016 14:05:28 -0800
Message-ID: <1453759531-16076-3-git-send-email-jaegeuk@kernel.org>
References: <1453759531-16076-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aNpGf-00031u-1Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 22:05:49 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aNpGd-0007gj-LF for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 22:05:49 +0000
In-Reply-To: <1453759531-16076-1-git-send-email-jaegeuk@kernel.org>
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

We should consider data block allocation to trigger f2fs_balance_fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f057ada..89a37ba 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -542,7 +542,7 @@ static int __allocate_data_blocks(struct inode *inode, loff_t offset,
 	struct dnode_of_data dn;
 	u64 start = F2FS_BYTES_TO_BLK(offset);
 	u64 len = F2FS_BYTES_TO_BLK(count);
-	bool allocated;
+	bool allocated = false;
 	u64 end_offset;
 	int err = 0;
 
@@ -584,7 +584,7 @@ static int __allocate_data_blocks(struct inode *inode, loff_t offset,
 		f2fs_put_dnode(&dn);
 		f2fs_unlock_op(sbi);
 
-		f2fs_balance_fs(sbi, dn.node_changed);
+		f2fs_balance_fs(sbi, allocated);
 	}
 	return err;
 
@@ -594,7 +594,7 @@ sync_out:
 	f2fs_put_dnode(&dn);
 out:
 	f2fs_unlock_op(sbi);
-	f2fs_balance_fs(sbi, dn.node_changed);
+	f2fs_balance_fs(sbi, allocated);
 	return err;
 }
 
@@ -688,14 +688,14 @@ get_next:
 	if (dn.ofs_in_node >= end_offset) {
 		if (allocated)
 			sync_inode_page(&dn);
-		allocated = false;
 		f2fs_put_dnode(&dn);
 
 		if (create) {
 			f2fs_unlock_op(sbi);
-			f2fs_balance_fs(sbi, dn.node_changed);
+			f2fs_balance_fs(sbi, allocated);
 			f2fs_lock_op(sbi);
 		}
+		allocated = false;
 
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		err = get_dnode_of_data(&dn, pgofs, mode);
@@ -753,7 +753,7 @@ put_out:
 unlock_out:
 	if (create) {
 		f2fs_unlock_op(sbi);
-		f2fs_balance_fs(sbi, dn.node_changed);
+		f2fs_balance_fs(sbi, allocated);
 	}
 out:
 	trace_f2fs_map_blocks(inode, map, err);
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
