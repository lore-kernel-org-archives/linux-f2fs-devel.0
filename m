From: "Gaoxiang (OS)" <gaoxiang25@huawei.com>
Subject: [PATCH v2] resize.f2fs: fix max_nat_bitmap_size
 miscalculatation
Date: Fri, 22 Dec 2017 04:20:58 +0000
Message-ID: <9047C53C18267742AB12E43B65C7F9F70BCB8BD4@dggemi505-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <gaoxiang25@huawei.com>) id 1eSEpw-0001rP-Vx
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Dec 2017 04:21:32 +0000
Received: from [45.249.212.255] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eSEpv-0003Ee-I1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Dec 2017 04:21:32 +0000
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, "chao@kernel.org" <chao@kernel.org>, "Yuchao (T)" <yuchao0@huawei.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Duwei (Device OS)" <weidu.du@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

For the same reason as "mkfs.f2fs: fix to calculate
left space of checkpoint page correctly",
this patch also fixes miscalculatation in resize.f2fs.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fsck/resize.c      | 3 +--
 include/f2fs_fs.h  | 3 +++
 mkfs/f2fs_format.c | 4 +---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index 6c3eeab..143ad5d 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -60,8 +60,7 @@ static int get_new_sb(struct f2fs_super_block *sb)
 	 * It should be reserved minimum 1 segment for nat.
 	 * When sit is too large, we should expand cp area. It requires more pages for cp.
 	 */
-	if (max_sit_bitmap_size >
-			(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 65)) {
+	if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT) {
 		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
 		set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
 	} else {
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index d8d199f..d429a6f 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -651,6 +651,9 @@ struct f2fs_checkpoint {
 	unsigned char sit_nat_version_bitmap[1];
 } __attribute__((packed));
 
+#define MAX_SIT_BITMAP_SIZE_IN_CKPT	\
+	(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1 - 64)
+
 /*
  * For orphan inode management
  */
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 583b17f..a130001 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -291,9 +291,7 @@ static int f2fs_prepare_super_block(void)
 	 * When sit is too large, we should expand cp area. It requires more
 	 * pages for cp.
 	 */
-	if (max_sit_bitmap_size >
-			(CHECKSUM_OFFSET -
-				sizeof(struct f2fs_checkpoint) + 1 - 64)) {
+	if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT) {
 		max_nat_bitmap_size = CHECKSUM_OFFSET -
 				sizeof(struct f2fs_checkpoint) + 1;
 		set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
-- 
2.1.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
