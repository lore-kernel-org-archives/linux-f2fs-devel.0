From: Liu Xue <liuxueliu.liu@huawei.com>
Subject: [PATCH] f2fs-tools: calculate inode checksum and
 writeback
Date: Thu, 14 Jun 2018 11:10:22 +0800
Message-ID: <1528945822-85289-1-git-send-email-liuxueliu.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <liuxueliu.liu@huawei.com>) id 1fTIf8-0005yt-VI
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Jun 2018 03:11:02 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fTIf6-004qdu-BY
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Jun 2018 03:11:02 +0000
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
Cc: Liu Xue <liuxueliu.liu@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

Calculate inode checksum and writeback when processing
sload or resize.

Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>
---
 fsck/fsck.h    | 1 +
 fsck/mount.c   | 6 ++++--
 fsck/segment.c | 2 +-
 fsck/xattr.c   | 3 +--
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fsck/fsck.h b/fsck/fsck.h
index cbe7fc4..f90bcf9 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -221,6 +221,7 @@ int f2fs_resize(struct f2fs_sb_info *);
 int f2fs_sload(struct f2fs_sb_info *);
 
 /* segment.c */
+void write_inode(u64, struct f2fs_node *);
 void reserve_new_block(struct f2fs_sb_info *, block_t *,
 					struct f2fs_summary *, int);
 void new_data_block(struct f2fs_sb_info *, void *,
diff --git a/fsck/mount.c b/fsck/mount.c
index 0a30adb..87b6295 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1551,6 +1551,9 @@ void update_data_blkaddr(struct f2fs_sb_info *sbi, nid_t nid,
 
 		oldaddr = le32_to_cpu(node_blk->i.i_addr[ofs + ofs_in_node]);
 		node_blk->i.i_addr[ofs + ofs_in_node] = cpu_to_le32(newaddr);
+		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
+			node_blk->i.i_inode_checksum =
+				cpu_to_le32(f2fs_inode_chksum(node_blk));
 	} else {
 		oldaddr = le32_to_cpu(node_blk->dn.addr[ofs_in_node]);
 		node_blk->dn.addr[ofs_in_node] = cpu_to_le32(newaddr);
@@ -1574,8 +1577,7 @@ void update_data_blkaddr(struct f2fs_sb_info *sbi, nid_t nid,
 		node_blk->i.i_ext.len = 0;
 
 		/* update inode block */
-		ret = dev_write_block(node_blk, ni.blk_addr);
-		ASSERT(ret >= 0);
+		write_inode(ni.blk_addr, node_blk);
 	}
 	free(node_blk);
 }
diff --git a/fsck/segment.c b/fsck/segment.c
index 4f8bdb4..50f0d73 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -16,7 +16,7 @@
 #include "fsck.h"
 #include "node.h"
 
-static void write_inode(u64 blkaddr, struct f2fs_node *inode)
+void write_inode(u64 blkaddr, struct f2fs_node *inode)
 {
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
 		inode->i.i_inode_checksum =
diff --git a/fsck/xattr.c b/fsck/xattr.c
index 1d15d1b..7144a83 100644
--- a/fsck/xattr.c
+++ b/fsck/xattr.c
@@ -220,8 +220,7 @@ int f2fs_setxattr(struct f2fs_sb_info *sbi, nid_t ino, int index, const char *na
 	write_all_xattrs(sbi, inode, new_hsize, base_addr);
 
 	/* inode need update */
-	ret = dev_write_block(inode, ni.blk_addr);
-	ASSERT(ret >= 0);
+	write_inode(ni.blk_addr, inode);
 exit:
 	free(base_addr);
 	return error;
-- 
1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
