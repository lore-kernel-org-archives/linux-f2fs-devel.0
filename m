From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix 32-bit build
Date: Wed, 23 Nov 2016 10:42:26 -0800
Message-ID: <20161123184226.GB24137@jaegeuk>
References: <20161122142033.1680054-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161122142033.1680054-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chao Yu <yuchao0@huawei.com>, Yunlei He <heyunlei@huawei.com>, Damien Le Moal <damien.lemoal@wdc.com>, Fan Li <fanofcode.li@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Arnd,

As Damien mentioned, is this fine to go, if you don't mind?
I've confirmed that sd_zbc.c allows a power-of-two number only.

Thanks,

>From b709ff532daedc42526a46cb26860127f4959e01 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 22 Nov 2016 15:20:16 +0100
Subject: [PATCH] f2fs: fix 32-bit build

The addition of multiple-device support broke CONFIG_BLK_DEV_ZONED
on 32-bit machines because of a 64-bit division:

fs/f2fs/f2fs.o: In function `__issue_discard_async':
extent_cache.c:(.text.__issue_discard_async+0xd4): undefined reference to `__aeabi_uldivmod'

Unfortunately, the sector number is usually a 64-bit number, and
we guarantee that bdev_zone_size() returns a power-of-two number.

Fixes: 792b84b74b54 ("f2fs: support multiple devices")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index eaa0b40..d5141a0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -693,7 +693,8 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 	}
 	sector = SECTOR_FROM_BLOCK(blkstart);
 
-	if (sector % bdev_zone_size(bdev) || nr_sects != bdev_zone_size(bdev)) {
+	if (sector & (bdev_zone_size(bdev) - 1) ||
+				nr_sects != bdev_zone_size(bdev)) {
 		f2fs_msg(sbi->sb, KERN_INFO,
 			"(%d) %s: Unaligned discard attempted (block %x + %x)",
 			devi, sbi->s_ndevs ? FDEV(devi).path: "",
-- 
2.8.3
