From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] fsck.f2fs: rebuild qf_ino if quota node is
 corrupted
Date: Mon, 23 Jul 2018 11:13:32 +0800
Message-ID: <20180723031332.190083-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fhRIR-0000aO-4t
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Jul 2018 03:14:03 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fhRIO-00GISQ-IX
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Jul 2018 03:14:03 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

If a quota node is corrupted, it may be removed. But its qf_ino in
super blocks is not cleared. To keep quota feature available, let's
try to rebuild a new quota node.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/fsck.c  | 82 +++++++++++++++++++++++++++++++++++++++++++++++++---
 fsck/fsck.h  |  1 +
 fsck/mount.c |  7 +++--
 3 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index e95dedf..dd10182 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -10,6 +10,7 @@
  */
 #include "fsck.h"
 #include "quotaio.h"
+#include "quotaio_v2.h"
 #include <time.h>
 
 char *tree_mark;
@@ -1697,13 +1698,80 @@ int fsck_chk_quota_node(struct f2fs_sb_info *sbi)
 		}
 		ret = fsck_chk_node_blk(sbi, NULL, ino,
 				F2FS_FT_REG_FILE, TYPE_INODE, &blk_cnt, NULL);
-		if (ret)
-			ASSERT_MSG("wrong quota inode, qtype [%d] ino [0x%x]",
-								qtype, ino);
+		if (ret) {
+			/* sanity_check_nid failed, node should be removed */
+			ASSERT_MSG("[0x%x] wrong quota inode", ino);
+			if (c.fix_on)
+				F2FS_FSCK(sbi)->corrupt_quotas = 1 << qtype;
+		}
 	}
 	return ret;
 }
 
+static nid_t prepare_rebuild_qf_inode(struct f2fs_sb_info *sbi, int qtype)
+{
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+	struct f2fs_summary sum;
+	struct f2fs_node *qf_node;
+	nid_t nid = QUOTA_INO(F2FS_RAW_SUPER(sbi), qtype);
+	block_t node_blkaddr;
+	int ret;
+
+	DBG(1, "Rebuild Quota file (qtype [%3d] ino [0x%x])\n", qtype, nid);
+
+	qf_node = calloc(F2FS_BLKSIZE, 1);
+	if (!qf_node) {
+		MSG(0, "\tError: calloc failed for qf_inode!!!\n");
+		return 0;
+	}
+
+	/* prepare qf_node */
+	qf_node->footer.nid = cpu_to_le32(nid);
+	qf_node->footer.ino = cpu_to_le32(nid);
+	qf_node->footer.cp_ver = cpu_to_le64(get_cp(checkpoint_ver));
+
+	qf_node->i.i_mode = cpu_to_le16(0x8180);
+	qf_node->i.i_links = cpu_to_le32(1);
+	qf_node->i.i_uid = cpu_to_le32(getuid());
+	qf_node->i.i_gid = cpu_to_le32(getgid());
+	qf_node->i.i_size = 0;
+	qf_node->i.i_blocks = 1;
+	qf_node->i.i_atime = cpu_to_le32(time(NULL));
+	qf_node->i.i_atime_nsec = 0;
+	qf_node->i.i_ctime = cpu_to_le32(time(NULL));
+	qf_node->i.i_ctime_nsec = 0;
+	qf_node->i.i_mtime = cpu_to_le32(time(NULL));
+	qf_node->i.i_mtime_nsec = 0;
+	qf_node->i.i_generation = 0;
+	qf_node->i.i_xattr_nid = 0;
+	qf_node->i.i_flags = FS_IMMUTABLE_FL;
+	qf_node->i.i_current_depth = cpu_to_le32(1);
+	qf_node->i.i_dir_level = DEF_DIR_LEVEL;
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
+		qf_node->i.i_inline = F2FS_EXTRA_ATTR;
+		qf_node->i.i_extra_isize =
+				cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
+	}
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME)) {
+		qf_node->i.i_crtime = cpu_to_le32(time(NULL));
+		qf_node->i.i_crtime_nsec = 0;
+	}
+
+	/* write back qf inode */
+	node_blkaddr = 0;
+	set_summary(&sum, nid, 0, 0);
+	reserve_new_block(sbi, &node_blkaddr, &sum, CURSEG_HOT_NODE);
+	update_nat_blkaddr(sbi, nid, nid, node_blkaddr);
+	DBG(1, "Write new qf_node to blk %#x\n", node_blkaddr);
+
+	ret = dev_write_block(qf_node, node_blkaddr);
+	ASSERT(ret >= 0);
+	f2fs_clear_bit(nid, F2FS_FSCK(sbi)->nat_area_bitmap);
+
+	free(qf_node);
+	return nid;
+}
+
 int fsck_chk_quota_files(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
@@ -1722,6 +1790,12 @@ int fsck_chk_quota_files(struct f2fs_sb_info *sbi)
 		if (!ino)
 			continue;
 
+		if (fsck->corrupt_quotas & (1 << qtype) && c.fix_on) {
+			ino = prepare_rebuild_qf_inode(sbi, qtype);
+			if (!ino)
+				continue;
+		}
+
 	        DBG(1, "Checking Quota file ([%3d] ino [0x%x])\n", qtype, ino);
 		needs_writeout = 0;
 		ret = quota_compare_and_update(sbi, qtype, &needs_writeout,
@@ -1733,7 +1807,7 @@ int fsck_chk_quota_files(struct f2fs_sb_info *sbi)
 
 		/* Something is wrong */
 		if (c.fix_on) {
-			DBG(0, "Fixing Quota file ([%3d] ino [0x%x])\n",
+			FIX_MSG("Fixing Quota file ([%3d] ino [0x%x])\n",
 							qtype, ino);
 			f2fs_filesize_update(sbi, ino, 0);
 			ret = quota_write_inode(sbi, qtype);
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 580e851..393c995 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -91,6 +91,7 @@ struct f2fs_fsck {
 	u32 nat_valid_inode_cnt;
 
 	struct quota_ctx *qctx;
+	unsigned short corrupt_quotas;
 };
 
 #define BLOCK_SZ		4096
diff --git a/fsck/mount.c b/fsck/mount.c
index 3c9607f..121b26a 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2022,8 +2022,11 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
 				if (se2->valid_blocks)
 					break;
 			}
-			if (i == sbi->segs_per_sec)
+			if (i == sbi->segs_per_sec) {
+				/* find a free seg, init its type */
+				se->orig_type = type;
 				return 0;
+			}
 		}
 
 		if (se->type == type &&
@@ -2244,7 +2247,7 @@ void write_superblock(struct f2fs_super_block *new_sb)
 		ASSERT(ret >= 0);
 	}
 	free(buf);
-	DBG(0, "Info: Done to rebuild superblock\n");
+	MSG(0, "Info: Done to rebuild superblock\n");
 }
 
 void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
