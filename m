From: "Gaoxiang (OS)" <gaoxiang25@huawei.com>
Subject: [f2fs-dev] [PATCH] resize.f2fs: fix max_nat_bitmap_size
 miscalculatation
Date: Fri, 22 Dec 2017 03:41:54 +0000
Message-ID: <9047C53C18267742AB12E43B65C7F9F70BCB8B7F@dggemi505-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Language: zh-CN
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, "chao@kernel.org" <chao@kernel.org>, "Yuchao (T)" <yuchao0@huawei.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes max_nat_bitmap_size miscalculatation

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fsck/resize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index 6c3eeab..4f3844c 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -61,7 +61,7 @@ static int get_new_sb(struct f2fs_super_block *sb)
 	 * When sit is too large, we should expand cp area. It requires more pages for cp.
 	 */
 	if (max_sit_bitmap_size >
-			(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 65)) {
+			(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1 - 64)) {
 		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
 		set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
 	} else {
-- 
2.1.4
