From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: not allow to write illegal blkaddr
Date: Thu, 28 Jul 2016 12:12:38 +0800
Message-ID: <1469679158-17975-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1bSccf-0001uv-FP
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Jul 2016 04:08:37 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bSccc-0001L0-LJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Jul 2016 04:08:37 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao@huawei.com
Cc: heyunlei@huwei.com

we came across an error as below:

[build_nat_area_bitmap:1710] nid[0x    1718] addr[0x         1c18ddc] ino[0x    1718]
[build_nat_area_bitmap:1710] nid[0x    1719] addr[0x         1c193d5] ino[0x    1719]
[build_nat_area_bitmap:1710] nid[0x    171a] addr[0x         1c1736e] ino[0x    171a]
[build_nat_area_bitmap:1710] nid[0x    171b] addr[0x        58b3ee8f] ino[0x815f92ed]
[build_nat_area_bitmap:1710] nid[0x    171c] addr[0x         fcdc94b] ino[0x49366377]
[build_nat_area_bitmap:1710] nid[0x    171d] addr[0x        7cd2facf] ino[0xb3c55300]
[build_nat_area_bitmap:1710] nid[0x    171e] addr[0x        bd4e25d0] ino[0x77c34c09]

... ...

[build_nat_area_bitmap:1710] nid[0x    1718] addr[0x         1c18ddc] ino[0x    1718]
[build_nat_area_bitmap:1710] nid[0x    1719] addr[0x         1c193d5] ino[0x    1719]
[build_nat_area_bitmap:1710] nid[0x    171a] addr[0x         1c1736e] ino[0x    171a]
[build_nat_area_bitmap:1710] nid[0x    171b] addr[0x        58b3ee8f] ino[0x815f92ed]
[build_nat_area_bitmap:1710] nid[0x    171c] addr[0x         fcdc94b] ino[0x49366377]
[build_nat_area_bitmap:1710] nid[0x    171d] addr[0x        7cd2facf] ino[0xb3c55300]
[build_nat_area_bitmap:1710] nid[0x    171e] addr[0x        bd4e25d0] ino[0x77c34c09]

One nat block may be stepped by a data block, so this patch forbid to
write if the blkaddr is illegal

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b33f73e..87156c7 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -587,8 +587,8 @@ static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
 
 static inline void verify_block_addr(struct f2fs_sb_info *sbi, block_t blk_addr)
 {
-	f2fs_bug_on(sbi, blk_addr < SEG0_BLKADDR(sbi)
-					|| blk_addr >= MAX_BLKADDR(sbi));
+	BUG_ON(blk_addr < SEG0_BLKADDR(sbi)
+			|| blk_addr >= MAX_BLKADDR(sbi));
 }
 
 /*
-- 
1.9.1


------------------------------------------------------------------------------
