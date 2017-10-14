From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs-tools: don't finalize device early
Date: Sat, 14 Oct 2017 12:22:52 -0700
Message-ID: <20171014192252.52845-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1e3S1X-0007tX-IL
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Oct 2017 19:23:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e3S1W-00007B-KI
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Oct 2017 19:23:03 +0000
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

We should close the device by main body of each tools.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 7a28314..c78314e 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1941,9 +1941,6 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 	if (flags & CP_NAT_BITS_FLAG)
 		write_nat_bits(sbi, sb, cp, sbi->cur_cp);
 
-	/* in case of sudden power off */
-	f2fs_finalize_device();
-
 	/* write the last cp */
 	ret = dev_write_block(cp, cp_blk_no++);
 	ASSERT(ret >= 0);
-- 
2.14.0.rc1.383.gd1ce394fe2-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
