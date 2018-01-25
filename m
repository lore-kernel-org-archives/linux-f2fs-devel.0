From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: support large nat bitmap
Date: Thu, 25 Jan 2018 19:40:08 +0800
Message-ID: <20180125114008.88517-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eeftW-00026X-3o
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 11:40:38 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eeftU-0004Fs-Js
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 11:40:38 +0000
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously, we will store all nat version bitmap in checkpoint pack block,
so our total node entry number has a limitation which caused total node
number can not exceed (3900 * 8) block * 455 node/block = 14196000. So
that once user wants to create more nodes in large size image, it becomes
a bottleneck, that's unreasonable.

This patch detects the new layout of nat/sit version bitmap in image in
order to enable supporting large nat bitmap.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- rebase codes.
 fs/f2fs/f2fs.h          | 6 ++++++
 include/linux/f2fs_fs.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e580095a1cd2..6ac1c09419e2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1772,6 +1772,12 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
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
index 58aecb60ea51..f7f09907e69d 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -117,6 +117,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_LARGE_NAT_BITMAP_FLAG	0x00000400
 #define CP_NOCRC_RECOVERY_FLAG	0x00000200
 #define CP_TRIMMED_FLAG		0x00000100
 #define CP_NAT_BITS_FLAG	0x00000080
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
