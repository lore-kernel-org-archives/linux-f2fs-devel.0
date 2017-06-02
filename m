From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: simplify the way of calulating next nat
 address
Date: Fri, 02 Jun 2017 15:45:42 +0800
Message-ID: <003201d2db74$6be959f0$43bc0dd0$@samsung.com>
References: <CGME20170602074702epcas5p2afcfc8a3bb05e1916f6d93abe1958a5a@epcas5p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1dGhIf-0001yV-1D
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Jun 2017 07:47:13 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dGhIc-0006xQ-MY
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Jun 2017 07:47:13 +0000
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Chao Yu' <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

The index of segment which the next nat block is in has only one different
bit than the current one, so to get the next nat address, we can simply
alter that one bit.

Signed-off-by: Fan Li <fanofcode.li@samsung.com>
---
 fs/f2fs/node.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 558048e..da0b21b 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -224,10 +224,7 @@ static inline pgoff_t next_nat_addr(struct f2fs_sb_info *sbi,
        struct f2fs_nm_info *nm_i = NM_I(sbi);

        block_addr -= nm_i->nat_blkaddr;
-       if ((block_addr >> sbi->log_blocks_per_seg) % 2)
-               block_addr -= sbi->blocks_per_seg;
-       else
-               block_addr += sbi->blocks_per_seg;
+       block_addr ^= 1 << sbi->log_blocks_per_seg;

        return block_addr + nm_i->nat_blkaddr;
 }
--
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
