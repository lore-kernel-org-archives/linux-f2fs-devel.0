From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: fix to do sanity check with
 extra_attr feature
Date: Mon, 25 Jun 2018 20:39:09 +0800
Message-ID: <20180625123909.89648-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fXQn0-0005uv-Uv
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Jun 2018 12:40:14 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fXQmu-008MI7-MO
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Jun 2018 12:40:14 +0000
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

This patch tries to fix incorrect extra_attr bit or i_extra_isize value
in fsck.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 3572c6b3d6c1..9f549def3d4e 100644
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
+			node_blk->i.i_inline |= ~F2FS_INLINE_DATA;
+			need_fix = 1;
+		}
+	}
+	ofs = get_extra_isize(node_blk);
+
 	if ((node_blk->i.i_inline & F2FS_INLINE_DATA)) {
 		if (le32_to_cpu(node_blk->i.i_addr[ofs]) != 0) {
 			/* should fix this bug all the time */
-- 
2.18.0.rc1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
