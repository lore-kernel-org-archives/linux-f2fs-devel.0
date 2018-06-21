From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] fsck.f2fs: clear qf_ino if quota node is removed
Date: Thu, 21 Jun 2018 16:51:38 +0800
Message-ID: <20180621085138.195409-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fVvKC-0006xF-1T
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Jun 2018 08:52:16 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fVvKA-00GfuH-4T
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Jun 2018 08:52:15 +0000
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

If a quota node is corrupted, it may be removed. Then its qf_ino should
also be removed.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/fsck.c  | 19 +++++++++++++++++--
 fsck/fsck.h  |  1 +
 fsck/mount.c |  2 +-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 8145199..8418bdb 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1675,8 +1675,13 @@ int fsck_chk_quota_node(struct f2fs_sb_info *sbi)
 		}
 		ret = fsck_chk_node_blk(sbi, NULL, ino,
 				F2FS_FT_REG_FILE, TYPE_INODE, &blk_cnt, NULL);
-		if (ret)
-			ASSERT_MSG("[0x%x] wrong orphan inode", ino);
+		if (ret) {
+			/* sanity_check_nid failed, node should be removed */
+			ASSERT_MSG("[0x%x] wrong quota inode", ino);
+			sb->qf_ino[qtype] = 0;
+			if (c.fix_on)
+				F2FS_FSCK(sbi)->chk.fix_sb = 1;
+		}
 	}
 	return ret;
 }
@@ -2004,6 +2009,15 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 		write_nat_bits(sbi, sb, cp, sbi->cur_cp);
 }
 
+static void fix_superblock(struct f2fs_sb_info *sbi)
+{
+	if (!F2FS_FSCK(sbi)->chk.fix_sb)
+		return;
+
+	write_superblock(F2FS_RAW_SUPER(sbi));
+	F2FS_FSCK(sbi)->chk.fix_sb = 0;
+}
+
 int check_curseg_offset(struct f2fs_sb_info *sbi)
 {
 	int i;
@@ -2584,6 +2598,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 				flush_curseg_sit_entries(sbi);
 			}
 			fix_checkpoint(sbi);
+			fix_superblock(sbi);
 		} else if (is_set_ckpt_flags(cp, CP_FSCK_FLAG)) {
 			write_checkpoint(sbi);
 		}
diff --git a/fsck/fsck.h b/fsck/fsck.h
index f90bcf9..60cdf23 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -69,6 +69,7 @@ struct f2fs_fsck {
 		u32 multi_hard_link_files;
 		u64 sit_valid_blocks;
 		u32 sit_free_segs;
+		int fix_sb;
 	} chk;
 
 	struct hard_link_node *hard_link_list_head;
diff --git a/fsck/mount.c b/fsck/mount.c
index 7912605..7e908f1 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2165,7 +2165,7 @@ void write_superblock(struct f2fs_super_block *new_sb)
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
