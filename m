From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: relocate chksum_offset for
 large_nat_bitmap feature
Date: Fri, 19 Apr 2019 16:02:54 +0800
Message-ID: <20190419080254.19867-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hHOUK-0005TA-1f
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Apr 2019 08:03:12 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hHOUI-00FpvP-Aq
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Apr 2019 08:03:11 +0000
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

For large_nat_bitmap feature, there is a design flaw:

Previous:

struct f2fs_checkpoint layout:
+--------------------------+  0x0000
| checkpoint_ver           |
| ......                   |
| checksum_offset          |------+
| ......                   |      |
| sit_nat_version_bitmap[] |<-----|-------+
| ......                   |      |       |
| checksum_value           |<-----+       |
+--------------------------+  0x1000      |
|                          |      nat_bitmap + sit_bitmap
| payload blocks           |              |
|                          |              |
+--------------------------|<-------------+

Obviously, if nat_bitmap size + sit_bitmap size is larger than
MAX_BITMAP_SIZE_IN_CKPT, nat_bitmap or sit_bitmap may overlap
checkpoint checksum's position, once checkpoint() is triggered
from kernel, nat or sit bitmap will be damaged by checksum field.

In order to fix this, let's relocate checksum_value's position
to the head of sit_nat_version_bitmap as below, then nat/sit
bitmap and chksum value update will become safe.

After:

struct f2fs_checkpoint layout:
+--------------------------+  0x0000
| checkpoint_ver           |
| ......                   |
| checksum_offset          |------+
| ......                   |      |
| sit_nat_version_bitmap[] |<-----+
| ......                   |<-------------+
|                          |              |
+--------------------------+  0x1000      |
|                          |      nat_bitmap + sit_bitmap
| payload blocks           |              |
|                          |              |
+--------------------------|<-------------+

Related report and discussion:

https://sourceforge.net/p/linux-f2fs/mailman/message/36642346/

Reported-by: Park Ju Hyung <qkrwngud825@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- allow get_checkpoint_version() to detect deprecated layout of
large_nat_bitmap.
 fs/f2fs/checkpoint.c | 12 ++++++++++++
 fs/f2fs/f2fs.h       |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 08b339c665a1..6eb51dd1f22a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -816,6 +816,18 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
 		return -EINVAL;
 	}
 
+	if (__is_set_ckpt_flags(*cp_block, CP_LARGE_NAT_BITMAP_FLAG)) {
+		if (crc_offset != offsetof(struct f2fs_checkpoint,
+						sit_nat_version_bitmap)) {
+			f2fs_put_page(*cp_page, 1);
+			f2fs_msg(sbi->sb, KERN_WARNING,
+				"layout of large_nat_bitmap is deprecated, "
+				"run fsck to repair, chksum_offset: %zu",
+				crc_offset);
+			return -EINVAL;
+		}
+	}
+
 	crc = cur_cp_crc(*cp_block);
 	if (!f2fs_crc_valid(sbi, crc, *cp_block, crc_offset)) {
 		f2fs_put_page(*cp_page, 1);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 31531711e148..f5ffc09705eb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1911,7 +1911,11 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 	if (is_set_ckpt_flags(sbi, CP_LARGE_NAT_BITMAP_FLAG)) {
 		offset = (flag == SIT_BITMAP) ?
 			le32_to_cpu(ckpt->nat_ver_bitmap_bytesize) : 0;
-		return &ckpt->sit_nat_version_bitmap + offset;
+		/*
+		 * if large_nat_bitmap feature is enabled, leave checksum
+		 * protection for all nat/sit bitmaps.
+		 */
+		return &ckpt->sit_nat_version_bitmap + offset + sizeof(__le32);
 	}
 
 	if (__cp_payload(sbi) > 0) {
-- 
2.18.0.rc1
