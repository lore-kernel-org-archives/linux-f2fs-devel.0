From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] f2fs: fix 32-bit build
Date: Tue, 22 Nov 2016 15:20:16 +0100
Message-ID: <20161122142033.1680054-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <arnd@arndb.de>) id 1c9Bwe-0008Kt-GH
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Nov 2016 14:21:12 +0000
Received: from mout.kundenserver.de ([212.227.126.131])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1c9Bwc-0003Uw-Uj for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Nov 2016 14:21:12 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Damien Le Moal <damien.lemoal@wdc.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

The addition of multiple-device support broke CONFIG_BLK_DEV_ZONED
on 32-bit machines because of a 64-bit division:

fs/f2fs/f2fs.o: In function `__issue_discard_async':
extent_cache.c:(.text.__issue_discard_async+0xd4): undefined reference to `__aeabi_uldivmod'

Unfortunately, the sector number is usually a 64-bit number, and
we probably can't guarantee that bdev_zone_size() returns a
power-of-two number, so we actually have to do the expensive 64-bit
operation to get the remainder.

Fixes: 792b84b74b54 ("f2fs: support multiple devices")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/f2fs/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 634834e5a232..e4c5497aa172 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -685,6 +685,7 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 {
 	sector_t nr_sects = SECTOR_FROM_BLOCK(blklen);
 	sector_t sector;
+	u32 rem;
 	int devi = 0;
 
 	if (sbi->s_ndevs) {
@@ -693,7 +694,8 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 	}
 	sector = SECTOR_FROM_BLOCK(blkstart);
 
-	if (sector % bdev_zone_size(bdev) || nr_sects != bdev_zone_size(bdev)) {
+	div_u64_rem(sector, bdev_zone_size(bdev), &rem);
+	if (rem || nr_sects != bdev_zone_size(bdev)) {
 		f2fs_msg(sbi->sb, KERN_INFO,
 			"(%d) %s: Unaligned discard attempted (block %x + %x)",
 			devi, sbi->s_ndevs ? FDEV(devi).path: "",
-- 
2.9.0


------------------------------------------------------------------------------
