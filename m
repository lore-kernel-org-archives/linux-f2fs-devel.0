From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: adjust the way of calculating nat block
Date: Wed, 08 Mar 2017 13:39:16 +0800
Message-ID: <000801d297ce$735eb750$5a1c25f0$@samsung.com>
References: <CGME20170308054010epcas5p1873bf561bd7ceac17a63a6e6cebb8365@epcas5p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1clUny-0006wE-H2
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 06:10:34 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1clUnw-0002YA-Cr
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 06:10:34 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OMH01J80EEYBH50@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 14:40:10 +0900 (KST)
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

use a slightly simpler expression to calculate nat block with nid.

Signed-off-by: Fan Li <fanofcode.li@samsung.com>
---
 fs/f2fs/node.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 2f9603f..f9fb5b8 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -200,13 +200,11 @@ static inline pgoff_t current_nat_addr(struct f2fs_sb_info *sbi, nid_t start)
        struct f2fs_nm_info *nm_i = NM_I(sbi);
        pgoff_t block_off;
        pgoff_t block_addr;
-       int seg_off;

        block_off = NAT_BLOCK_OFFSET(start);
-       seg_off = block_off >> sbi->log_blocks_per_seg;

        block_addr = (pgoff_t)(nm_i->nat_blkaddr +
-               (seg_off << sbi->log_blocks_per_seg << 1) +
+               (block_off << 1) -
                (block_off & (sbi->blocks_per_seg - 1)));

        if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
--
2.7.4


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
