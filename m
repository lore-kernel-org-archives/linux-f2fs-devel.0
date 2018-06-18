From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] resize.f2fs: fix wrong nat_bits migration
Date: Sun, 17 Jun 2018 17:39:48 -0700
Message-ID: <20180618003948.16479-2-jaegeuk@kernel.org>
References: <20180618003948.16479-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fUiDD-0001bW-FC
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Jun 2018 00:40:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fUiD9-00DAZr-I7
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Jun 2018 00:40:03 +0000
In-Reply-To: <20180618003948.16479-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

When wring the last nat_bits in new checkpoint, we call write_nat_bits()
to recover the nat_bits. But, we didn't update nm_i->nat_bitmap which we can
get the up-to-date nat blocks. After sit migration, old checkpoint has no
longer valid nat blocks, resulting in wrong free nid allocation at the following
mount time.

Let's indicate new nat_blocks by adjusting nat_bitmap in nat migration.

Reported-by: Lianjun Huang <huanglianjun@vivo.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/resize.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index 7643511..b2adf3e 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -339,8 +339,11 @@ static void migrate_nat(struct f2fs_sb_info *sbi,
 				(seg_off << sbi->log_blocks_per_seg << 1) +
 				(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
 
-		if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
+		/* move to set #0 */
+		if (f2fs_test_bit(block_off, nm_i->nat_bitmap)) {
 			block_addr += sbi->blocks_per_seg;
+			f2fs_clear_bit(block_off, nm_i->nat_bitmap);
+		}
 
 		ret = dev_read_block(nat_block, block_addr);
 		ASSERT(ret >= 0);
-- 
2.17.0.441.gb46fe60e1d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
