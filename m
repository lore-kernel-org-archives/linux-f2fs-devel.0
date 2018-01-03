From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: show precise # of blocks that
 user/root can use
Date: Wed,  3 Jan 2018 10:58:44 -0800
Message-ID: <20180103185845.29953-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eWoFZ-0004lA-Ly
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jan 2018 18:58:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eWoFY-0005ao-SL
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jan 2018 18:58:53 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Let's show precise # of blocks that user/root can use through bavail and bfree
respectively.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0a820ba55b10..4c1c99cf54ef 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1005,9 +1005,9 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bsize = sbi->blocksize;
 
 	buf->f_blocks = total_count - start_count;
-	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
-	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
+	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
 						sbi->current_reserved_blocks;
+	buf->f_bavail = buf->f_bfree;
 
 	avail_node_count = sbi->total_node_count - sbi->nquota_files -
 						F2FS_RESERVED_NODE_NUM;
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
