From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] f2fs: fix validation of the block count in sanity_check_raw_super
Date: Fri, 21 Dec 2018 20:28:20 +0100
Message-ID: <20181221192820.26222-2-martin.blumenstingl@googlemail.com>
References: <20181221192820.26222-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221192820.26222-1-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Treat "block_count" from struct f2fs_super_block as 64-bit little endian
value in sanity_check_raw_super() because struct f2fs_super_block
declares "block_count" as "__le64".

This fixes a bug where the superblock validation fails on big endian
devices with the following error:
  F2FS-fs (sda1): Wrong segment_count / block_count (61439 > 0)
  F2FS-fs (sda1): Can't find valid F2FS filesystem in 1th superblock
  F2FS-fs (sda1): Wrong segment_count / block_count (61439 > 0)
  F2FS-fs (sda1): Can't find valid F2FS filesystem in 2th superblock
As result of this the partition cannot be mounted.

With this patch applied the superblock validation works fine and the
partition can be mounted again:
  F2FS-fs (sda1): Mounted with checkpoint version = 7c84

My little endian x86-64 hardware was able to mount the partition without
this fix.
To confirm that mounting f2fs filesystems works on big endian machines
again I tested this on a 32-bit MIPS big endian (lantiq) device.

Fixes: 0cfe75c5b01199 ("f2fs: enhance sanity_check_raw_super() to avoid potential overflows")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index af58b2cc21b8..3a65d5af122a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2496,10 +2496,10 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		return 1;
 	}
 
-	if (segment_count > (le32_to_cpu(raw_super->block_count) >> 9)) {
+	if (segment_count > (le64_to_cpu(raw_super->block_count) >> 9)) {
 		f2fs_msg(sb, KERN_INFO,
 			"Wrong segment_count / block_count (%u > %u)",
-			segment_count, le32_to_cpu(raw_super->block_count));
+			segment_count, le64_to_cpu(raw_super->block_count));
 		return 1;
 	}
 
-- 
2.20.1
