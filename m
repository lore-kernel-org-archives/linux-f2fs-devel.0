From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: fix to set CP_LARGE_NAT_BITMAP_FLAG
Date: Thu, 18 Apr 2019 15:49:09 +0800
Message-ID: <20190418074909.11102-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hH1nQ-0002qf-Pz
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Apr 2019 07:49:24 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hH1nO-00DtZ6-Op
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Apr 2019 07:49:24 +0000
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
Cc: jaegeuk@kernel.org

During fixing checkpoint, if large_nat_bitmap feature is on, we need to
set CP_LARGE_NAT_BITMAP_FLAG flag in checkpoint.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c  | 2 ++
 fsck/mount.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index a17555c..88ed4d7 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2038,6 +2038,8 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 		flags |= CP_TRIMMED_FLAG;
 	if (is_set_ckpt_flags(cp, CP_DISABLED_FLAG))
 		flags |= CP_DISABLED_FLAG;
+	if (is_set_ckpt_flags(cp, CP_LARGE_NAT_BITMAP_FLAG))
+		flags |= CP_LARGE_NAT_BITMAP_FLAG;
 
 	if (flags & CP_UMOUNT_FLAG)
 		cp_blocks = 8;
diff --git a/fsck/mount.c b/fsck/mount.c
index aa64e93..20ecf07 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2365,6 +2365,8 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 		flags |= CP_TRIMMED_FLAG;
 	if (is_set_ckpt_flags(cp, CP_DISABLED_FLAG))
 		flags |= CP_DISABLED_FLAG;
+	if (is_set_ckpt_flags(cp, CP_LARGE_NAT_BITMAP_FLAG))
+		flags |= CP_LARGE_NAT_BITMAP_FLAG;
 
 	set_cp(free_segment_count, get_free_segments(sbi));
 	set_cp(valid_block_count, sbi->total_valid_block_count);
-- 
2.18.0.rc1
