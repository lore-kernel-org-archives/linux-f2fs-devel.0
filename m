From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2] fsck.f2fs: fix to do sanity check with
 extra_attr feature
Date: Mon,  9 Jul 2018 23:25:41 +0800
Message-ID: <20180709152541.3396-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fcY3O-0006Wp-Mp
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Jul 2018 15:26:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fcY3M-004JuV-HB
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Jul 2018 15:26:18 +0000
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
Cc: linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch tries to fix incorrect extra_attr bit or i_extra_isize value
in fsck.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix to replace F2FS_INLINE_DATA with F2FS_EXTRA_ATTR.
 fsck/fsck.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 05a6301..36d1977 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -655,7 +655,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	u32 i_links = le32_to_cpu(node_blk->i.i_links);
 	u64 i_size = le64_to_cpu(node_blk->i.i_size);
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
-	int ofs = get_extra_isize(node_blk);
+	int ofs;
 	unsigned char *en;
 	int namelen;
 	unsigned int idx = 0;
@@ -719,6 +719,22 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			ftype == F2FS_FT_FIFO || ftype == F2FS_FT_SOCK)
 		goto check;
 
+	if (f2fs_has_extra_isize(&node_blk->i)) {
+		if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
+			if (node_blk->i.i_extra_isize >
+				cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE)) {
+				node_blk->i.i_extra_isize =
+					cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
+				need_fix = 1;
+			}
+		} else {
+			/* we don't support tuning F2FS_FEATURE_EXTRA_ATTR now */
+			node_blk->i.i_inline |= ~F2FS_EXTRA_ATTR;
+			need_fix = 1;
+		}
+	}
+	ofs = get_extra_isize(node_blk);
+
 	if ((node_blk->i.i_inline & F2FS_INLINE_DATA)) {
 		if (le32_to_cpu(node_blk->i.i_addr[ofs]) != 0) {
 			/* should fix this bug all the time */
-- 
2.16.2.17.g38e79b1fd


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
