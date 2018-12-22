From: Martin Blumenstingl via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH v2 1/1] f2fs: fix validation of the block count
 in sanity_check_raw_super
Date: Sat, 22 Dec 2018 11:22:26 +0100
Message-ID: <20181222102226.10050-2-martin.blumenstingl@googlemail.com>
References: <20181222102226.10050-1-martin.blumenstingl@googlemail.com>
Reply-To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <martin.blumenstingl@googlemail.com>)
 id 1gaeQc-0006Zg-Vf
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 22 Dec 2018 10:22:42 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gaeQb-00DR4j-Ey
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 22 Dec 2018 10:22:42 +0000
Received: by mail-wm1-f66.google.com with SMTP id y139so7382282wmc.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 22 Dec 2018 02:22:41 -0800 (PST)
In-Reply-To: <20181222102226.10050-1-martin.blumenstingl@googlemail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com, jaegeuk@kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org

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
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index af58b2cc21b8..d3911d3f948b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2496,10 +2496,10 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		return 1;
 	}
 
-	if (segment_count > (le32_to_cpu(raw_super->block_count) >> 9)) {
+	if (segment_count > (le64_to_cpu(raw_super->block_count) >> 9)) {
 		f2fs_msg(sb, KERN_INFO,
-			"Wrong segment_count / block_count (%u > %u)",
-			segment_count, le32_to_cpu(raw_super->block_count));
+			"Wrong segment_count / block_count (%u > %llu)",
+			segment_count, le64_to_cpu(raw_super->block_count));
 		return 1;
 	}
 
-- 
2.20.1
