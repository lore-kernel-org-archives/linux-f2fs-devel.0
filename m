From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 2/2] mkfs.f2fs: fix missing endian conversion
Date: Thu, 13 Nov 2014 20:15:05 +0900
Message-ID: <1415877305-4871-2-git-send-email-cm224.lee@samsung.com>
References: <1415877305-4871-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1415877305-4871-1-git-send-email-cm224.lee@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This is for conversion from cpu to little endian and vice versa.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 mkfs/f2fs_format.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 0a9d728..c0028a3 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -71,7 +71,7 @@ static void configure_extension_list(void)
 		memcpy(super_block.extension_list[i++], *extlist, name_len);
 		extlist++;
 	}
-	super_block.extension_count = i;
+	super_block.extension_count = cpu_to_le32(i);
 
 	if (!ext_str)
 		return;
@@ -86,7 +86,7 @@ static void configure_extension_list(void)
 			break;
 	}
 
-	super_block.extension_count = i;
+	super_block.extension_count = cpu_to_le32(i);
 
 	free(config.extension_list);
 }
@@ -211,7 +211,7 @@ static int f2fs_prepare_super_block(void)
 	if (max_sit_bitmap_size >
 			(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 65)) {
 		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
-		super_block.cp_payload = F2FS_BLK_ALIGN(max_sit_bitmap_size);
+		super_block.cp_payload = cpu_to_le32(F2FS_BLK_ALIGN(max_sit_bitmap_size));
 	} else {
 		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
 			- max_sit_bitmap_size;
-- 
1.9.1

