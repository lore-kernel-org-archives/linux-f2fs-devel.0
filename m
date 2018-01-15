From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: support large nat bitmap
Date: Mon, 15 Jan 2018 17:16:56 +0800
Message-ID: <20180115091656.46703-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, we will store all nat version bitmap in checkpoint pack block,
so our total node entry number has a limitation which caused total node
number can not exceed (3900 * 8) block * 455 node/block = 14196000. So
that once user wants to create more nodes in large size image, it becomes
a bottleneck, that's unreasonable.

This patch detects the new layout of nat/sit version bitmap in image in
order to enable supporting large nat bitmap.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h          | 6 ++++++
 include/linux/f2fs_fs.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e4930d4f1218..d6c2c7c265a0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1758,6 +1758,12 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	int offset;
 
+	if (is_set_ckpt_flags(sbi, CP_LARGE_NAT_BITMAP_FLAG)) {
+		offset = (flag == SIT_BITMAP) ?
+			le32_to_cpu(ckpt->nat_ver_bitmap_bytesize) : 0;
+		return &ckpt->sit_nat_version_bitmap + offset;
+	}
+
 	if (__cp_payload(sbi) > 0) {
 		if (flag == NAT_BITMAP)
 			return &ckpt->sit_nat_version_bitmap;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index cfb522e6affc..7d71c75cebeb 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -117,6 +117,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_LARGE_NAT_BITMAP_FLAG	0x00000200
 #define CP_TRIMMED_FLAG		0x00000100
 #define CP_NAT_BITS_FLAG	0x00000080
 #define CP_CRC_RECOVERY_FLAG	0x00000040
-- 
2.15.0.55.gc2ece9dc4de6
