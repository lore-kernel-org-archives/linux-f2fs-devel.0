From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: support checkpoint=disable
Date: Wed, 26 Sep 2018 22:27:40 -0700
Message-ID: <20180927052740.75568-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1g5Oq9-0003YR-0U
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Sep 2018 05:27:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g5Oq3-005A08-Mx
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Sep 2018 05:27:52 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch shows checkpoint is disabled and keeps the flag for next mount.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c       | 2 ++
 fsck/mount.c      | 4 ++++
 include/f2fs_fs.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 19220e2..ca4e74e 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1998,6 +1998,8 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 		orphan_blks = __start_sum_addr(sbi) - 1;
 		flags |= CP_ORPHAN_PRESENT_FLAG;
 	}
+	if (is_set_ckpt_flags(cp, CP_DISABLED_FLAG))
+		flags |= CP_DISABLED_FLAG;
 
 	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_sb(cp_payload));
 
diff --git a/fsck/mount.c b/fsck/mount.c
index 2b0289e..21e1dc8 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -424,6 +424,8 @@ void print_cp_state(u32 flag)
 		MSG(0, "%s", " compacted_summary");
 	if (flag & CP_ORPHAN_PRESENT_FLAG)
 		MSG(0, "%s", " orphan_inodes");
+	if (flag & CP_DISABLED_FLAG)
+		MSG(0, "%s", " disabled");
 	if (flag & CP_UMOUNT_FLAG)
 		MSG(0, "%s", " unmount");
 	else
@@ -2242,6 +2244,8 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 		orphan_blks = __start_sum_addr(sbi) - 1;
 		flags |= CP_ORPHAN_PRESENT_FLAG;
 	}
+	if (is_set_ckpt_flags(cp, CP_DISABLED_FLAG))
+		flags |= CP_DISABLED_FLAG;
 
 	set_cp(free_segment_count, get_free_segments(sbi));
 	set_cp(valid_block_count, sbi->total_valid_block_count);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index dab8b40..e3b4529 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -635,6 +635,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_DISABLED_FLAG		0x00001000
 #define CP_LARGE_NAT_BITMAP_FLAG	0x00000400
 #define CP_NOCRC_RECOVERY_FLAG	0x00000200
 #define CP_TRIMMED_FLAG		0x00000100
-- 
2.17.0.441.gb46fe60e1d-goog
