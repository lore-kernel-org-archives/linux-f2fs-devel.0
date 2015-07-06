From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] fsck.f2fs: select to update the latest valid
	summary
Date: Mon,  6 Jul 2015 15:55:30 -0700
Message-ID: <1436223331-29064-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZCFIc-0005to-Lc
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Jul 2015 22:55:42 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZCFIb-00035M-LX for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Jul 2015 22:55:42 +0000
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

If two dnode blocks indicate one block address, it needs to keep the latest
valid address selectively.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index b15edbe..bbd4cab 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -191,6 +191,47 @@ out:
 	return ret;
 }
 
+static int is_valid_summary(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
+							u32 blk_addr)
+{
+	u16 ofs_in_node = le16_to_cpu(sum->ofs_in_node);
+	u32 nid = le32_to_cpu(sum->nid);
+	struct f2fs_node *node_blk = NULL;
+	__le32 target_blk_addr;
+	struct node_info ni;
+	int ret = 0;
+
+	node_blk = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
+	ASSERT(node_blk != NULL);
+
+	if (!IS_VALID_NID(sbi, nid))
+		goto out;
+
+	get_node_info(sbi, nid, &ni);
+
+	if (!IS_VALID_BLK_ADDR(sbi, ni.blk_addr))
+		goto out;
+
+	/* read node_block */
+	ret = dev_read_block(node_blk, ni.blk_addr);
+	ASSERT(ret >= 0);
+
+	if (le32_to_cpu(node_blk->footer.nid) != nid)
+		goto out;
+
+	/* check its block address */
+	if (node_blk->footer.nid == node_blk->footer.ino)
+		target_blk_addr = node_blk->i.i_addr[ofs_in_node];
+	else
+		target_blk_addr = node_blk->dn.addr[ofs_in_node];
+
+	if (blk_addr == le32_to_cpu(target_blk_addr))
+		ret = 1;
+out:
+	free(node_blk);
+	return ret;
+}
+
 static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 		u32 parent_nid, u16 idx_in_node, u8 version)
 {
@@ -238,6 +279,9 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 			DBG(0, "Target data block addr    [0x%x]\n", blk_addr);
 			ASSERT_MSG("Invalid data seg summary\n");
 			ret = -EINVAL;
+		} else if (is_valid_summary(sbi, sum_entry, blk_addr)) {
+			/* delete wrong index */
+			ret = -EINVAL;
 		} else {
 			FIX_MSG("Set data summary 0x%x -> [0x%x] [0x%x] [0x%x]",
 					segno, parent_nid, version, idx_in_node);
-- 
2.1.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
